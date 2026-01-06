package alternativa.tanks.camera
{
   import alternativa.math.Vector3;
   import alternativa.tanks.utils.MathUtils;
   
   public class FlyCameraController extends CameraControllerBase implements CameraController
   {
      
      private static const FLY_HEIGHT:Number = 3000;
      
      private static const cameraPosition:Vector3 = new Vector3();
      
      private var p1:Vector3 = new Vector3();
      
      private var p2:Vector3 = new Vector3();
      
      private var p3:Vector3 = new Vector3();
      
      private var p4:Vector3 = new Vector3();
      
      private var totalDistance:Number;
      
      private var distance:Number;
      
      private var acceleration:Number;
      
      private var speed:Number;
      
      private var angleValuesX:AngleValues = new AngleValues();
      
      private var angleValuesZ:AngleValues = new AngleValues();
      
      public var duration:int;
      
      public function FlyCameraController(param1:int)
      {
         super();
         this.duration = param1;
      }
      
      public function init(param1:Vector3, param2:Vector3) : void
      {
         this.p1.copy(getCameraPosition());
         this.p2.copy(this.p1);
         this.p4.copy(param1);
         this.p3.copy(this.p4);
         this.p2.z = this.p3.z = (this.p1.z > this.p4.z ? this.p1.z : this.p4.z) + FLY_HEIGHT;
         var _loc3_:Number = 4000000 / (this.duration * this.duration);
         this.angleValuesX.init(MathUtils.clampAngle(getCameraRotationX()),param2.x,_loc3_);
         this.angleValuesZ.init(MathUtils.clampAngle(getCameraRotationZ()),param2.z,_loc3_);
         var _loc4_:Vector3 = new Vector3();
         _loc4_.diff(this.p4,this.p1);
         this.totalDistance = _loc4_.length();
         this.acceleration = this.totalDistance * _loc3_;
         this.distance = 0;
         this.speed = 0;
      }
      
      override public function update(param1:int, param2:int) : void
      {
         if(this.speed < 0)
         {
            return;
         }
         if(this.distance > 0.5 * this.totalDistance && this.acceleration > 0)
         {
            this.acceleration = -this.acceleration;
            this.angleValuesX.reverseAcceleration();
            this.angleValuesZ.reverseAcceleration();
         }
         var _loc3_:Number = 0.001 * param2;
         var _loc4_:Number = this.acceleration * _loc3_;
         this.distance += (this.speed + 0.5 * _loc4_) * _loc3_;
         this.speed += _loc4_;
         if(this.distance > this.totalDistance)
         {
            this.distance = this.totalDistance;
         }
         this.bezier(this.distance / this.totalDistance,this.p1,this.p2,this.p3,this.p4,cameraPosition);
         setPosition(cameraPosition);
         rotateBy(this.angleValuesX.update(_loc3_),0,this.angleValuesZ.update(_loc3_));
      }
      
      private function bezier(param1:Number, param2:Vector3, param3:Vector3, param4:Vector3, param5:Vector3, param6:Vector3) : void
      {
         var _loc8_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc7_:Number = 1 - param1;
         _loc8_ = _loc7_ * _loc7_;
         var _loc9_:Number = 3 * param1 * _loc8_;
         _loc8_ *= _loc7_;
         _loc10_ = param1 * param1;
         var _loc11_:Number = 3 * _loc10_ * _loc7_;
         _loc10_ *= param1;
         param6.x = _loc8_ * param2.x + _loc9_ * param3.x + _loc11_ * param4.x + _loc10_ * param5.x;
         param6.y = _loc8_ * param2.y + _loc9_ * param3.y + _loc11_ * param4.y + _loc10_ * param5.y;
         param6.z = _loc8_ * param2.z + _loc9_ * param3.z + _loc11_ * param4.z + _loc10_ * param5.z;
      }
   }
}

