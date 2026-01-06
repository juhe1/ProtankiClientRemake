package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf
{
   import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator.FlagIndicator;
   import controls.Label;
   import controls.resultassets.WhiteFrame;
   import flash.display.Bitmap;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class ComplexTeamScoreIndicator extends Sprite
   {
      
      private static const FONT_COLOR_RED:uint = 16742221;
      
      private static const FONT_COLOR_BLUE:uint = 4760319;
      
      private static const BG_COLOR_RED:uint = 9249024;
      
      private static const BG_COLOR_BLUE:uint = 16256;
      
      private static const ICON_WIDTH:int = 30;
      
      private static const LABEL_Y:int = 6;
      
      private var border:WhiteFrame;
      
      private var blueIndicator:FlagIndicator;
      
      private var redIndicator:FlagIndicator;
      
      private var labelRed:Label;
      
      private var labelBlue:Label;
      
      private var time:int;
      
      private var redInterpolator:ColorInterpolator = new ColorInterpolator(FONT_COLOR_RED,16777215);
      
      private var blueInterpolator:ColorInterpolator = new ColorInterpolator(FONT_COLOR_BLUE,16777215);
      
      private var blinker:CTFScoreIndicatorBlinker = new CTFScoreIndicatorBlinker(0,1,Vector.<int>([200,600]),Vector.<Number>([10,1.1]));
      
      private var flashingScore:Boolean;
      
      public function ComplexTeamScoreIndicator(param1:Bitmap, param2:Bitmap, param3:Bitmap, param4:Bitmap, param5:Bitmap, param6:Bitmap, param7:Boolean = true)
      {
         super();
         this.flashingScore = param7;
         this.border = new WhiteFrame();
         addChild(this.border);
         this.labelRed = this.createLabel(FONT_COLOR_RED);
         this.labelBlue = this.createLabel(FONT_COLOR_BLUE);
         this.blueIndicator = new FlagIndicator(param1,param2,param3,this.blinker);
         this.blueIndicator.y = 5;
         addChild(this.blueIndicator);
         this.redIndicator = new FlagIndicator(param4,param5,param6,this.blinker);
         this.redIndicator.y = 5;
         addChild(this.redIndicator);
         this.update();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private static function updateScoreColor(param1:Label, param2:ColorInterpolator, param3:Bitmap) : void
      {
         var _loc4_:uint = 0;
         if(param3.visible)
         {
            _loc4_ = param2.interpolate(param3.alpha);
         }
         else
         {
            _loc4_ = param2.startColor;
         }
         if(_loc4_ != param1.textColor)
         {
            param1.textColor = _loc4_;
         }
      }
      
      public function setScore(param1:int, param2:int) : void
      {
         this.labelRed.text = param1.toString();
         this.labelBlue.text = param2.toString();
         this.redIndicator.setState(FlagIndicator.STATE_DEFAULT);
         this.blueIndicator.setState(FlagIndicator.STATE_DEFAULT);
         this.update();
      }
      
      public function set redScore(param1:int) : void
      {
         if(int(this.labelRed.text) == param1)
         {
            return;
         }
         this.labelRed.text = param1.toString();
         if(this.flashingScore)
         {
            this.blueIndicator.setState(FlagIndicator.STATE_FLASHING);
         }
         this.update();
      }
      
      public function set blueScore(param1:int) : void
      {
         if(int(this.labelBlue.text) == param1)
         {
            return;
         }
         this.labelBlue.text = param1.toString();
         if(this.flashingScore)
         {
            this.redIndicator.setState(FlagIndicator.STATE_FLASHING);
         }
         this.update();
      }
      
      public function setBothIndicatorsState(param1:int, param2:int) : void
      {
         this.redIndicator.setState(param1);
         this.blueIndicator.setState(param2);
      }
      
      public function setIndicatorState(param1:BattleTeam, param2:int) : void
      {
         var _loc3_:FlagIndicator = this.getFlagInficator(param1);
         _loc3_.setState(param2);
      }
      
      public function setTeamScore(param1:BattleTeam, param2:int) : void
      {
         switch(param1)
         {
            case BattleTeam.BLUE:
               this.blueScore = param2;
               break;
            case BattleTeam.RED:
               this.redScore = param2;
         }
      }
      
      private function update() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 5;
         var _loc2_:int = this.labelRed.width > this.labelBlue.width ? int(this.labelRed.width) : int(this.labelBlue.width);
         this.redIndicator.x = _loc1_ + _loc1_;
         _loc3_ = this.redIndicator.x + ICON_WIDTH + _loc1_;
         this.labelRed.x = _loc3_ + (_loc2_ - this.labelRed.width >> 1);
         _loc3_ += _loc2_ + _loc1_ + _loc1_;
         this.labelBlue.x = _loc3_ + (_loc2_ - this.labelBlue.width >> 1);
         _loc3_ += _loc2_ + _loc1_;
         this.blueIndicator.x = _loc3_;
         _loc3_ += ICON_WIDTH + _loc1_ + _loc1_;
         this.updateBgAndBorder(_loc3_);
      }
      
      private function updateBgAndBorder(param1:int) : void
      {
         this.border.width = param1;
         var _loc2_:String = GradientType.LINEAR;
         var _loc3_:Array = [BG_COLOR_RED,BG_COLOR_BLUE];
         var _loc4_:Array = [1,1];
         var _loc5_:int = 8 / param1 * 255;
         var _loc6_:Array = [127 - _loc5_,127 + _loc5_];
         var _loc7_:int = 2;
         var _loc8_:Matrix = new Matrix();
         _loc8_.createGradientBox(param1 - 2 * _loc7_,this.border.height - 2 * _loc7_,0,0,0);
         var _loc9_:String = SpreadMethod.PAD;
         var _loc10_:Graphics = graphics;
         _loc10_.clear();
         _loc10_.beginGradientFill(_loc2_,_loc3_,_loc4_,_loc6_,_loc8_,_loc9_);
         _loc10_.drawRect(_loc7_,_loc7_,param1 - 2 * _loc7_,this.border.height - 2 * _loc7_);
         _loc10_.endFill();
      }
      
      private function createLabel(param1:uint) : Label
      {
         var _loc2_:Label = new Label();
         _loc2_.color = param1;
         _loc2_.size = 18;
         _loc2_.bold = true;
         _loc2_.autoSize = TextFieldAutoSize.CENTER;
         _loc2_.y = LABEL_Y;
         _loc2_.text = "0";
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.update();
         this.time = getTimer();
         stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this.time;
         this.time = _loc2_;
         this.blinker.update(_loc2_,_loc3_);
         this.redIndicator.update(_loc2_,_loc3_);
         this.blueIndicator.update(_loc2_,_loc3_);
         updateScoreColor(this.labelRed,this.redInterpolator,this.blueIndicator.flashBitmap);
         updateScoreColor(this.labelBlue,this.blueInterpolator,this.redIndicator.flashBitmap);
      }
      
      private function getFlagInficator(param1:BattleTeam) : FlagIndicator
      {
         switch(param1)
         {
            case BattleTeam.BLUE:
               return this.blueIndicator;
            case BattleTeam.RED:
               return this.redIndicator;
            default:
               throw new ArgumentError("Unsupported team type");
         }
      }
   }
}

