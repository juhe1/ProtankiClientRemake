
package alternativa.tanks.models.weapons.targeting.direction.sector
{
   import alternativa.tanks.battle.objects.tank.Tank;
   import mx.utils.StringUtil;
   
   public class TargetingSector2D
   {
      
      private var down:Number;
      private var up:Number;
      private var left:Number;
      private var right:Number;
      
      private var distance:Number;
      private var tank:Tank;
      
      public function TargetingSector2D(param1:Number, param2:Number, leftParam:Number, rightParams:Number, param3:Number, param4:Tank)
      {
         super();
         this.down = param1;
         this.up = param2;
         this.left = leftParam;
         this.right = rightParams;
         this.distance = param3;
         this.tank = param4;
      }
      
      public function getDown() : Number
      {
         return this.down;
      }
      
      public function getUp() : Number
      {
         return this.up;
      }
      
      public function getLeft() : Number
      {
         return this.left;
      }

      public function getRight() : Number
      {
         return this.right;
      }
      
      public function getDistance() : Number
      {
         return this.distance;
      }
      
      public function getTank() : Tank
      {
         return this.tank;
      }
      
      public function toString() : String
      {
         return StringUtil.substitute("[{0}, {1}], distance={2}, user={3}",this.left.toFixed(2),this.right.toFixed(2),this.distance.toFixed(0),this.tank.getUserId());
      }
   }
}

