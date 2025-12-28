package alternativa.tanks.model.userproperties
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.gui.panel.MainPanel;
   import alternativa.tanks.gui.panel.PlayerInfo;
   import alternativa.tanks.service.money.IMoneyService;
   import alternativa.tanks.service.panel.IPanelView;
   import alternativa.tanks.service.panel.PanelInitedEvent;
   import alternativa.tanks.tracker.ITrackerService;
   import alternativa.types.Long;
   import controls.panel.UpdateRankNotice;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import projects.tanks.client.panel.model.profile.userproperties.IUserPropertiesModelBase;
   import projects.tanks.client.panel.model.profile.userproperties.UserPropertiesModelBase;
   import projects.tanks.client.users.model.userbattlestatistics.rank.RankBounds;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   
   [ModelInfo]
   public class UserPropertiesModel extends UserPropertiesModelBase implements IUserPropertiesModelBase, ObjectLoadListener, ObjectLoadPostListener, IUserProperties
   {
      
      [Inject] // added
      public static var panelView:IPanelView;
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var helpService:IHelpService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject] // added
      public static var moneyService:IMoneyService;
      
      [Inject] // added
      public static var trackerService:ITrackerService;
      
      //[Inject]
      //public static var clanUserInfoService:ClanUserInfoService;
      
      private var CHANNEL:String = "UserPropertiesModel";
      
      private var _id:String;
      
      private var _name:String;
      
      private var _score:int;
      
      private var _rank:int;
      
      private var _nextScore:int;
      
      private var _place:int;
      
      private var _currentRankScore:int;
      
      public function UserPropertiesModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         userPropertiesService.init(getInitParam().id,getInitParam().uid,getInitParam().score,getInitParam().rank,getInitParam().userProfileUrl,getInitParam().registrationTimestamp,getInitParam().hasSpectatorPermissions,getInitParam().canUseGroup);
      }
      
      public function objectLoadedPost() : void
      {
         this._id = getInitParam().id;
         this._name = getInitParam().uid;
         this._nextScore = getInitParam().rankBounds.topBound;
         this._score = getInitParam().score;
         this._currentRankScore = getInitParam().rankBounds.lowBound;
         this._rank = getInitParam().rank;

         //panelView.addEventListener(PanelInitedEvent.TYPE,getFunctionWrapper(this.onPanelInitialized));
         // original line above replaced with the line below
         panelView.addEventListener(PanelInitedEvent.TYPE,this.onPanelInitialized);

         if(getInitParam().daysFromLastVisit > 0)
         {
            trackerService.trackEvent("lobby","ReturnVisit",getInitParam().daysFromRegistration.toString());
            trackerService.trackEvent("lobby","DaysLastVisit",getInitParam().daysFromLastVisit.toString());
         }
      }
      
      private function onPanelInitialized(param1:PanelInitedEvent) : void
      {
         //panelView.removeEventListener(PanelInitedEvent.TYPE,getFunctionWrapper(this.onPanelInitialized));
         // original line above replaced with the line below
         panelView.removeEventListener(PanelInitedEvent.TYPE,this.onPanelInitialized);
         var _loc2_:MainPanel = panelView.getPanel();
         _loc2_.rank = this._rank;
         this.updateScore(this._score);
         _loc2_.playerInfo.playerName = this._name;
         moneyService.init(getInitParam().crystals);
         this.updateGearScore(getInitParam().gearScore);
      }
      
      public function updateScore(param1:int) : void
      {
         var _loc2_:int = this._score;
         this._score = param1;
         panelView.getPanel().playerInfo.updateScore(param1,this._nextScore);
         this.updateProgress();
         if(param1 != _loc2_)
         {
            userPropertiesService.updateScore(param1);
         }
      }
      
      public function updateRank(param1:int, param2:int, param3:RankBounds, param4:int, param5:Boolean, param6:Boolean) : void
      {
         var _loc7_:int = this._rank;
         this._rank = param1;
         this._score = param2;
         this._nextScore = param3.topBound;
         this._currentRankScore = param3.lowBound;
         var _loc8_:MainPanel = panelView.getPanel();
         _loc8_.rank = param1;
         _loc8_.playerInfo.updateScore(this._score,param3.topBound);
         if(!param6)
         {
            display.stage.addChild(new UpdateRankNotice(param1,param4));
         }
         this.updateProgress();
         //userPropertiesService.updateCanUseGroup(param5);
         if(param1 != _loc7_)
         {
            userPropertiesService.updateRank(param1);
         }
         trackerService.trackEvent("battle","UpdateRank",String(param1));
      }
      
      private function updateProgress() : void
      {
         var _loc1_:int = 0;
         if(this._nextScore != 0)
         {
            _loc1_ = (this._score - this._currentRankScore) / (this._nextScore - this._currentRankScore) * 10000;
         }
         else
         {
            _loc1_ = 10000;
         }
         panelView.getPanel().playerInfo.progress = _loc1_;
      }
      
      public function getId() : String
      {
         return this._id;
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getScore() : int
      {
         return this._score;
      }
      
      public function getRank() : int
      {
         return this._rank;
      }
      
      public function getNextScore() : int
      {
         return this._nextScore;
      }
      
      public function getPlace() : int
      {
         return this._place;
      }
      
      public function changeCrystal(param1:int) : void
      {
         moneyService.setServerCrystals(param1);
      }
      
      public function updateUid(param1:String) : void
      {
         this.getPlayerInfo().playerName = param1;
      }
      
      private function getPlayerInfo() : PlayerInfo
      {
         return panelView.getPanel().playerInfo;
      }
      
      public function onJoinClan() : void
      {
         //clanUserInfoService.onJoinClan();
      }
      
      public function onLeaveClan() : void
      {
         //clanUserInfoService.onLeaveClan();
      }
      
      public function updateGearScore(param1:int) : void
      {
         this.getPlayerInfo().gearScore = param1;
      }
      
      public function updateUserRating(param1:int) : void
      {
      }
   }
}

