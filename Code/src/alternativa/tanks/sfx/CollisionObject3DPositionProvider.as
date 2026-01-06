package alternativa.tanks.sfx
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   
   public class CollisionObject3DPositionProvider extends PooledObject implements Object3DPositionProvider
   {
      
      private static const turretMatrix:Matrix4 = new Matrix4();
      
      private static const barrelOrigin:Vector3 = new Vector3();
      
      private static const direction:Vector3 = new Vector3();
      
      private static const turretAxisX:Vector3 = new Vector3();
      
      private static const globalMuzzlePosition:Vector3 = new Vector3();
      
      private static const intersection:RayHit = new RayHit();
      
      private static const MIN_DISTANCE:Number = 20;
      
      private static const SMOOTH:Number = 0.2;
      
      private var maxDistance:Number;
      
      private var collisionDetector:CollisionDetector;
      
      private var localMuzzlePosition:Vector3 = new Vector3();
      
      private var turret:Object3D;
      
      private var coeff:Number;
      
      private var currentDistance:Number = 0;
      
      public function CollisionObject3DPositionProvider(param1:Pool)
      {
         super(param1);
      }
      
      private function calculateParameters() : void
      {
         turretMatrix.setMatrix(this.turret.x,this.turret.y,this.turret.z,this.turret.rotationX,this.turret.rotationY,this.turret.rotationZ);
         turretAxisX.x = turretMatrix.m00;
         turretAxisX.y = turretMatrix.m10;
         turretAxisX.z = turretMatrix.m20;
         direction.x = turretMatrix.m01;
         direction.y = turretMatrix.m11;
         direction.z = turretMatrix.m21;
         turretMatrix.transformVector(this.localMuzzlePosition,globalMuzzlePosition);
         var _loc1_:Number = this.localMuzzlePosition.y;
         barrelOrigin.x = globalMuzzlePosition.x - _loc1_ * direction.x;
         barrelOrigin.y = globalMuzzlePosition.y - _loc1_ * direction.y;
         barrelOrigin.z = globalMuzzlePosition.z - _loc1_ * direction.z;
      }
      
      public function init(param1:Object3D, param2:Vector3, param3:CollisionDetector, param4:Number, param5:Number = 0.5) : void
      {
         this.turret = param1;
         this.localMuzzlePosition = param2;
         this.collisionDetector = param3;
         this.maxDistance = param4;
         this.coeff = param5;
         this.currentDistance = 0;
      }
      
      public function initPosition(param1:Object3D) : void
      {
         this.calculateParameters();
         var _loc2_:Number = this.maxDistance * this.coeff;
         if(this.collisionDetector.raycastStatic(barrelOrigin,direction,CollisionGroup.STATIC,this.maxDistance,null,intersection))
         {
            _loc2_ = Vector3.distanceBetween(barrelOrigin,intersection.position) * this.coeff;
         }
         var _loc3_:Number = _loc2_ - this.currentDistance;
         if(Math.abs(_loc3_) <= MIN_DISTANCE)
         {
            this.currentDistance = _loc2_;
         }
         else
         {
            this.currentDistance += _loc3_ * SMOOTH;
         }
         param1.x = barrelOrigin.x + direction.x * this.currentDistance;
         param1.y = barrelOrigin.y + direction.y * this.currentDistance;
         param1.z = barrelOrigin.z + direction.z * this.currentDistance;
      }
      
      public function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void
      {
         this.initPosition(param1);
      }
      
      public function destroy() : void
      {
         this.turret = null;
         this.collisionDetector = null;
         recycle();
      }
   }
}

