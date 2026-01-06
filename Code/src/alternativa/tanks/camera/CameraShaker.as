package alternativa.tanks.camera
{
   import alternativa.math.Vector3;
   
   public class CameraShaker
   {
      
      private var maxAngle:Number = 1.5707963267948966;
      
      private var direction:Vector3 = new Vector3();
      
      private var maxTime:int = 500;
      
      private var time:int;
      
      private var maxRadius:Number = 50;
      
      private var radius:Number = 0;
      
      private var e1:Vector3 = new Vector3();
      
      private var e2:Vector3 = new Vector3();
      
      public function CameraShaker()
      {
         super();
      }
      
      public function setMaxTime(param1:int) : void
      {
         this.maxTime = param1;
      }
      
      public function start() : void
      {
         this.time = this.maxTime;
         this.radius = this.maxRadius;
         this.direction.reset(1 - 2 * Math.random(),1 - 2 * Math.random(),1 - 2 * Math.random()).normalize();
         this.calculateBasisVectors();
      }
      
      public function isActive() : Boolean
      {
         return this.time > 0;
      }
      
      public function getCameraPosition(param1:Vector3, param2:Vector3) : void
      {
         param2.copy(param1);
         if(this.time > 0)
         {
            param2.addScaled(this.radius,this.direction);
         }
      }
      
      public function update(param1:int) : void
      {
         if(this.time > 0)
         {
            this.time -= param1;
            if(this.time > 0)
            {
               this.calculateNewDirection();
               this.calculateBasisVectors();
               this.calculateRadius(this.time);
            }
         }
      }
      
      private function calculateRadius(param1:int) : void
      {
         var _loc2_:Number = Math.cos(Math.PI * (this.maxTime - param1) / this.maxTime);
         this.radius = this.maxRadius * 0.5 * (1 + _loc2_);
      }
      
      private function calculateNewDirection() : void
      {
         var _loc1_:Number = this.maxAngle * Math.random();
         var _loc2_:Number = -Math.cos(_loc1_);
         var _loc3_:Number = Math.sin(_loc1_);
         _loc1_ = 2 * Math.PI * Math.random();
         var _loc4_:Number = _loc3_ * Math.cos(_loc1_);
         var _loc5_:Number = _loc3_ * Math.sin(_loc1_);
         var _loc6_:Number = _loc2_ * this.direction.x + _loc4_ * this.e1.x + _loc5_ * this.e2.x;
         var _loc7_:Number = _loc2_ * this.direction.y + _loc4_ * this.e1.y + _loc5_ * this.e2.y;
         var _loc8_:Number = _loc2_ * this.direction.z + _loc4_ * this.e1.z + _loc5_ * this.e2.z;
         this.direction.reset(_loc6_,_loc7_,_loc8_).normalize();
      }
      
      private function calculateBasisVectors() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = this.direction.x < 0 ? -this.direction.x : this.direction.x;
         var _loc3_:Number = this.direction.y < 0 ? -this.direction.y : this.direction.y;
         if(_loc3_ > _loc2_)
         {
            _loc2_ = _loc3_;
            _loc1_ = 1;
         }
         _loc3_ = this.direction.z < 0 ? -this.direction.z : this.direction.z;
         if(_loc3_ > _loc2_)
         {
            _loc1_ = 2;
         }
         switch(_loc1_)
         {
            case 0:
               this.e1.x = 0;
               this.e1.y = this.direction.z;
               this.e1.z = -this.direction.y;
               break;
            case 1:
               this.e1.x = -this.direction.z;
               this.e1.y = 0;
               this.e1.z = this.direction.x;
               break;
            case 2:
               this.e1.x = this.direction.y;
               this.e1.y = -this.direction.x;
               this.e1.z = 0;
         }
         this.e1.normalize();
         this.e2.cross2(this.direction,this.e1);
      }
   }
}

