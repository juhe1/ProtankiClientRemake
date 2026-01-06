package alternativa.tanks.battle.objects.tank.tankskin
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.objects.tank.*;
   import alternativa.tanks.utils.DataUnitValidator;
   import alternativa.tanks.utils.DataValidatorType;
   import alternativa.tanks.utils.EncryptedNumber;
   import alternativa.tanks.utils.EncryptedNumberImpl;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class TankHullSkinCacheItem extends TankSkinPartCacheItem implements DataUnitValidator
   {
      
      public var turretMountPoint:Vector3;
      
      private var encTurretMountPointX:EncryptedNumber;
      
      private var encTurretMountPointY:EncryptedNumber;
      
      private var encTurretMountPointZ:EncryptedNumber;
      
      public var mesh:Mesh;
      
      public function TankHullSkinCacheItem(param1:Tanks3DSResource)
      {
         super(param1);
         var _loc2_:Vector.<Object3D> = param1.getObjectsByName(/mount/i);
         if(_loc2_ == null)
         {
            throw new TurretMountPointNotFoundError();
         }
         var _loc3_:Object3D = _loc2_[0];
         this.turretMountPoint = new Vector3(_loc3_.x,_loc3_.y,_loc3_.z);
         this.encTurretMountPointX = new EncryptedNumberImpl(_loc3_.x);
         this.encTurretMountPointY = new EncryptedNumberImpl(_loc3_.y);
         this.encTurretMountPointZ = new EncryptedNumberImpl(_loc3_.z);
         this.mesh = initMesh(this.getMesh(param1));
      }
      
      public function hasIncorrectData() : Boolean
      {
         return this.turretMountPoint.x != this.encTurretMountPointX.getNumber() || this.turretMountPoint.y != this.encTurretMountPointY.getNumber() || this.turretMountPoint.z != this.encTurretMountPointZ.getNumber();
      }
      
      public function getType() : int
      {
         return DataValidatorType.MEMHACK_TURRET_MOUNT_POINT;
      }
      
      private function getMesh(param1:Tanks3DSResource) : Mesh
      {
         var _loc2_:Vector.<Object3D> = param1.getObjectsByName(/hull/i);
         if(_loc2_ == null)
         {
            throw new HullNotFoundError();
         }
         return Mesh(_loc2_[0]);
      }
      
      public function getTurretMountPointX() : Number
      {
         return this.encTurretMountPointX.getNumber();
      }
      
      public function getTurretMountPointY() : Number
      {
         return this.encTurretMountPointY.getNumber();
      }
      
      public function getTurretMountPointZ() : Number
      {
         return this.encTurretMountPointZ.getNumber();
      }
   }
}

