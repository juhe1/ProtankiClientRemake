package alternativa.tanks.camera
{
   public class AngleValues
   {
      
      private var currentAngle:Number;
      
      private var totalAngle:Number;
      
      private var angularAcceleration:Number;
      
      private var angularSpeed:Number;
      
      private var angleDirection:Number;
      
      public function AngleValues()
      {
         super();
      }
      
      public function init(param1:Number, param2:Number, param3:Number) : void
      {
         this.totalAngle = param2 - param1;
         if(this.totalAngle < 0)
         {
            this.totalAngle = -this.totalAngle;
            this.angleDirection = -1;
         }
         else
         {
            this.angleDirection = 1;
         }
         if(this.totalAngle > Math.PI)
         {
            this.angleDirection = -this.angleDirection;
            this.totalAngle = 2 * Math.PI - this.totalAngle;
         }
         this.angularAcceleration = param3 * this.totalAngle;
         this.angularSpeed = 0;
         this.currentAngle = 0;
      }
      
      public function reverseAcceleration() : void
      {
         this.angularAcceleration = -this.angularAcceleration;
      }
      
      public function update(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.currentAngle < this.totalAngle)
         {
            _loc2_ = this.angularAcceleration * param1;
            _loc3_ = (this.angularSpeed + 0.5 * _loc2_) * param1;
            this.angularSpeed += _loc2_;
            _loc4_ = this.totalAngle - this.currentAngle;
            if(_loc4_ < _loc3_)
            {
               _loc3_ = _loc4_;
            }
            this.currentAngle += _loc3_;
            return _loc3_ * this.angleDirection;
         }
         return 0;
      }
   }
}

