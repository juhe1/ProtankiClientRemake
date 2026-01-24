package alternativa.tanks.models.tank
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.BodyState;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.UserTitleRenderer;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.BattleEventListener;
   import alternativa.tanks.battle.events.BattleEventSupport;
   import alternativa.tanks.battle.events.TankAddedToBattleEvent;
   import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.utils.EncryptedNumber;
   import alternativa.tanks.utils.EncryptedNumberImpl;
   import alternativa.utils.clearDictionary;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.type.AutoClosable;
   
   public class RegularUserTitleRenderer implements UserTitleRenderer, AutoClosable, BattleEventListener
   {
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const DISTANCE_TO_SHOW_TITLES:EncryptedNumber = new EncryptedNumberImpl(7000);
      
      private static const DISTANCE_TO_HIDE_TITLES:EncryptedNumber = new EncryptedNumberImpl(7050);
      
      private var localTank:Tank;
      
      private var battleEventSupport:BattleEventSupport;
      
      private const remoteTanksInBattle:Dictionary = new Dictionary();
      
      public function RegularUserTitleRenderer(param1:Tank, param2:Dictionary)
      {
         super();
         this.localTank = param1;
         this.remoteTankAddToBattle(param2);
         this.battleEventSupport = new BattleEventSupport(battleEventDispatcher,this);
         this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
         this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
         this.battleEventSupport.activateHandlers();
      }
      
      private function remoteTankAddToBattle(param1:Dictionary) : void
      {
         var _loc2_:Tank = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_ != this.localTank)
            {
               this.remoteTanksInBattle[_loc2_] = true;
            }
         }
      }
      
      private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void
      {
         if(param1.tank != this.localTank)
         {
            this.remoteTanksInBattle[param1.tank] = true;
         }
      }
      
      private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void
      {
         if(param1.tank != this.localTank)
         {
            delete this.remoteTanksInBattle[param1.tank];
         }
      }
      
      public function handleBattleEvent(param1:Object) : void
      {
         this.battleEventSupport.handleBattleEvent(param1);
      }
      
      public function renderUserTitles() : void
      {
         var _loc4_:* = undefined;
         var _loc1_:BattleScene3D = battleService.getBattleScene3D();
         var _loc2_:GameCamera = _loc1_.getCamera();
         var _loc3_:Vector3 = _loc2_.position;
         for(_loc4_ in this.remoteTanksInBattle)
         {
            this.updateTitleVisibility(_loc4_,_loc3_);
         }
      }
      
      private function updateTitleVisibility(param1:Tank, param2:Vector3) : void
      {
         if(param1.health > 0)
         {
            if(this.localTank.isSameTeam(param1.teamType))
            {
               param1.showTitle();
            }
            else
            {
               this.updateTitleForEnemyTank(param1,param2);
            }
         }
         else
         {
            param1.hideTitle();
         }
      }
      
      private function updateTitleForEnemyTank(param1:Tank, param2:Vector3) : void
      {
         var _loc3_:Body = param1.getBody();
         var _loc4_:BodyState = _loc3_.state;
         var _loc5_:Vector3 = _loc4_.position;
         var _loc6_:Number = _loc5_.x - param2.x;
         var _loc7_:Number = _loc5_.y - param2.y;
         var _loc8_:Number = _loc5_.z - param2.z;
         var _loc9_:Number = Math.sqrt(_loc6_ * _loc6_ + _loc7_ * _loc7_ + _loc8_ * _loc8_);
         if(_loc9_ >= DISTANCE_TO_HIDE_TITLES.getNumber() || param1.isInvisible(param2))
         {
            param1.hideTitle();
         }
         else if(_loc9_ < DISTANCE_TO_SHOW_TITLES.getNumber())
         {
            param1.showTitle();
         }
      }
      
      [Obfuscation(rename="false")]
      public function close() : void
      {
         this.battleEventSupport.deactivateHandlers();
         this.battleEventSupport = null;
         this.localTank = null;
         clearDictionary(this.remoteTanksInBattle);
      }
   }
}

