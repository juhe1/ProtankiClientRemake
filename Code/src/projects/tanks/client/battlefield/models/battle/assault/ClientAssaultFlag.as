package projects.tanks.client.battlefield.models.battle.assault
{
   import alternativa.types.Long;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class ClientAssaultFlag
   {
      
      private var _flagBasePosition:Vector3d;
      
      private var _flagCarrierId:String;
      
      private var _flagPosition:Vector3d;
      
      private var _id:int;
      
      public function ClientAssaultFlag(param1:Vector3d = null, param2:String = null, param3:Vector3d = null, param4:int = 0)
      {
         super();
         this._flagBasePosition = param1;
         this._flagCarrierId = param2;
         this._flagPosition = param3;
         this._id = param4;
      }
      
      public function get flagBasePosition() : Vector3d
      {
         return this._flagBasePosition;
      }
      
      public function set flagBasePosition(param1:Vector3d) : void
      {
         this._flagBasePosition = param1;
      }
      
      public function get flagCarrierId() : String
      {
         return this._flagCarrierId;
      }
      
      public function set flagCarrierId(param1:String) : void
      {
         this._flagCarrierId = param1;
      }
      
      public function get flagPosition() : Vector3d
      {
         return this._flagPosition;
      }
      
      public function set flagPosition(param1:Vector3d) : void
      {
         this._flagPosition = param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "ClientAssaultFlag [";
         _loc1_ += "flagBasePosition = " + this.flagBasePosition + " ";
         _loc1_ += "flagCarrierId = " + this.flagCarrierId + " ";
         _loc1_ += "flagPosition = " + this.flagPosition + " ";
         _loc1_ += "id = " + this.id + " ";
         return _loc1_ + "]";
      }
   }
}

