package projects.tanks.client.battlefield.models.bonus.battle.bonusregions
{
   import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class BonusRegionResource
   {
      private var _dropZoneResource:ImageResource;
      
      private var _regionType:BonusesType;
      
      public function BonusRegionResource(param1:ImageResource = null, param2:BonusesType = null)
      {
         super();
         this._dropZoneResource = param1;
         this._regionType = param2;
      }
      
      public function get dropZoneResource() : ImageResource
      {
         return this._dropZoneResource;
      }
      
      public function set dropZoneResource(param1:ImageResource) : void
      {
         this._dropZoneResource = param1;
      }
      
      public function get regionType() : BonusesType
      {
         return this._regionType;
      }
      
      public function set regionType(param1:BonusesType) : void
      {
         this._regionType = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BonusRegionResource [";
         _loc1_ += "dropZoneResource = " + this._dropZoneResource + " ";
         _loc1_ += "regionType = " + this._regionType + " ";
         return _loc1_ + "]";
      }
   }
}

