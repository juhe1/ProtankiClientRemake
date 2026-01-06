package alternativa.tanks.battle.objects.tank.tankskin.turret
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class ArtilleryTurretSkin extends TurretSkin
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      public function ArtilleryTurretSkin(param1:Tanks3DSResource)
      {
         super(param1);
         setPosition(rootObject,Vector3.ZERO);
      }
      
      override public function updateTurretTransform(param1:Matrix4, param2:TankHullSkinCacheItem, param3:Number) : void
      {
         var _loc4_:Vector3 = BattleUtils.tmpVector;
         param1.transformVectorXYZ(param2.getTurretMountPointX(),param2.getTurretMountPointY(),param2.getTurretMountPointZ() + 1,_loc4_);
         rootObject.x = _loc4_.x;
         rootObject.y = _loc4_.y;
         rootObject.z = _loc4_.z;
         param1.getEulerAngles(_loc4_);
         rootObject.rotationX = _loc4_.x;
         rootObject.rotationY = _loc4_.y;
         rootObject.rotationZ = _loc4_.z;
         this.getBarrel3D().rotationX = -param3;
      }
      
      override public function getBarrel3D() : Object3D
      {
         return turretMeshes[1].parent;
      }
      
      public function getCannon3D() : Object3D
      {
         return turretMeshes[2];
      }
   }
}

