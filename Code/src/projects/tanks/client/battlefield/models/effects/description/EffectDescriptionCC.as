package projects.tanks.client.battlefield.models.effects.description
{
   import platform.client.fp10.core.type.IGameObject;
   
   public class EffectDescriptionCC
   {
      
      private var _index:int;
      
      private var _tank:String;
      
      public function EffectDescriptionCC(param1:int = 0, param2:String = null)
      {
         super();
         this._index = param1;
         this._tank = param2;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
      }
      
      public function get tank() : String
      {
         return this._tank;
      }
      
      public function set tank(param1:String) : void
      {
         this._tank = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "EffectDescriptionCC [";
         _loc1_ += "index = " + this.index + " ";
         _loc1_ += "tank = " + this.tank + " ";
         return _loc1_ + "]";
      }
   }
}

