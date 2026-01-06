package alternativa.tanks.models.bonus.bonuslight
{
   import alternativa.tanks.models.teamlight.TeamLightColor;
   import projects.tanks.client.battlefield.models.bonus.bonuslight.BonusLightCC;
   import projects.tanks.client.battlefield.models.bonus.bonuslight.BonusLightModelBase;
   import projects.tanks.client.battlefield.models.bonus.bonuslight.IBonusLightModelBase;
   
   [ModelInfo]
   public class BonusLightModel extends BonusLightModelBase implements IBonusLightModelBase, IBonusLight
   {
      
      public function BonusLightModel()
      {
         super();
      }
      
      public function getBonusLight() : BonusLight
      {
         var _loc1_:BonusLightCC = getInitParam();
         return new BonusLight(new TeamLightColor(uint(_loc1_.lightColor),_loc1_.intensity),_loc1_.attenuationBegin,_loc1_.attenuationEnd);
      }
   }
}

