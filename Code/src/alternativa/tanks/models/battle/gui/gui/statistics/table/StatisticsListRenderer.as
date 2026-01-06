package alternativa.tanks.models.battle.gui.gui.statistics.table
{
   import alternativa.tanks.models.battle.gui.userlabel.StatisticsListUserLabel;
   import controls.Label;
   import controls.Money;
   import controls.resultassets.ResultWindowBlueNormal;
   import controls.resultassets.ResultWindowBlueSelected;
   import controls.resultassets.ResultWindowGreenNormal;
   import controls.resultassets.ResultWindowGreenSelected;
   import controls.resultassets.ResultWindowRedNormal;
   import controls.resultassets.ResultWindowRedSelected;
   import fl.controls.listClasses.CellRenderer;
   import fl.controls.listClasses.ListData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import forms.ColorConstants;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   
   public class StatisticsListRenderer extends CellRenderer
   {
      
      [Inject]
      public static var battleInfoService:IBattleInfoService;
      
      public static var showBonus:Boolean;
      
      private static const COLOR_NORMAL:uint = 16777215;
      
      private static const COLOR_NOT_LOADED:uint = 11184810;
      
      private static const COLOR_GOLD:uint = 15976448;
      
      private static const COLOR_GREY:uint = 10921638;
      
      private static const DASH_TEXT:String = "—";
      
      private var nicon:DisplayObject;
      
      public function StatisticsListRenderer()
      {
         super();
         this.mouseChildren = true;
         this.buttonMode = this.useHandCursor = false;
      }
      
      private static function createCell(param1:DisplayObjectContainer, param2:String, param3:uint, param4:String, param5:int, param6:int) : Label
      {
         var _loc7_:Label = new Label();
         _loc7_.mouseEnabled = false;
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
      
      private static function createStarsRewardCell(param1:DisplayObjectContainer, param2:int, param3:uint, param4:int) : void
      {
         var _loc5_:String = Money.numToString(param4,false);
         createCell(param1,_loc5_,param3,TextFormatAlign.RIGHT,TableConst.BONUS_REWARD_WIDTH,param2);
      }
      
      [Obfuscation(rename="false")]
      override public function set data(param1:Object) : void
      {
         _data = param1;
         this.nicon = this.myIcon(_data);
      }
      
      [Obfuscation(rename="false")]
      override public function set listData(param1:ListData) : void
      {
         _listData = param1;
         label = _listData.label;
         if(this.nicon != null)
         {
            setStyle("icon",this.nicon);
         }
      }
      
      [Obfuscation(rename="false")]
      override protected function drawBackground() : void
      {
      }
      
      [Obfuscation(rename="false")]
      override protected function drawLayout() : void
      {
      }
      
      [Obfuscation(rename="false")]
      override protected function drawIcon() : void
      {
         var _loc1_:DisplayObject = icon;
         var _loc2_:Object = getStyleValue("icon");
         if(_loc2_ != null)
         {
            icon = getDisplayObjectInstance(_loc2_);
         }
         if(icon != null)
         {
            addChildAt(icon,1);
         }
         if(_loc1_ != null && _loc1_ != icon && _loc1_.parent == this)
         {
            removeChild(_loc1_);
         }
      }
      
      private function myIcon(param1:Object) : Sprite
      {
         var _loc3_:DisplayObject = null;
         var _loc5_:uint = 0;
         var _loc6_:StatisticsListUserLabel = null;
         var _loc8_:Label = null;
         var _loc2_:StatisticsData = StatisticsData(param1);
         switch(_loc2_.type)
         {
            case ViewStatistics.BLUE:
               _loc3_ = _loc2_.self ? new ResultWindowBlueSelected() : new ResultWindowBlueNormal();
               break;
            case ViewStatistics.GREEN:
               _loc3_ = _loc2_.self ? new ResultWindowGreenSelected() : new ResultWindowGreenNormal();
               break;
            case ViewStatistics.RED:
               _loc3_ = _loc2_.self ? new ResultWindowRedSelected() : new ResultWindowRedNormal();
         }
         var _loc4_:Sprite = new Sprite();
         _loc4_.addChild(_loc3_);
         if(!param1.loaded)
         {
            _loc5_ = COLOR_NOT_LOADED;
         }
         else
         {
            _loc5_ = Boolean(param1.suspicious) ? uint(ColorConstants.SUSPICIOUS) : COLOR_NORMAL;
         }
         _loc6_ = new StatisticsListUserLabel(_loc2_);
         if(!param1.loaded)
         {
            _loc6_.setUidColor(COLOR_NOT_LOADED,true);
         }
         else if(Boolean(param1.suspicious))
         {
            _loc6_.setUidColor(ColorConstants.SUSPICIOUS,true);
         }
         else
         {
            _loc6_.setUidColor(COLOR_NORMAL,battleInfoService.isSpectatorMode());
         }
         var _loc7_:int = TableConst.LABELS_OFFSET;
         _loc6_.x = _loc7_ - 14;
         _loc4_.addChild(_loc6_);
         _loc7_ += TableConst.CALLSIGN_WIDTH;
         if(_loc2_.type != ViewStatistics.GREEN)
         {
            _loc8_ = createCell(_loc4_,_loc2_.score.toString(),_loc5_,TextFormatAlign.RIGHT,TableConst.SCORE_WIDTH,_loc7_);
            _loc7_ += _loc8_.width;
         }
         _loc8_ = createCell(_loc4_,_loc2_.kills.toString(),_loc5_,TextFormatAlign.RIGHT,TableConst.KILLS_WIDTH,_loc7_);
         _loc7_ += _loc8_.width;
         _loc8_ = createCell(_loc4_,_loc2_.deaths.toString(),_loc5_,TextFormatAlign.RIGHT,TableConst.DEATHS_WIDTH,_loc7_);
         _loc7_ += _loc8_.width;
         var _loc9_:Number = _loc2_.kills / _loc2_.deaths;
         var _loc10_:String = _loc2_.deaths == 0 || _loc2_.kills == 0 ? DASH_TEXT : _loc9_.toFixed(2);
         _loc8_ = createCell(_loc4_,_loc10_,_loc5_,TextFormatAlign.RIGHT,TableConst.RATIO_WIDTH,_loc7_);
         _loc7_ += _loc8_.width;
         if(_loc2_.reward > -1)
         {
            _loc8_ = createCell(_loc4_,Money.numToString(_loc2_.reward,false),_loc5_,TextFormatAlign.RIGHT,TableConst.REWARD_WIDTH,_loc7_);
            _loc7_ += _loc8_.width;
            if(showBonus)
            {
               createStarsRewardCell(_loc4_,_loc7_,COLOR_GOLD,_loc2_.stars);
            }
         }
         _loc3_.width = width;
         _loc3_.height = TableConst.ROW_HEIGHT - 2;
         return _loc4_;
      }
   }
}

