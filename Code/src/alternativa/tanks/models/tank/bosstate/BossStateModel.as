package alternativa.tanks.models.tank.bosstate
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.models.battle.ctf.MessageColor;
   import alternativa.tanks.models.battle.gui.BattlefieldGUI;
   import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
   import alternativa.tanks.models.inventory.IInventoryModel;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.models.inventory.InventoryLock;
   import alternativa.tanks.models.tank.ITankModel;
   import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
   import projects.tanks.client.battlefield.models.user.bossstate.BossStateModelBase;
   import projects.tanks.client.battlefield.models.user.bossstate.IBossStateModelBase;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   [ModelInfo]
   public class BossStateModel extends BossStateModelBase implements IBossStateModelBase, IBossState
   {
      
      [Inject]
      public static var localeService:ILocaleService;
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      [Inject]
      public static var inventoryPanel:IInventoryPanel;
      
      private var inventoryLockMask:Vector.<int>;
      
      public function BossStateModel()
      {
         super();
         this.inventoryLockMask = new Vector.<int>();
         this.inventoryLockMask.push(InventoryItemType.FIRST_AID);
         this.inventoryLockMask.push(InventoryItemType.ARMOR);
         this.inventoryLockMask.push(InventoryItemType.DAMAGE);
         this.inventoryLockMask.push(InventoryItemType.NITRO);
         this.inventoryLockMask.push(InventoryItemType.MINE);
      }
      
      public function changeRole(param1:BossRelationRole) : void
      {
         var _loc3_:IInventoryModel = null;
         var _loc4_:String = null;
         putData(BossRelationRole,param1);
         var _loc2_:ITankModel = ITankModel(object.adapt(ITankModel));
         if(_loc2_.getUserInfo().isLocal)
         {
            this.setInfiniteEffect(param1);
            if(param1 == BossRelationRole.INCARNATION)
            {
               _loc4_ = localeService.getText(TanksLocale.TEXT_JGR_YOU_ARE_THE_BOSS);
               this.getBattleGUI().showBattleMessage(MessageColor.POSITIVE,_loc4_);
            }
            _loc3_ = IInventoryModel(object.space.rootObject.adapt(IInventoryModel));
            if(param1 == BossRelationRole.BOSS || param1 == BossRelationRole.INCARNATION)
            {
               _loc3_.lockItemsByMask(this.inventoryLockMask,InventoryLock.BOSS_STATE,true);
               battleInfoService.enterGarageCausesExitBattle = true;
            }
            else
            {
               _loc3_.lockItemsByMask(this.inventoryLockMask,InventoryLock.BOSS_STATE,false);
               battleInfoService.enterGarageCausesExitBattle = false;
            }
         }
      }
      
      private function setInfiniteEffect(param1:BossRelationRole) : void
      {
         var _loc2_:Boolean = param1 == BossRelationRole.BOSS;
         if(!_loc2_)
         {
            return;
         }
         inventoryPanel.setEffectInfinite(InventoryItemType.ARMOR,true);
         inventoryPanel.setEffectInfinite(InventoryItemType.DAMAGE,true);
         inventoryPanel.setEffectInfinite(InventoryItemType.NITRO,true);
      }
      
      public function role() : BossRelationRole
      {
         var _loc1_:BossRelationRole = BossRelationRole(getData(BossRelationRole));
         return _loc1_ != null ? _loc1_ : BossRelationRole.VICTIM;
      }
      
      private function getBattleGUI() : BattlefieldGUI
      {
         return BattlefieldGUI(object.space.rootObject.adapt(BattlefieldGUI));
      }
   }
}

