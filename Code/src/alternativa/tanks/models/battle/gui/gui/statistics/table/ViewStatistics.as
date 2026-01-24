package alternativa.tanks.models.battle.gui.gui.statistics.table
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.models.battle.gui.statistics.ClientUserStat;
   import alternativa.types.Long;
   import controls.Label;
   import controls.resultassets.ResultWindowBase;
   import controls.resultassets.ResultWindowBlue;
   import controls.resultassets.ResultWindowBlueHeader;
   import controls.resultassets.ResultWindowGreen;
   import controls.resultassets.ResultWindowGreenHeader;
   import controls.resultassets.ResultWindowRed;
   import controls.resultassets.ResultWindowRedHeader;
   import controls.scroller.blue.ScrollSkinBlue;
   import controls.scroller.blue.ScrollThumbSkinBlue;
   import controls.scroller.green.ScrollSkinGreen;
   import controls.scroller.green.ScrollThumbSkinGreen;
   import controls.scroller.red.ScrollSkinRed;
   import controls.scroller.red.ScrollThumbSkinRed;
   import fl.controls.List;
   import fl.data.DataProvider;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class ViewStatistics extends Sprite
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private static var scrollBarStyles:Object;
      
      public static const BLUE:int = 0;
      
      public static const RED:int = 1;
      
      public static const GREEN:int = 2;
      
      private static const MIN_HEIGHT:int = 52;
      
      private static const TABLE_MARGIN:int = 7;
      
      private static const EXTRA_HEIGHT:int = 12;
      
      private static const EXTRA_WIDTH:int = 20;
      
      private var list:List;
      
      private var dp:DataProvider = new DataProvider();
      
      private var inner:ResultWindowBase;
      
      private var type:int;
      
      private var localUserId:String;
      
      private var finish:Boolean;
      
      private var localUserTeam:BattleTeam;
      
      private var header:Sprite;
      
      private var captionCallsign:String;
      
      private var captionScore:String;
      
      private var captionKills:String;
      
      private var captionDeaths:String;
      
      private var captionKDRatio:String;
      
      private var captionReward:String;
      
      private var captionStarsReward:String;
      
      private var showStars:Boolean;
      
      public function ViewStatistics(param1:int, param2:String, param3:Boolean, param4:BattleTeam, param5:Boolean)
      {
         super();
         if(scrollBarStyles == null)
         {
            initScrollBarStyles();
         }
         this.type = param1;
         this.localUserId = param2;
         this.finish = param3;
         this.localUserTeam = param4;
         this.tabEnabled = false;
         this.tabChildren = false;
         this.showStars = param5;
         this.captionCallsign = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_CALLSIGN);
         this.captionScore = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_SCORE);
         this.captionKills = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_KILLS);
         this.captionDeaths = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_DEATHS);
         this.captionKDRatio = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_KDRATIO);
         this.captionReward = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_REWARD);
         this.captionStarsReward = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_STARS_REWARD);
         this.init();
      }
      
      private static function initScrollBarStyles() : void
      {
         scrollBarStyles = {};
         addScrollBarStyle("downArrowUpSkin",ScrollSkinGreen.trackBottom,ScrollSkinRed.trackBottom,ScrollSkinBlue.trackBottom);
         addScrollBarStyle("downArrowDownSkin",ScrollSkinGreen.trackBottom,ScrollSkinRed.trackBottom,ScrollSkinBlue.trackBottom);
         addScrollBarStyle("downArrowOverSkin",ScrollSkinGreen.trackBottom,ScrollSkinRed.trackBottom,ScrollSkinBlue.trackBottom);
         addScrollBarStyle("downArrowDisabledSkin",ScrollSkinGreen.trackBottom,ScrollSkinRed.trackBottom,ScrollSkinBlue.trackBottom);
         addScrollBarStyle("upArrowUpSkin",ScrollSkinGreen.trackTop,ScrollSkinRed.trackTop,ScrollSkinBlue.trackTop);
         addScrollBarStyle("upArrowDownSkin",ScrollSkinGreen.trackTop,ScrollSkinRed.trackTop,ScrollSkinBlue.trackTop);
         addScrollBarStyle("upArrowOverSkin",ScrollSkinGreen.trackTop,ScrollSkinRed.trackTop,ScrollSkinBlue.trackTop);
         addScrollBarStyle("upArrowDisabledSkin",ScrollSkinGreen.trackTop,ScrollSkinRed.trackTop,ScrollSkinBlue.trackTop);
         addScrollBarStyle("trackUpSkin",ScrollSkinGreen.track,ScrollSkinRed.track,ScrollSkinBlue.track);
         addScrollBarStyle("trackDownSkin",ScrollSkinGreen.track,ScrollSkinRed.track,ScrollSkinBlue.track);
         addScrollBarStyle("trackOverSkin",ScrollSkinGreen.track,ScrollSkinRed.track,ScrollSkinBlue.track);
         addScrollBarStyle("trackDisabledSkin",ScrollSkinGreen.track,ScrollSkinRed.track,ScrollSkinBlue.track);
         addScrollBarStyle("thumbUpSkin",ScrollThumbSkinGreen,ScrollThumbSkinRed,ScrollThumbSkinBlue);
         addScrollBarStyle("thumbDownSkin",ScrollThumbSkinGreen,ScrollThumbSkinRed,ScrollThumbSkinBlue);
         addScrollBarStyle("thumbOverSkin",ScrollThumbSkinGreen,ScrollThumbSkinRed,ScrollThumbSkinBlue);
         addScrollBarStyle("thumbDisabledSkin",ScrollThumbSkinGreen,ScrollThumbSkinRed,ScrollThumbSkinBlue);
      }
      
      private static function addScrollBarStyle(param1:String, param2:Class, param3:Class, param4:Class) : void
      {
         var _loc5_:Dictionary = new Dictionary();
         _loc5_[ViewStatistics.GREEN] = param2;
         _loc5_[ViewStatistics.RED] = param3;
         _loc5_[ViewStatistics.BLUE] = param4;
         scrollBarStyles[param1] = _loc5_;
      }
      
      private static function createHeaderLabel(param1:Sprite, param2:String, param3:uint, param4:String, param5:int, param6:int) : Label
      {
         var _loc7_:Label = new Label();
         _loc7_.autoSize = TextFieldAutoSize.NONE;
         _loc7_.text = param2;
         _loc7_.color = param3;
         _loc7_.align = param4;
         _loc7_.x = param6;
         _loc7_.width = param5;
         _loc7_.height = TableConst.ROW_HEIGHT;
         param1.addChild(_loc7_);
         return _loc7_;
      }
      
      public function updatePlayerInfo(param1:ClientUserStat) : void
      {
         var _loc2_:int = param1.userId == null ? -1 : this.indexById(param1.userId);
         if(_loc2_ != -1)
         {
            this.dp.replaceItemAt(this.createDataItem(param1),_loc2_);
            this.sortDp();
         }
      }

      public function updatePlayersInfo(param1:Vector.<ClientUserStat>) : void
      {
         this.dp.removeAll();
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.dp.addItem(this.createDataItem(param1[_loc3_]));
            _loc3_++;
         }
         this.sortDp();
      }

      private function sortDp() : void
      {
         if(this.type == 2)
         {
            this.dp.sortOn(["kills","deaths"],[2 | 0x10,16]);
         }
         else
         {
            this.dp.sortOn(["score","kills","deaths"],[2 | 0x10,2 | 0x10,16]);
         }
      }
      
      private function createDataItem(param1:ClientUserStat) : Object
      {
         var _loc2_:StatisticsData = new StatisticsData();
         _loc2_.id = param1.userId;
         _loc2_.rank = param1.rank;
         _loc2_.uid = param1.uid;
         _loc2_.kills = param1.kills;
         _loc2_.deaths = param1.deaths;
         _loc2_.score = param1.score;
         _loc2_.reward = param1.reward;
         _loc2_.type = this.type;
         _loc2_.self = param1.userId == this.localUserId;
         _loc2_.loaded = param1.loaded;
         _loc2_.suspicious = param1.suspicious;
         _loc2_.stars = param1.stars;
         return _loc2_;
      }
      
      public function removePlayer(param1:String) : void
      {
         var _loc2_:int = this.indexById(param1);
         this.dp.removeItemAt(_loc2_);
      }
      
      public function resize(param1:Number) : void
      {
         var _loc2_:Number = (this.dp.length + 1) * TableConst.ROW_HEIGHT + EXTRA_HEIGHT;
         if(_loc2_ > param1)
         {
            _loc2_ = int(param1 / this.header.height) * this.header.height + EXTRA_HEIGHT;
         }
         this.inner.height = _loc2_ < MIN_HEIGHT ? MIN_HEIGHT : _loc2_;
         this.list.setSize(this.inner.width - 2 * TableConst.TABLE_MARGIN,this.inner.height - this.header.y - this.header.height - 5);
      }
      
      [Obfuscation(rename="false")]
      override public function get height() : Number
      {
         return this.inner.height;
      }
      
      private function indexById(param1:String) : int
      {
         var _loc2_:StatisticsData = null;
         var _loc3_:int = int(this.dp.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this.dp.getItemAt(_loc4_) as StatisticsData;
            if(_loc2_ != null && _loc2_.id == param1)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
      
      private function setScrollbarStyle() : void
      {
         this.setListStyle("downArrowUpSkin");
         this.setListStyle("downArrowDownSkin");
         this.setListStyle("downArrowOverSkin");
         this.setListStyle("downArrowDisabledSkin");
         this.setListStyle("upArrowUpSkin");
         this.setListStyle("upArrowDownSkin");
         this.setListStyle("upArrowOverSkin");
         this.setListStyle("upArrowDisabledSkin");
         this.setListStyle("trackUpSkin");
         this.setListStyle("trackDownSkin");
         this.setListStyle("trackOverSkin");
         this.setListStyle("trackDisabledSkin");
         this.setListStyle("thumbUpSkin");
         this.setListStyle("thumbDownSkin");
         this.setListStyle("thumbOverSkin");
         this.setListStyle("thumbDisabledSkin");
      }
      
      private function setListStyle(param1:String) : void
      {
         this.list.setStyle(param1,scrollBarStyles[param1][this.type]);
      }
      
      private function init() : void
      {
         switch(this.type)
         {
            case RED:
               this.inner = new ResultWindowRed();
               break;
            case GREEN:
               this.inner = new ResultWindowGreen();
               break;
            case BLUE:
               this.inner = new ResultWindowBlue();
         }
         this.inner.width = TableConst.LAST_COLUMN_EXTRA_WIDTH + 2 * TableConst.TABLE_MARGIN + TableConst.LABELS_OFFSET + TableConst.CALLSIGN_WIDTH + TableConst.KILLS_WIDTH + TableConst.DEATHS_WIDTH + TableConst.RATIO_WIDTH + (this.type != GREEN ? TableConst.SCORE_WIDTH : 0) + (this.finish ? TableConst.REWARD_WIDTH : 0) + (this.showStars ? TableConst.BONUS_REWARD_WIDTH : 0) + EXTRA_WIDTH;
         this.inner.height = MIN_HEIGHT;
         addChild(this.inner);
         this.header = this.getHeader();
         this.inner.addChild(this.header);
         this.header.x = TABLE_MARGIN;
         this.header.y = TABLE_MARGIN;
         this.dp = new DataProvider();
         this.list = new List();
         this.setScrollbarStyle();
         this.inner.addChild(this.list);
         this.list.rowHeight = TableConst.ROW_HEIGHT;
         this.list.x = TABLE_MARGIN;
         StatisticsListRenderer.showBonus = this.showStars;
         this.list.setStyle("cellRenderer",StatisticsListRenderer);
         this.list.y = this.header.y + this.header.height;
         this.list.focusEnabled = false;
         this.list.dataProvider = this.dp;
      }
      
      private function getHeader() : Sprite
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:uint = 0;
         var _loc5_:Label = null;
         switch(this.type)
         {
            case BLUE:
               _loc1_ = new ResultWindowBlueHeader();
               _loc2_ = 11590;
               break;
            case GREEN:
               _loc1_ = new ResultWindowGreenHeader();
               _loc2_ = 83457;
               break;
            case RED:
               _loc1_ = new ResultWindowRedHeader();
               _loc2_ = 4655104;
         }
         var _loc3_:Sprite = new Sprite();
         _loc3_.addChild(_loc1_);
         var _loc4_:int = TableConst.LABELS_OFFSET;
         _loc5_ = createHeaderLabel(_loc3_,this.captionCallsign,_loc2_,TextFormatAlign.LEFT,TableConst.CALLSIGN_WIDTH,_loc4_);
         _loc4_ += _loc5_.width;
         if(this.type != GREEN)
         {
            _loc5_ = createHeaderLabel(_loc3_,this.captionScore,_loc2_,TextFormatAlign.RIGHT,TableConst.SCORE_WIDTH,_loc4_);
            _loc4_ += _loc5_.width;
         }
         _loc5_ = createHeaderLabel(_loc3_,this.captionKills,_loc2_,TextFormatAlign.RIGHT,TableConst.KILLS_WIDTH,_loc4_);
         _loc4_ += _loc5_.width;
         _loc5_ = createHeaderLabel(_loc3_,this.captionDeaths,_loc2_,TextFormatAlign.RIGHT,TableConst.DEATHS_WIDTH,_loc4_);
         _loc4_ += _loc5_.width;
         _loc5_ = createHeaderLabel(_loc3_,this.captionKDRatio,_loc2_,TextFormatAlign.RIGHT,TableConst.RATIO_WIDTH,_loc4_);
         _loc4_ += _loc5_.width;
         if(this.finish)
         {
            _loc5_ = createHeaderLabel(_loc3_,this.captionReward,_loc2_,TextFormatAlign.RIGHT,TableConst.REWARD_WIDTH,_loc4_);
            _loc4_ += _loc5_.width;
            if(this.showStars)
            {
               createHeaderLabel(_loc3_,this.captionStarsReward,_loc2_,TextFormatAlign.RIGHT,TableConst.BONUS_REWARD_WIDTH,_loc4_);
            }
         }
         _loc1_.width = width - 2 * TABLE_MARGIN;
         _loc1_.height = TableConst.ROW_HEIGHT - 2;
         return _loc3_;
      }
   }
}

