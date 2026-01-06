package alternativa.tanks.models.weapon.artillery
{
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.loaders.Parser3DS;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryShellEffects;
   import alternativa.tanks.models.weapons.shell.InelasticShell;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryCC;
   
   public class ArtilleryShell extends InelasticShell
   {
      
      public static var shellMesh:Mesh;
      
      [Inject]
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      private static const shellClass:Class = ArtilleryShell_shellClass;
      
      private static const shellTextureClass:Class = ArtilleryShell_shellTextureClass;
      
      private static var shellTexture:BitmapData = (new shellTextureClass() as Bitmap).bitmapData;
      
      private var impactForce:Number;
      
      private var weaponObject:ArtilleryObject;
      
      private var material:TextureMaterial;
      
      private var view:Mesh;
      
      private var params:ArtilleryCC;
      
      private var speed:Number;
      
      private var velocity:Vector3;
      
      private var prevDirection:Vector3;
      
      private var interpolatedDirection:Vector3;
      
      private var elevationAxis:Vector3;
      
      private var shellEffects:ArtilleryShellEffects;
      
      public function ArtilleryShell(param1:Pool)
      {
         var _loc2_:Parser3DS = null;
         this.velocity = new Vector3();
         this.prevDirection = new Vector3();
         this.interpolatedDirection = new Vector3();
         this.elevationAxis = new Vector3();
         super(param1);
         if(shellMesh == null)
         {
            _loc2_ = new Parser3DS();
            _loc2_.parse(new shellClass());
            shellMesh = Mesh(_loc2_.objects[0]);
            if(shellMesh.sorting != Sorting.DYNAMIC_BSP)
            {
               shellMesh.sorting = Sorting.DYNAMIC_BSP;
               shellMesh.calculateFacesNormals(true);
               shellMesh.optimizeForDynamicBSP();
            }
         }
         this.view = Mesh(shellMesh.clone());
      }
      
      public static function moveShell(param1:Number, param2:Vector3, param3:Vector3, param4:Vector3, param5:Vector3, param6:Vector3, param7:Number) : void
      {
         param3.copy(param2);
         param5.copy(param4);
         var _loc8_:Number = battleService.getBattleRunner().getGravity() * param7;
         param2.addScaled(param1,param6).addScaled(param1 * param1 / 2 * _loc8_,Vector3.Z_AXIS);
         param6.addScaled(_loc8_ * param1,Vector3.Z_AXIS);
         param4.copy(param6).normalize();
      }
      
      public function init(param1:ArtilleryObject, param2:ArtilleryCC, param3:Number) : void
      {
         this.params = param2;
         this.speed = param3;
         this.impactForce = param1.commonData().getImpactForce();
         this.weaponObject = param1;
         this.material = textureMaterialRegistry.getMaterial(shellTexture);
         this.view.setMaterialToAllFaces(this.material);
      }
      
      override public function addToGame(param1:AllGlobalGunParams, param2:Vector3, param3:Body, param4:Boolean, param5:int) : void
      {
         super.addToGame(param1,param2,param3,param4,param5);
         this.velocity.copy(param2).scale(this.speed);
         battleService.getBattleScene3D().addObject(this.view);
         this.prevDirection.copy(param2);
         this.elevationAxis.copy(param1.elevationAxis);
         this.shellEffects = new ArtilleryShellEffects(this.view,this.weaponObject.sfx().getSfxData(),this.velocity,param1,param2,this.params.shellGravityCoef);
      }
      
      override protected function getSpeed() : Number
      {
         return this.speed;
      }
      
      override protected function isFlightFinished() : Boolean
      {
         return super.isFlightFinished() || currPosition.z < battleService.getBattleScene3D().getMapMinZ() - 1000;
      }
      
      override protected function updatePosition(param1:Number) : void
      {
         if(this.weaponObject.isAlive())
         {
            moveShell(param1,currPosition,prevPosition,flightDirection,this.prevDirection,this.velocity,this.params.shellGravityCoef);
            this.shellEffects.updateShellPosition();
         }
         else
         {
            this.destroy();
         }
      }
      
      override public function interpolatePhysicsState(param1:Number) : void
      {
         super.interpolatePhysicsState(param1);
         this.interpolatedDirection.interpolate(param1,this.prevDirection,flightDirection);
         this.interpolatedDirection.normalize();
      }
      
      override protected function processHitImpl(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:int) : void
      {
         var _loc6_:Tank = null;
         super.processHitImpl(param1,param2,param3,param4,param5);
         if(this.weaponObject == null)
         {
            return;
         }
         if(!this.weaponObject.isAlive())
         {
            this.destroy();
            return;
         }
         this.weaponObject.splash().applySplashForce(param2,1,param1);
         if(BattleUtils.isTankBody(param1))
         {
            _loc6_ = param1.tank;
            _loc6_.applyWeaponHit(param2,param3,this.impactForce);
            this.weaponObject.shellCommunication().tryToHit(getShotId(),shellStates,param1.tank);
         }
         else
         {
            this.weaponObject.shellCommunication().tryToHit(getShotId(),shellStates);
         }
         this.shellEffects.createExplosionEffect(param2,param3);
         this.destroy();
      }
      
      override public function render(param1:int, param2:int) : void
      {
         var _loc3_:Number = param2 / thousandth.getInt();
         this.view.x = interpolatedPosition.x;
         this.view.y = interpolatedPosition.y;
         this.view.z = interpolatedPosition.z;
         var _loc4_:Matrix3 = BattleUtils.tmpMatrix3;
         _loc4_.setAxis(this.elevationAxis,this.interpolatedDirection,BattleUtils.tmpVector.cross2(this.elevationAxis,this.interpolatedDirection).normalize());
         var _loc5_:Vector3 = BattleUtils.tmpVector;
         _loc4_.getEulerAngles(_loc5_);
         this.view.rotationX = _loc5_.x;
         this.view.rotationY = _loc5_.y;
         this.view.rotationZ = _loc5_.z;
         this.shellEffects.updateTrail(_loc3_);
      }
      
      override protected function destroy() : void
      {
         super.destroy();
         battleService.getBattleScene3D().removeObject(this.view);
         shooterBody = null;
         textureMaterialRegistry.releaseMaterial(this.material);
         this.view.colorTransform = null;
         this.weaponObject = null;
         this.shellEffects.destroy();
         this.shellEffects = null;
      }
      
      override protected function getRadius() : Number
      {
         return this.params.shellRadius;
      }
   }
}

