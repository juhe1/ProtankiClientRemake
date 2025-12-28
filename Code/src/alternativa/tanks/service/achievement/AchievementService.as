package alternativa.tanks.service.achievement
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.gui.CongratulationsWindowPresent;
   import alternativa.tanks.help.achievements.BattleFightButtonHelper;
   import alternativa.tanks.help.achievements.BattleStartButtonHelper;
   import alternativa.tanks.help.achievements.DonateButtonHelper;
   import alternativa.tanks.help.achievements.FirstBattleCreateHelper;
   import alternativa.tanks.help.achievements.FirstBattleFightHelper;
   import alternativa.tanks.help.achievements.FirstPurchaseHelper;
   import alternativa.tanks.help.achievements.PurchaseButtonHelper;
   import alternativa.tanks.help.achievements.SetEmailHelper;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
   import projects.tanks.client.achievements.model.Achievement;
   import projects.tanks.client.commons.models.layout.LayoutState;
   import projects.tanks.clients.flash.commons.services.layout.LobbyLayoutService;
   import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   
   public class AchievementService implements IAchievementService
   {
      
      [Inject] // added
      public static var helpService:IHelpService;
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject] // added
      public static var partnersService:IPartnerService;
      
      //[Inject]
      //public static var clanPanelNotification:ClanPanelNotificationService;
      
      private static const bitmapPresent:Class = AchievementService_bitmapPresent;
      
      private static const present:BitmapData = (new bitmapPresent() as Bitmap).bitmapData;
      
      private const HELPER_GROUP_KEY:String = "GarageModel";
      
      private var battle:FirstBattleCreateHelper;
      
      private var battleButtonStart:BattleStartButtonHelper;
      
      private var fight:FirstBattleFightHelper;
      
      private var fightButton:BattleFightButtonHelper;
      
      private var donateButton:DonateButtonHelper;
      
      private var purchase:FirstPurchaseHelper;
      
      private var purchaseButton:PurchaseButtonHelper;
      
      private var email:SetEmailHelper;
      
      private var currentAchievements:Vector.<Achievement>;
      
      private var panelPartition:int = 0;
      
      private var inBattle:Boolean;
      
      private var createFormVisible:Boolean = false;
      
      public function AchievementService()
      {
         super();
         this.init();
      }
      
      private static function isLoadedServiceObject() : Boolean
      {
         return LobbyLayoutService(lobbyLayoutService).getServiceGameObject() != null;
      }
      
      private function init() : void
      {
         this.battle = new FirstBattleCreateHelper();
         this.battleButtonStart = new BattleStartButtonHelper();
         this.fight = new FirstBattleFightHelper();
         this.fightButton = new BattleFightButtonHelper();
         this.donateButton = new DonateButtonHelper();
         this.purchase = new FirstPurchaseHelper();
         this.purchaseButton = new PurchaseButtonHelper();
         this.email = new SetEmailHelper();
         var _loc1_:IHelpService = IHelpService(OSGi.getInstance().getService(IHelpService));
         _loc1_.registerHelper(this.HELPER_GROUP_KEY,800,this.battle,false);
         _loc1_.registerHelper(this.HELPER_GROUP_KEY,802,this.fight,false);
         _loc1_.registerHelper(this.HELPER_GROUP_KEY,803,this.fightButton,false);
         _loc1_.registerHelper(this.HELPER_GROUP_KEY,805,this.donateButton,false);
         _loc1_.registerHelper(this.HELPER_GROUP_KEY,806,this.purchase,false);
         _loc1_.registerHelper(this.HELPER_GROUP_KEY,807,this.purchaseButton,false);
         _loc1_.registerHelper(this.HELPER_GROUP_KEY,809,this.email,false);
         _loc1_.registerHelper(this.HELPER_GROUP_KEY,811,this.battleButtonStart,false);
         this.currentAchievements = new Vector.<Achievement>();
      }
      
      public function setAchievements(param1:Vector.<Achievement>) : void
      {
         lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.endSwitch);
         if(lobbyLayoutService.getCurrentState() == LayoutState.BATTLE)
         {
            this.hideAllBubbles(true);
         }
         this.currentAchievements = new Vector.<Achievement>();
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!(param1[_loc3_] == Achievement.FIRST_REFERRAL && Boolean(partnersService.isRunningInsidePartnerEnvironment())))
            {
               this.currentAchievements.push(param1[_loc3_]);
            }
            _loc3_++;
         }
         if(this.currentAchievements.length != 0)
         {
            this.showCurrentAchievementBubbles();
            this.alignHelpers();
            display.stage.addEventListener(Event.RESIZE,this.alignHelpers);
         }
      }
      
      private function endSwitch(param1:LobbyLayoutServiceEvent) : void
      {
         if(param1.state != LayoutState.BATTLE)
         {
            this.inBattle = false;
            this.showCurrentAchievementBubbles();
         }
      }
      
      public function setGarageBuyButtonTargetPoint(param1:Point) : void
      {
         this.purchaseButton.targetPoint = param1;
         this.showCurrentAchievementBubbles();
         this.alignHelpers();
      }
      
      public function setBattleStartButtonTargetPoint(param1:Point) : void
      {
         this.fightButton.targetPoint = param1;
         this.showCurrentAchievementBubbles();
         this.alignHelpers();
      }
      
      public function setPaymentResumeButtonTargetPoint(param1:Point) : void
      {
         this.donateButton.targetPoint = param1;
         this.showCurrentAchievementBubbles();
         this.alignHelpers();
      }
      
      public function hideAllBubbles(param1:Boolean) : void
      {
         var _loc2_:int = 800;
         while(_loc2_ < 812)
         {
            helpService.hideHelper(this.HELPER_GROUP_KEY,_loc2_);
            _loc2_++;
         }
         helpService.hideHelp();
         this.inBattle = param1;
      }
      
      public function showStartButtonHelper() : void
      {
         this.createFormVisible = true;
         this.showCurrentAchievementBubbles();
      }
      
      public function hideStartButtonHelper() : void
      {
         this.createFormVisible = false;
         this.showCurrentAchievementBubbles();
      }
      
      public function completeAchievement(param1:Achievement, param2:String, param3:int) : void
      {
         this.removeAchievement(param1);
         this.hideAllBubbles(this.inBattle);
         var _loc4_:CongratulationsWindowPresent = new CongratulationsWindowPresent(present,null,param2);
      }
      
      private function removeAchievement(param1:Achievement) : void
      {
         if(this.currentAchievements.indexOf(param1) != -1)
         {
            this.currentAchievements.splice(this.currentAchievements.indexOf(param1),1);
         }
      }
      
      public function removeGarageButtonAchievement() : void
      {
         this.removeAchievement(Achievement.FIRST_PURCHASE);
         helpService.manuallyShutDownHelper(this.purchaseButton);
      }
      
      public function activateAchievement(param1:Achievement) : void
      {
         if(!(param1 == Achievement.FIRST_REFERRAL && Boolean(partnersService.isRunningInsidePartnerEnvironment())))
         {
            this.currentAchievements.push(param1);
         }
         this.showCurrentAchievementBubbles();
         this.alignHelpers();
      }
      
      private function showCurrentAchievementBubbles() : void
      {
         var _loc3_:Achievement = null;
         if(this.inBattle || !isLoadedServiceObject() || Boolean(lobbyLayoutService.inBattle()))
         {
            return;
         }
         var _loc1_:int = 800;
         while(_loc1_ < 812)
         {
            helpService.hideHelper(this.HELPER_GROUP_KEY,_loc1_);
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.currentAchievements.length)
         {
            _loc3_ = this.currentAchievements[_loc2_];
            switch(_loc3_)
            {
               case Achievement.FIRST_PURCHASE:
                  if(this.panelPartition == 1 && this.purchaseButton.targetPoint.x != 0)
                  {
                     helpService.showHelper(this.HELPER_GROUP_KEY,807,true);
                  }
                  else if(this.panelPartition != 1)
                  {
                     helpService.showHelperIfAble(this.HELPER_GROUP_KEY,806,true);
                  }
                  break;
               case Achievement.FIGHT_FIRST_BATTLE:
                  if(this.panelPartition == 0)
                  {
                     helpService.showHelperIfAble(this.HELPER_GROUP_KEY,803,true);
                  }
                  else
                  {
                     helpService.showHelperIfAble(this.HELPER_GROUP_KEY,802,true);
                  }
                  break;
               case Achievement.FIRST_REFERRAL:
                  helpService.showHelper(this.HELPER_GROUP_KEY,808,true);
            }
            _loc2_++;
         }
      }
      
      private function alignHelpers(param1:Event = null) : void
      {
         var _loc2_:int = int(Math.max(970,display.stage.stageWidth));
         var _loc3_:int = int(Math.max(580,display.stage.stageHeight));
         var _loc4_:int = this.getClanButtonWidth();
         if(partnersService.isRunningInsidePartnerEnvironment())
         {
            _loc4_ -= 28;
         }
         this.battle.targetPoint = new Point(_loc2_ - 295 - _loc4_,30);
         this.battleButtonStart.targetPoint = new Point(_loc2_ - 35,_loc3_ - 30);
         this.fight.targetPoint = new Point(_loc2_ - 292 - _loc4_,30);
         this.purchase.targetPoint = new Point(_loc2_ - 180 - _loc4_,30);
         this.email.targetPoint = new Point(_loc2_ - 110,30);
      }
      
      private function getClanButtonWidth() : int
      {
         //return clanPanelNotification.clanButtonVisible ? 90 : 0;
         return 0;
      }
   }
}

