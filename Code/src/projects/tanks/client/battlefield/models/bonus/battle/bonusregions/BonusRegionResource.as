package projects.tanks.client.battlefield.models.bonus.battle.bonusregions
{
   import platform.client.fp10.core.resource.types.TextureResource;
   import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;
   
   public class BonusRegionResource
   {
      
      private var _dropZoneResource:TextureResource;
      
      private var _regionType:BonusesType;
      
      public function BonusRegionResource(param1:TextureResource = null, param2:BonusesType = null)
      {
         super();
         this._dropZoneResource = param1;
         this._regionType = param2;
      }
      
      public function get dropZoneResource() : TextureResource
      {
         return this._dropZoneResource;
      }
      
      public function set dropZoneResource(param1:TextureResource) : void
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
         _loc1_ += "dropZoneResource = " + this.dropZoneResource + " ";
         _loc1_ += "regionType = " + this.regionType + " ";
         return _loc1_ + "]";
      }
   }
}

