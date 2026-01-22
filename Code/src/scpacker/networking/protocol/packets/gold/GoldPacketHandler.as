package scpacker.networking.protocol.packets.gold
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.types.Long;
   import scpacker.networking.protocol.AbstractPacket;
   import platform.client.fp10.core.resource.types.SoundResource;
   import alternativa.tanks.models.bonus.gold.BattleGoldBonusesModel;
   import alternativa.tanks.models.bonus.goldbonus.GoldBonusesModel;
   import projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal.BattleGoldBonusesModelBase;
   import projects.tanks.client.battlefield.models.bonus.battle.goldbonus.GoldBonusesModelBase;
   import utils.TankNameGameObjectMapper;
   import platform.client.fp10.core.model.impl.Model;
   import scpacker.networking.protocol.packets.battle.BattlePacketHandler;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import alternativa.osgi.service.display.IDisplay;
   import platform.client.fp10.core.type.IGameObject;
   
   public class GoldPacketHandler extends AbstractPacketHandler
   {
      private var battleGoldBonusesModel:BattleGoldBonusesModel;
      private var goldBonusModel:GoldBonusesModel;

      [Inject]
      public static var display:IDisplay;
      
      public function GoldPacketHandler()
      {
         super();
         this.id = 65;
         this.battleGoldBonusesModel = BattleGoldBonusesModel(modelRegistry.getModel(BattleGoldBonusesModelBase.modelId));
         this.goldBonusModel = GoldBonusesModel(modelRegistry.getModel(GoldBonusesModelBase.modelId));
         display.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
      }

      private function onKeyDown(event:KeyboardEvent):void
      {
         if (event.keyCode == Keyboard.Y)
         {
            debugGold();
         }
      }

      private function debugGold():void
      {
         var fakePacket:NotificationBonusContainsUidInPacket = new NotificationBonusContainsUidInPacket();
         fakePacket.reason = "Gold bonus droped by %USERNAME%!";
         fakePacket.username = "NewPc";
         notificationBonusContainsUid(fakePacket);

         var fakePacket2:NotificationBonusInPacket = new NotificationBonusInPacket();
         fakePacket2.reason = "Gold bonus droped!";
         notificationBonus(fakePacket2);

         var fakePacket3:GoldTakenInPacket = new GoldTakenInPacket();
         fakePacket3.username = "NewPc";
         goldTaken(fakePacket3);
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case GoldTakenInPacket.id:
               this.goldTaken(param1 as GoldTakenInPacket);
               break;
            case NotificationBonusContainsUidInPacket.id:
               this.notificationBonusContainsUid(param1 as NotificationBonusContainsUidInPacket);
               break;
            case NotificationBonusInPacket.id:
               this.notificationBonus(param1 as NotificationBonusInPacket);
         }
      }
      
      private function goldTaken(param1:GoldTakenInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject; // This is technically wrong object, but it works, because it is in right space only the space is curretnly used from it inside the model.
         this.battleGoldBonusesModel.goldTaken(TankNameGameObjectMapper.getGameObjectByTankName(param1.username));
         Model.popObject();
      }
      
      private function notificationBonusContainsUid(param1:NotificationBonusContainsUidInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         var reason:String = param1.reason.replace("%USERNAME%",param1.username);
         this.goldBonusModel.notificationProtanki(reason, null);
         Model.popObject();
      }
      
      private function notificationBonus(param1:NotificationBonusInPacket) : void
      {
         Model.object = BattlePacketHandler.battlefieldGameObject;
         this.goldBonusModel.notificationProtanki(param1.reason, param1.soundId as SoundResource);
         Model.popObject();
      }
   }
}

