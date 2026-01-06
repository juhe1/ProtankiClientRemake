package alternativa.tanks.models.battle.jgr.killstreak
{
   import alternativa.tanks.models.battle.ctf.MessageColor;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
   import alternativa.tanks.models.battle.jgr.Juggernaut;
   import alternativa.tanks.models.statistics.IClientUserInfo;
   import alternativa.tanks.models.tank.bosstate.IBossState;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.types.Long;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.battlefield.models.battle.jgr.killstreak.IKillStreakModelBase;
   import projects.tanks.client.battlefield.models.battle.jgr.killstreak.KillStreakItem;
   import projects.tanks.client.battlefield.models.battle.jgr.killstreak.KillStreakModelBase;
   import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class KillStreakModel extends KillStreakModelBase implements IKillStreakModelBase, ObjectLoadListener
   {
      
      [Inject]
      public static var usersRegistry:TankUsersRegistry;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      private static const KILLSTREAK_VOLUME:Number = 0.9;
      
      private var killStreaks:Vector.<KillStreakClientItem> = new Vector.<KillStreakClientItem>();
      
      public function KillStreakModel()
      {
         super();
      }
      
      private static function getUserUid(param1:Long) : String
      {
         var _loc2_:ShortUserInfo = null;
         if(param1 != null)
         {
            _loc2_ = IClientUserInfo(object.adapt(IClientUserInfo)).getShortUserInfo(param1);
            if(_loc2_ != null)
            {
               return _loc2_.uid;
            }
         }
         return null;
      }
      
      public function objectLoaded() : void
      {
         var _loc2_:KillStreakItem = null;
         var _loc3_:Sound3D = null;
         this.killStreaks.length = getInitParam().items.length;
         var _loc1_:int = 0;
         while(_loc1_ < getInitParam().items.length)
         {
            _loc2_ = getInitParam().items[_loc1_];
            _loc3_ = Sound3D.create(_loc2_.sound.sound);
            _loc3_.volume = KILLSTREAK_VOLUME;
            this.killStreaks[_loc1_] = new KillStreakClientItem(_loc2_.messageToBoss,_loc2_.messageToVictims,_loc3_);
            _loc1_++;
         }
      }
      
      public function killStreakAchived(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc6_:Sound3D = null;
         var _loc2_:KillStreakClientItem = this.killStreaks[param1];
         var _loc3_:BossRelationRole = !battleInfoService.isSpectatorMode() ? IBossState(usersRegistry.getLocalUser().adapt(IBossState)).role() : null;
         if(_loc3_ == BossRelationRole.BOSS)
         {
            _loc4_ = _loc2_.messageToBoss != null ? _loc2_.messageToBoss : _loc2_.messageToVictims;
         }
         else
         {
            _loc4_ = _loc2_.messageToVictims;
         }
         var _loc5_:String = getUserUid(object.adapt(Juggernaut).bossId());
         if(_loc5_ != null)
         {
            _loc4_ = _loc4_.replace("%1",_loc5_);
         }
         this.getGuiModel().showBattleMessage(MessageColor.ORANGE,_loc4_);
         if(_loc2_.sound != null)
         {
            _loc6_ = null;
            if(_loc6_ != null)
            {
               _loc6_.stop();
            }
            _loc2_.sound.play(0,0);
         }
      }
      
      private function getGuiModel() : BattlefieldGUI
      {
         return BattlefieldGUI(object.adapt(BattlefieldGUI));
      }
   }
}

