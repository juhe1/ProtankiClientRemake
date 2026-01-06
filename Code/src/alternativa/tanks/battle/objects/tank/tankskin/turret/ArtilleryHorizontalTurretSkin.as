package alternativa.tanks.battle.objects.tank.tankskin.turret
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class ArtilleryHorizontalTurretSkin extends ArtilleryTurretSkin
   {
      
      private var initialAngle:Number;
      
      public function ArtilleryHorizontalTurretSkin(param1:Number, param2:Tanks3DSResource)
      {
         super(param2);
         this.initialAngle = param1;
      }
      
      override public function updateTurretTransform(param1:Matrix4, param2:TankHullSkinCacheItem, param3:Number) : void
      {
         turretMatrix.setMatrix(param2.getTurretMountPointX(),param2.getTurretMountPointY(),param2.getTurretMountPointZ() + 1,0,0,param3);
         turretMatrix.append(param1);
         rootObject.x = turretMatrix.m03;
         rootObject.y = turretMatrix.m13;
         rootObject.z = turretMatrix.m23;
         var _loc4_:Vector3 = BattleUtils.tmpVector;
         turretMatrix.getEulerAngles(_loc4_);
         rootObject.rotationX = _loc4_.x;
         rootObject.rotationY = _loc4_.y;
         rootObject.rotationZ = _loc4_.z;
         this.getBarrel3D().rotationX = -this.initialAngle;
      }
      
      override public function getBarrel3D() : Object3D
      {
         return turretMeshes[1].parent;
      }
   }
}

