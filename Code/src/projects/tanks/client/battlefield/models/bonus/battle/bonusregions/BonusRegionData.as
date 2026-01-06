package projects.tanks.client.battlefield.models.bonus.battle.bonusregions
{
   import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class BonusRegionData
   {
      
      private var _position:Vector3d;
      
      private var _regionType:BonusesType;
      
      private var _rotation:Vector3d;
      
      public function BonusRegionData(param1:Vector3d = null, param2:BonusesType = null, param3:Vector3d = null)
      {
         super();
         this._position = param1;
         this._regionType = param2;
         this._rotation = param3;
      }
      
      public function get position() : Vector3d
      {
         return this._position;
      }
      
      public function set position(param1:Vector3d) : void
      {
         this._position = param1;
      }
      
      public function get regionType() : BonusesType
      {
         return this._regionType;
      }
      
      public function set regionType(param1:BonusesType) : void
      {
         this._regionType = param1;
      }
      
      public function get rotation() : Vector3d
      {
         return this._rotation;
      }
      
      public function set rotation(param1:Vector3d) : void
      {
         this._rotation = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BonusRegionData [";
         _loc1_ += "position = " + this.position + " ";
         _loc1_ += "regionType = " + this.regionType + " ";
         _loc1_ += "rotation = " + this.rotation + " ";
         return _loc1_ + "]";
      }
   }
}

