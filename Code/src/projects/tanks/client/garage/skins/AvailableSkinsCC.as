package projects.tanks.client.garage.skins
{
   import platform.client.fp10.core.type.IGameObject;
   
   public class AvailableSkinsCC
   {
      
      private var _skins:Vector.<IGameObject>;
      
      public function AvailableSkinsCC(param1:Vector.<IGameObject> = null)
      {
         super();
         this._skins = param1;
      }
      
      public function get skins() : Vector.<IGameObject>
      {
         return this._skins;
      }
      
      public function set skins(param1:Vector.<IGameObject>) : void
      {
         this._skins = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "AvailableSkinsCC [";
         _loc1_ += "skins = " + this.skins + " ";
         return _loc1_ + "]";
      }
   }
}

