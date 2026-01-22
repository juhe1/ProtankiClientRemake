package alternativa.tanks.models.bonus.goldbonus
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.models.battle.ctf.MessageColor;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.bonus.notification.BonusNotification;
   import alternativa.tanks.services.bonusregion.IBonusRegionService;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
   import projects.tanks.client.battlefield.models.bonus.battle.goldbonus.GoldBonusesModelBase;
   import projects.tanks.client.battlefield.models.bonus.battle.goldbonus.IGoldBonusesModelBase;
   import projects.tanks.client.battlefield.models.bonus.battle.goldbonus.GoldBonusCC;
   
   [ModelInfo]
   public class GoldBonusesModel extends GoldBonusesModelBase implements IGoldBonusesModelBase, IGoldBonus
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var bonusRegionService:IBonusRegionService;
      
      private static const UID_PATTERN:String = "%USERNAME%";
      
      public function GoldBonusesModel()
      {
         super();
      }
      
      public function getRegions() : Vector.<BonusRegionData>
      {
         return getInitParam().regionsData;
      }
      
      [Obfuscation(rename="false")]
      public function notificationBonus(param1:IGameObject, param2:BonusRegionData) : void
      {
         var _loc3_:BonusNotification = BonusNotification(param1.adapt(BonusNotification));
         this.notification(param1,param2,_loc3_.getMessage());
      }
      
      [Obfuscation(rename="false")]
      public function notificationBonusContainsUid(param1:IGameObject, param2:String, param3:BonusRegionData) : void
      {
         var _loc4_:BonusNotification = BonusNotification(param1.adapt(BonusNotification));
         var _loc5_:String = _loc4_.getMessageContainsUid().replace(UID_PATTERN,param2);
         this.notification(param1,param3,_loc5_);
      }
      
      private function notification(param1:IGameObject, param2:BonusRegionData, param3:String) : void
      {
         var _loc4_:SoundResource = BonusNotification(param1.adapt(BonusNotification)).getSoundNotification();
         if(_loc4_ != null)
         {
            battleService.soundManager.playSound(_loc4_.sound);
         }
         var _loc5_:BattlefieldGUI = BattlefieldGUI(object.adapt(BattlefieldGUI));
         _loc5_.showBattleMessage(MessageColor.ORANGE,param3);
         bonusRegionService.addAndShowRegion(param2);
      }

      public function notificationProtanki(message:String, sound:SoundResource) : void
      {
         if(sound != null)
         {
            battleService.soundManager.playSound(sound.sound);
         }
         var _loc5_:BattlefieldGUI = BattlefieldGUI(object.adapt(BattlefieldGUI));
         _loc5_.showBattleMessage(MessageColor.ORANGE,message);
      }
      
      [Obfuscation(rename="false")]
      public function hideDropZone(param1:BonusRegionData) : void
      {
         bonusRegionService.hideAndRemoveRegion(param1);
      }
   }
}

