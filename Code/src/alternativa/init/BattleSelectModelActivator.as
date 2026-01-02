package alternativa.init
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleActivator;
   import alternativa.tanks.service.battlecreate.BattleCreateFormService;
   import alternativa.tanks.service.battlecreate.IBattleCreateFormService;
   import alternativa.tanks.service.battlelist.BattleListFormService;
   import alternativa.tanks.service.battlelist.IBattleListFormService;
   import alternativa.tanks.service.battle.IBattleUserInfoService;
   import alternativa.tanks.service.battleinfo.IBattleInfoFormService;
   import alternativa.tanks.service.battleinfo.BattleInfoFormService;
   import alternativa.tanks.service.battle.BattleUserInfoService;
   
   public class BattleSelectModelActivator implements IBundleActivator
   {
      
      public function BattleSelectModelActivator()
      {
         super();
      }
      
      public function start(param1:OSGi) : void
      {
         param1.registerService(IBattleCreateFormService,new BattleCreateFormService());
         param1.registerService(IBattleListFormService,new BattleListFormService());
         param1.registerService(IBattleInfoFormService,new BattleInfoFormService());
         param1.registerService(IBattleUserInfoService,new BattleUserInfoService());
         //var _loc2_:MatchmakingFormServiceImpl = new MatchmakingFormServiceImpl();
         //param1.registerService(MatchmakingFormService,_loc2_);
         //param1.registerService(MatchmakingGroupFormService,_loc2_);
         //param1.registerService(MatchmakingGroupInviteService,_loc2_);
         //param1.registerService(InviteWindowService,new InviteWindowServiceImpl());
      }
      
      public function stop(param1:OSGi) : void
      {
      }
   }
}

