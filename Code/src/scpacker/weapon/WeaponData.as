package scpacker.weapon
{
   public class WeaponData
   {
      private var _reload:int;
      private var _autoAimingDown:Number;
      private var _autoAimingUp:Number;
      private var _numRaysUp:int;
      private var _numRaysDown:int;
      
      public function WeaponData(reload:int, autoAimingDown:Number, autoAimingUp:Number, numRaysUp:int, numRaysDown:int)
      {
         _reload = reload;
         _autoAimingDown = autoAimingDown;
         _autoAimingUp = autoAimingUp;
         _numRaysUp = numRaysUp;
         _numRaysDown = numRaysDown;
      }
      
      public function get reload():int
      {
         return _reload;
      }
      
      public function set reload(value:int):void
      {
         _reload = value;
      }
      
      public function get autoAimingDown():Number
      {
         return _autoAimingDown;
      }
      
      public function set autoAimingDown(value:Number):void
      {
         _autoAimingDown = value;
      }
      
      public function get autoAimingUp():Number
      {
         return _autoAimingUp;
      }
      
      public function set autoAimingUp(value:Number):void
      {
         _autoAimingUp = value;
      }
      
      public function get numRaysUp():int
      {
         return _numRaysUp;
      }
      
      public function set numRaysUp(value:int):void
      {
         _numRaysUp = value;
      }
      
      public function get numRaysDown():int
      {
         return _numRaysDown;
      }
      
      public function set numRaysDown(value:int):void
      {
         _numRaysDown = value;
      }
   }
}
