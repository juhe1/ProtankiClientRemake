package alternativa.tanks.models.weapon.shotgun
{
   import alternativa.math.Vector3;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.aiming.ShotGunAimingCC;
   
   public class PelletDirectionCalculator
   {
      
      private static const horizontalVector:Vector3 = new Vector3();
      
      private static const verticalVector:Vector3 = new Vector3();
      
      private var directions:Vector.<Vector3>;
      
      private var result:Vector.<Vector3>;
      
      private var params:ShotGunAimingCC;
      
      private var MAX_X:Number;
      
      private var MAX_Y:Number;
      
      public function PelletDirectionCalculator(param1:ShotGunAimingCC)
      {
         super();
         this.MAX_X = Math.tan(param1.coneHorizontalAngle * 0.5);
         this.MAX_Y = Math.tan(param1.coneVerticalAngle * 0.5);
         this.params = param1;
         this.directions = new Vector.<Vector3>(param1.pelletCount,true);
         this.result = new Vector.<Vector3>(param1.pelletCount,true);
         var _loc2_:int = 0;
         while(_loc2_ < this.directions.length)
         {
            this.directions[_loc2_] = new Vector3();
            this.result[_loc2_] = new Vector3();
            _loc2_++;
         }
      }
      
      public function next() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.directions.length)
         {
            this.nextPelletDirection(this.directions[_loc1_]);
            _loc1_++;
         }
      }
      
      private function nextPelletDirection(param1:Vector3) : void
      {
         var _loc2_:Number = Math.random();
         var _loc3_:Number = Math.random() * Math.PI * 2;
         param1.x = Math.cos(_loc3_) * _loc2_ * this.MAX_X;
         param1.y = Math.sin(_loc3_) * _loc2_ * this.MAX_Y;
      }
      
      public function getDirectionsFor(param1:Vector3, param2:Vector3) : Vector.<Vector3>
      {
         var _loc4_:Vector3 = null;
         this.calculateOrtho(param1,param2);
         var _loc3_:int = 0;
         while(_loc3_ < this.directions.length)
         {
            _loc4_ = this.directions[_loc3_];
            this.calculateDirection(_loc4_.x,_loc4_.y,param2,this.result[_loc3_]);
            _loc3_++;
         }
         return this.result;
      }
      
      private function calculateDirection(param1:Number, param2:Number, param3:Vector3, param4:Vector3) : void
      {
         param4.reset();
         param4.addScaled(param1,horizontalVector);
         param4.addScaled(param2,verticalVector);
         param4.add(param3);
         param4.normalize();
      }
      
      private function calculateOrtho(param1:Vector3, param2:Vector3) : void
      {
         horizontalVector.copy(param1);
         verticalVector.cross2(horizontalVector,param2).normalize();
      }
   }
}

