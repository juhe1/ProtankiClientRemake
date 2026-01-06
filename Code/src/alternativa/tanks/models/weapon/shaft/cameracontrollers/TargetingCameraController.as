package alternativa.tanks.models.weapon.shaft.cameracontrollers
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.camera.ActivatedCameraConroller;
   import alternativa.tanks.camera.CameraController;
   import alternativa.tanks.camera.GameCamera;
   
   public class TargetingCameraController extends ActivatedCameraConroller implements CameraController
   {
      
      private static const objectMatrix:Matrix3 = new Matrix3();
      
      private static const cameraMatrix:Matrix3 = new Matrix3();
      
      private static const vector:Vector3 = new Vector3();
      
      private var anchorObject:Object3D;
      
      private var _elevation:Number = 0;
      
      private var localPosition:Vector3 = new Vector3();
      
      private var maxElevation:Number;
      
      private var minElevation:Number;
      
      private var _elevationDirection:int;
      
      private var maxElevationSpeed:Number = 1;
      
      private var maxElevationSpeedFactor:Number = 1;
      
      private var elevationSpeed:Number = 0;
      
      private var elevationAcceleration:Number = 5;
      
      public function TargetingCameraController(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         this.maxElevation = param1;
         this.minElevation = param2;
         this.maxElevationSpeed = param3;
         this.elevationAcceleration = param4;
      }
      
      public function set elevationDirection(param1:int) : void
      {
         if(this._elevationDirection != param1)
         {
            this._elevationDirection = param1;
            this.elevationSpeed = 0;
         }
      }
      
      public function isMaxElevation() : Boolean
      {
         return this._elevation == this.maxElevation || this._elevation == this.minElevation;
      }
      
      public function readCameraPosition(param1:Vector3) : void
      {
         var _loc2_:GameCamera = null;
         _loc2_ = getCamera();
         param1.x = _loc2_.x;
         param1.y = _loc2_.y;
         param1.z = _loc2_.z;
      }
      
      public function readCameraDirection(param1:Vector3) : void
      {
         var _loc2_:GameCamera = getCamera();
         var _loc3_:Vector3 = _loc2_.zAxis;
         param1.copy(_loc3_);
      }
      
      public function get elevation() : Number
      {
         return this._elevation;
      }
      
      public function set elevation(param1:Number) : void
      {
         if(param1 > this.maxElevation)
         {
            this._elevation = this.maxElevation;
         }
         else if(param1 < this.minElevation)
         {
            this._elevation = this.minElevation;
         }
         else
         {
            this._elevation = param1;
         }
      }
      
      public function setAnchorObject(param1:Object3D) : void
      {
         this.anchorObject = param1;
      }
      
      public function setLocalPosition(param1:Vector3) : void
      {
         this.localPosition.copy(param1);
      }
      
      public function setMaxElevationSpeedFactor(param1:Number) : void
      {
         this.maxElevationSpeedFactor = param1;
      }
      
      override public function update(param1:int, param2:int) : void
      {
         var _loc5_:Number = NaN;
         var _loc3_:Number = param2 / 1000;
         if(this._elevationDirection != 0)
         {
            this.elevationSpeed += this.elevationAcceleration * _loc3_;
            _loc5_ = this.maxElevationSpeed * this.maxElevationSpeedFactor;
            if(this.elevationSpeed > _loc5_)
            {
               this.elevationSpeed = _loc5_;
            }
            this._elevation += this._elevationDirection * this.elevationSpeed * _loc3_;
            if(this._elevation > this.maxElevation)
            {
               this._elevation = this.maxElevation;
            }
            else if(this._elevation < this.minElevation)
            {
               this._elevation = this.minElevation;
            }
         }
         objectMatrix.setRotationMatrix(this.anchorObject.rotationX,this.anchorObject.rotationY,this.anchorObject.rotationZ);
         cameraMatrix.fromAxisAngle(Vector3.X_AXIS,this._elevation - Math.PI / 2);
         cameraMatrix.append(objectMatrix);
         cameraMatrix.getEulerAngles(vector);
         var _loc4_:GameCamera = getCamera();
         _loc4_.rotationX = vector.x;
         _loc4_.rotationY = vector.y;
         _loc4_.rotationZ = vector.z;
         objectMatrix.transformVector(this.localPosition,vector);
         _loc4_.x = vector.x + this.anchorObject.x;
         _loc4_.y = vector.y + this.anchorObject.y;
         _loc4_.z = vector.z + this.anchorObject.z;
      }
      
      public function setCameraFov(param1:Number) : void
      {
         getCamera().fov = param1;
      }
   }
}

