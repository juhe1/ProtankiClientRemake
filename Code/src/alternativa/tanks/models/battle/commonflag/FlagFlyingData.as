package alternativa.tanks.models.battle.commonflag
{
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlagFlyingData;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagFlyPoint;
   import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlyingMode;
   
   public class FlagFlyingData
   {
      
      private static const TIME_TO_MARK:int = 3000;
      
      private static const APOS:Vector3 = new Vector3();
      
      private static const BPOS:Vector3 = new Vector3();
      
      private static const aQ:Quaternion = new Quaternion();
      
      private static const bQ:Quaternion = new Quaternion();
      
      private var points:Vector.<FlagFlyPoint> = new Vector.<FlagFlyPoint>();
      
      public var isFlying:Boolean = false;
      
      private var time:int = 0;
      
      public var currentPosition:Vector3 = new Vector3();
      
      public var instantSpeed:Number = 0;
      
      private var currentIndex:int = 0;
      
      private var finalPosition:Vector3 = new Vector3();
      
      public var currentOrientation:Quaternion = new Quaternion();
      
      public var isKilled:Boolean;
      
      public function FlagFlyingData()
      {
         super();
      }
      
      public function init(param1:ClientFlagFlyingData) : void
      {
         var _loc2_:FlagFlyPoint = null;
         this.points.length = 0;
         for each(_loc2_ in param1.points)
         {
            this.points.push(_loc2_);
         }
         this.isFlying = param1.falling;
         this.time = param1.currentTime;
         this.currentIndex = 0;
         this.finalPosition.copyFromVector3d(this.getLastPoint().position);
         this.isKilled = false;
         this.update(0);
      }
      
      public function update(param1:Number) : void
      {
         var _loc3_:FlagFlyPoint = null;
         var _loc4_:FlagFlyPoint = null;
         var _loc8_:int = 0;
         this.time += param1 * 1000;
         var _loc2_:FlagFlyPoint = this.getLastPoint();
         if(this.time >= _loc2_.time)
         {
            this.currentPosition.copy(this.getFinalPosition());
            this.time = _loc2_.time;
            this.isFlying = false;
            if(_loc2_.mode == FlyingMode.KILL)
            {
               this.isKilled = true;
            }
            return;
         }
         if(this.points.length == 2)
         {
            _loc4_ = this.points[0];
            _loc3_ = this.points[1];
         }
         else
         {
            _loc8_ = this.currentIndex;
            while(_loc8_ < this.points.length - 1)
            {
               _loc4_ = this.points[_loc8_];
               _loc3_ = this.points[_loc8_ + 1];
               if(_loc4_.time <= this.time && this.time < _loc3_.time)
               {
                  this.currentIndex = _loc8_;
                  break;
               }
               _loc8_++;
            }
         }
         var _loc5_:int = _loc3_.time - _loc4_.time;
         var _loc6_:Number = (this.time - _loc4_.time) / _loc5_;
         BPOS.copyFromVector3d(_loc3_.position);
         this.currentPosition.copy(BPOS);
         APOS.copyFromVector3d(_loc4_.position);
         this.currentPosition.subtract(APOS);
         this.currentPosition.scale(_loc6_);
         this.currentPosition.add(APOS);
         aQ.reset(_loc4_.rotation_w,_loc4_.rotation_x,_loc4_.rotation_y,_loc4_.rotation_z).normalize();
         bQ.reset(_loc3_.rotation_w,_loc3_.rotation_x,_loc3_.rotation_y,_loc3_.rotation_z).normalize();
         this.currentOrientation.slerp(aQ,bQ,_loc6_).normalize();
         var _loc7_:Number = BPOS.distanceTo(APOS);
         this.instantSpeed = _loc7_ / (_loc5_ * 1000);
      }
      
      public function getFinalPosition() : Vector3
      {
         return this.finalPosition;
      }
      
      private function getLastPoint() : FlagFlyPoint
      {
         return this.points[this.points.length - 1];
      }
      
      public function isMarked() : Boolean
      {
         return this.time > TIME_TO_MARK;
      }
   }
}

