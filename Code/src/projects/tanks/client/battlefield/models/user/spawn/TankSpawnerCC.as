package projects.tanks.client.battlefield.models.user.spawn
{
   public class TankSpawnerCC
   {
      
      private var _incarnationId:int;
      
      public function TankSpawnerCC(param1:int = 0)
      {
         super();
         this._incarnationId = param1;
      }
      
      public function get incarnationId() : int
      {
         return this._incarnationId;
      }
      
      public function set incarnationId(param1:int) : void
      {
         this._incarnationId = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TankSpawnerCC [";
         _loc1_ += "incarnationId = " + this.incarnationId + " ";
         return _loc1_ + "]";
      }
   }
}

