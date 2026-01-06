package alternativa.tanks.battle.objects.tank.tankskin.turret
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.objects.tank.tankskin.*;
   import alternativa.tanks.utils.DataUnitValidator;
   import alternativa.tanks.utils.DataValidatorType;
   import alternativa.tanks.utils.Vector3Validator;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import projects.tanks.clients.flash.resources.tanks.Tank3D;
   
   public class TurretSkinCacheItem extends TankSkinPartCacheItem implements DataUnitValidator
   {
      
      private static const BOX_REGEXP:RegExp = /box.*/i;
      
      private static const PARENT_RELATIVE:RegExp = /(launcher_.?|barrel_.?)/i;
      
      public var flagMountPoint:Vector3;
      
      public var muzzles:Vector.<Vector3>;
      
      public var laserPoint:Vector3;
      
      private var muzzleValidators:Vector.<Vector3Validator>;
      
      private var collisionGeometry:Vector.<TurretGeometryItem>;
      
      public var meshes:Vector.<Mesh> = new Vector.<Mesh>();
      
      public function TurretSkinCacheItem(param1:Tanks3DSResource)
      {
         super(param1);
         this.initMeshes(param1);
         this.flagMountPoint = parseFlagMountPoint(param1);
         this.muzzles = this.parseMuzzles(param1);
         this.laserPoint = this.parseLaserPoint(param1);
         this.collisionGeometry = this.parseGeometry(param1);
         this.createMuzzleValidators();
      }
      
      private static function parseFlagMountPoint(param1:Tanks3DSResource) : Vector3
      {
         var _loc3_:Object3D = null;
         var _loc2_:Vector.<Object3D> = param1.getObjectsByName(/fmnt/i);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_[0];
            return new Vector3(_loc3_.x,_loc3_.y,_loc3_.z);
         }
         throw new Error();
      }
      
      private function initMeshes(param1:Tanks3DSResource) : void
      {
         var _loc2_:Object3D = null;
         for each(_loc2_ in param1.objects)
         {
            if(_loc2_ is Mesh && !Tank3D.EXCLUDED.test(_loc2_.name))
            {
               this.meshes.push(initMesh(Mesh(_loc2_)));
            }
         }
      }
      
      private function parseGeometry(param1:Tanks3DSResource) : Vector.<TurretGeometryItem>
      {
         var _loc4_:Object3D = null;
         var _loc5_:Mesh = null;
         var _loc2_:Vector.<Object3D> = param1.getObjectsByName(BOX_REGEXP);
         var _loc3_:Vector.<TurretGeometryItem> = new Vector.<TurretGeometryItem>();
         if(_loc2_ != null && _loc2_.length != 0)
         {
            for each(_loc4_ in _loc2_)
            {
               _loc3_.push(new TurretGeometryItem(_loc4_));
            }
         }
         else
         {
            for each(_loc5_ in this.meshes)
            {
               _loc3_.push(new TurretGeometryItem(_loc5_));
            }
         }
         return _loc3_;
      }
      
      private function parseMuzzles(param1:Tanks3DSResource) : Vector.<Vector3>
      {
         var object:Object3D = null;
         var muzzle:Vector3 = null;
         var parent:Object3D = null;
         var resource:Tanks3DSResource = param1;
         var muzzles:Vector.<Vector3> = new Vector.<Vector3>();
         var objects:Vector.<Object3D> = resource.getObjectsByName(/muzzle.*/);
         if(objects != null)
         {
            objects.sort(function(param1:Object3D, param2:Object3D):Number
            {
               if(param1.name <= param2.name)
               {
                  return -1;
               }
               return 1;
            });
            for each(object in objects)
            {
               muzzle = new Vector3(object.x,object.y,object.z);
               parent = resource.parents[resource.objects.indexOf(object)];
               if(parent != null && Boolean(parent.name.match(PARENT_RELATIVE)))
               {
                  muzzle.x += parent.x;
                  muzzle.y += parent.y;
                  muzzle.z += parent.z;
               }
               muzzles.push(muzzle);
            }
            return muzzles;
         }
         throw new Error();
      }
      
      private function parseLaserPoint(param1:Tanks3DSResource) : Vector3
      {
         var _loc3_:Object3D = null;
         var _loc2_:Vector.<Object3D> = param1.getObjectsByName(/laser/i);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_[0];
            return new Vector3(_loc3_.x,_loc3_.y,_loc3_.z);
         }
         return this.muzzles[0];
      }
      
      private function createMuzzleValidators() : void
      {
         this.muzzleValidators = new Vector.<Vector3Validator>(this.muzzles.length);
         var _loc1_:int = 0;
         while(_loc1_ < this.muzzles.length)
         {
            this.muzzleValidators[_loc1_] = new Vector3Validator(this.muzzles[_loc1_]);
            _loc1_++;
         }
      }
      
      public function hasIncorrectData() : Boolean
      {
         var _loc1_:Vector3Validator = null;
         for each(_loc1_ in this.muzzleValidators)
         {
            if(!_loc1_.isValid())
            {
               return true;
            }
         }
         return false;
      }
      
      public function getType() : int
      {
         return DataValidatorType.MEMHACK_MUZZLE_POSITION;
      }
      
      public function getGeometry() : Vector.<TurretGeometryItem>
      {
         return this.collisionGeometry;
      }
   }
}

