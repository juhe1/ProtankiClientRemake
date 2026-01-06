package alternativa.tanks.models.battle.gui.gui.statistics.field.score
{
   import controls.Label;
   import controls.resultassets.WhiteFrame;
   import flash.display.Bitmap;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.text.TextFieldAutoSize;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class SimpleTeamScoreIndicator extends Sprite implements TeamScoreIndicator
   {
      
      private static const FONT_COLOR_RED:uint = 16742221;
      
      private static const FONT_COLOR_BLUE:uint = 4760319;
      
      private static const BG_COLOR_RED:uint = 9249024;
      
      private static const BG_COLOR_BLUE:uint = 16256;
      
      private static const ICON_WIDTH:int = 30;
      
      private static const LABEL_Y:int = 6;
      
      private var border:WhiteFrame;
      
      private var redScoreIcon:Bitmap;
      
      private var blueScoreIcon:Bitmap;
      
      private var labelRed:Label;
      
      private var labelBlue:Label;
      
      public function SimpleTeamScoreIndicator()
      {
         super();
         this.border = new WhiteFrame();
         addChild(this.border);
         this.labelRed = this.createLabel(FONT_COLOR_RED);
         this.labelBlue = this.createLabel(FONT_COLOR_BLUE);
         this.redScoreIcon = this.getRedScoreIcon();
         this.redScoreIcon.y = 5;
         addChild(this.redScoreIcon);
         this.blueScoreIcon = this.getBlueScoreIcon();
         this.blueScoreIcon.y = 5;
         addChild(this.blueScoreIcon);
         this.update();
      }
      
      protected function getRedScoreIcon() : Bitmap
      {
         throw new Error();
      }
      
      protected function getBlueScoreIcon() : Bitmap
      {
         throw new Error();
      }
      
      public function setScore(param1:int, param2:int) : void
      {
         this.labelRed.text = param1.toString();
         this.labelBlue.text = param2.toString();
         this.update();
      }
      
      public function set redScore(param1:int) : void
      {
         if(int(this.labelRed.text) == param1)
         {
            return;
         }
         this.labelRed.text = param1.toString();
         this.update();
      }
      
      public function set blueScore(param1:int) : void
      {
         if(int(this.labelBlue.text) == param1)
         {
            return;
         }
         this.labelBlue.text = param1.toString();
         this.update();
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
         var _loc1_:int = 5;
         var _loc2_:int = this.labelRed.width > this.labelBlue.width ? int(this.labelRed.width) : int(this.labelBlue.width);
         this.redScoreIcon.x = _loc1_ + _loc1_;
         var _loc3_:int = this.redScoreIcon.x + ICON_WIDTH;
         this.labelRed.x = _loc3_ + (_loc2_ - this.labelRed.width >> 1);
         _loc3_ += _loc2_ + _loc1_ + _loc1_;
         this.labelBlue.x = _loc3_ + (_loc2_ - this.labelBlue.width >> 1);
         _loc3_ += _loc2_ + _loc1_;
         this.blueScoreIcon.x = _loc3_;
         _loc3_ += 22 + _loc1_ + _loc1_;
         this.updateBgAndBorder(_loc3_ + _loc1_);
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
   }
}

