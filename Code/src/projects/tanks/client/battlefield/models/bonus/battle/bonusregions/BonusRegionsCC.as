package projects.tanks.client.battlefield.models.bonus.battle.bonusregions
{
   public class BonusRegionsCC
   {
      private var newname_10007__END:Vector.<BonusRegionResource>;
      
      private var newname_2667__END:Vector.<BonusRegionData>;
      
      public function BonusRegionsCC(param1:Vector.<BonusRegionResource> = null, param2:Vector.<BonusRegionData> = null)
      {
         super();
         this.newname_10007__END = param1;
         this.newname_2667__END = param2;
      }
      
      public function get bonusRegionResources() : Vector.<BonusRegionResource>
      {
         return this.newname_10007__END;
      }
      
      public function set bonusRegionResources(param1:Vector.<BonusRegionResource>) : void
      {
         this.newname_10007__END = param1;
      }
      
      public function get bonusRegions() : Vector.<BonusRegionData>
      {
         return this.newname_2667__END;
      }
      
      public function set bonusRegions(param1:Vector.<BonusRegionData>) : void
      {
         this.newname_2667__END = param1;
      }
   }
}

