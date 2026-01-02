package projects.tanks.client.garage.skins.shot
{
   import platform.client.fp10.core.type.IGameObject;
   
   public class AvailableShotSkinsCC
   {
      
      private var _skins:Vector.<IGameObject>;
      
      public function AvailableShotSkinsCC(param1:Vector.<IGameObject> = null)
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
         var _loc1_:String = "AvailableShotSkinsCC [";
         _loc1_ += "skins = " + this.skins + " ";
         return _loc1_ + "]";
      }
   }
}

