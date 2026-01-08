package projects.tanks.client.battlefield.models.battle.assault
{
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class AssaultBase
   {
      
      private var _id:int;
      
      private var _position:Vector3d;
      
      public function AssaultBase(param1:int = 0, param2:Vector3d = null)
      {
         super();
         this._id = param1;
         this._position = param2;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get position() : Vector3d
      {
         return this._position;
      }
      
      public function set position(param1:Vector3d) : void
      {
         this._position = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "AssaultBase [";
         _loc1_ += "id = " + this.id + " ";
         _loc1_ += "position = " + this.position + " ";
         return _loc1_ + "]";
      }
   }
}

