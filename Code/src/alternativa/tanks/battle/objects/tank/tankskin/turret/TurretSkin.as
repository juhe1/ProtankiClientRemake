package alternativa.tanks.battle.objects.tank.tankskin.turret
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.engine3d.core.Shadow;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
   import alternativa.tanks.battle.scene3d.Object3DNames;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import projects.tanks.clients.flash.resources.tanks.Tank3D;
   import alternativa.tanks.battle.objects.tank.tankskin.TankTurretDynamicSkin;
   
   public class TurretSkin
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      public static const turretMatrix:Matrix4 = new Matrix4();
      
      protected var turretMeshes:Vector.<Mesh>;
      
      protected var rootObject:Object3D;

      private var turretDynamicSkin:TankTurretDynamicSkin;
      
      public function TurretSkin(param1:Tanks3DSResource)
      {
         var _loc2_:Object3D = null;
         var _loc3_:Dictionary = null;
         var _loc4_:int = 0;
         var _loc5_:Mesh = null;
         var _loc6_:Mesh = null;
         var _loc7_:Object3DContainer = null;
         var _loc8_:Object3D = null;
         var _loc9_:Object3DContainer = null;
         this.turretMeshes = new Vector.<Mesh>();
         super();
         for each(_loc2_ in param1.objects)
         {
            if(_loc2_ is Mesh && !Tank3D.EXCLUDED.test(_loc2_.name))
            {
               this.turretMeshes.push(_loc2_);
            }
         }
         _loc3_ = new Dictionary();
         _loc4_ = this.turretMeshes.length - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = this.turretMeshes[_loc4_];
            _loc6_ = Tank3D.cloneMesh(_loc5_);
            _loc6_.mouseEnabled = false;
            _loc7_ = _loc3_[_loc5_];
            if(_loc7_ != null)
            {
               copyPosition(_loc7_,_loc6_);
               _loc7_.addChild(_loc6_);
               setPosition(_loc6_,Vector3.ZERO);
            }
            _loc8_ = param1.parents[param1.objects.indexOf(_loc5_)];
            if(_loc8_ != null)
            {
               if(_loc8_ in _loc3_)
               {
                  _loc9_ = _loc3_[_loc8_];
               }
               else
               {
                  _loc9_ = new Object3DContainer();
                  _loc3_[_loc8_] = _loc9_;
               }
               _loc9_.addChild(_loc3_[_loc5_] != null ? _loc3_[_loc5_] : _loc6_);
               _loc9_.mouseEnabled = false;
            }
            this.turretMeshes[this.turretMeshes.indexOf(_loc5_)] = _loc6_;
            _loc4_--;
         }
         this.rootObject = this.turretMeshes[0].parent != null ? this.turretMeshes[0].parent : this.turretMeshes[0];
         this.rootObject.name = Object3DNames.TANK_PART;
         this.rootObject.mouseEnabled = true;
         this.turretDynamicSkin = new TankTurretDynamicSkin(this.rootObject as Mesh);
      }
      
      protected static function copyPosition(param1:Object3D, param2:Object3D) : void
      {
         param1.x = param2.x;
         param1.y = param2.y;
         param1.z = param2.z;
      }
      
      protected static function setPosition(param1:Object3D, param2:Vector3) : void
      {
         param1.x = param2.x;
         param1.y = param2.y;
         param1.z = param2.z;
      }
      
      public function initShadow(param1:Shadow) : void
      {
         var _loc2_:Mesh = null;
         for each(_loc2_ in this.turretMeshes)
         {
            param1.addCaster(_loc2_);
         }
      }
      
      public function set alpha(param1:Number) : void
      {
         var _loc2_:Mesh = null;
         for each(_loc2_ in this.turretMeshes)
         {
            _loc2_.alpha = param1;
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:Mesh = null;
         for each(_loc1_ in this.turretMeshes)
         {
            _loc1_.setMaterialToAllFaces(null);
         }
         this.turretMeshes = null;
         this.turretDynamicSkin.destroy();
      }
      
      public function setMaterials(param1:TextureMaterial, param2:TextureMaterial) : void
      {
         var _loc2_:Mesh = null;
         for each(_loc2_ in this.turretMeshes)
         {
            _loc2_.setMaterialToAllFaces(param1);
         }
         this.turretDynamicSkin.setMaterial(param2);
      }
      
      public function addToScene() : void
      {
         battleService.getBattleScene3D().addObject(this.rootObject);
      }
      
      public function removeFromScene() : void
      {
         battleService.getBattleScene3D().removeObject(this.rootObject);
      }
      
      public function updateTurretTransform(param1:Matrix4, param2:TankHullSkinCacheItem, param3:Number) : void
      {
         turretMatrix.setMatrix(param2.getTurretMountPointX(),param2.getTurretMountPointY(),param2.getTurretMountPointZ() + 1,0,0,param3);
         turretMatrix.append(param1);
         this.rootObject.x = turretMatrix.m03;
         this.rootObject.y = turretMatrix.m13;
         this.rootObject.z = turretMatrix.m23;
         var _loc4_:Vector3 = BattleUtils.tmpVector;
         turretMatrix.getEulerAngles(_loc4_);
         this.rootObject.rotationX = _loc4_.x;
         this.rootObject.rotationY = _loc4_.y;
         this.rootObject.rotationZ = _loc4_.z;
      }
      
      public function getTurret3D() : Object3D
      {
         return this.rootObject;
      }
      
      public function getBarrel3D() : Object3D
      {
         return this.rootObject;
      }
      
      public function getMeshes() : Vector.<Mesh>
      {
         return this.turretMeshes;
      }

      public function getTurretDynamicSkin() : TankTurretDynamicSkin
      {
         return this.turretDynamicSkin;
      }
      
      public function setColorTransform(param1:ColorTransform) : void
      {
         var _loc2_:Mesh = null;
         for each(_loc2_ in this.getMeshes())
         {
            _loc2_.colorTransform = param1;
         }
      }
   }
}

