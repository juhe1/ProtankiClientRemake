package alternativa.tanks.models.battle.gui.gui.statistics.field.score
{
   import controls.Label;
   import controls.resultassets.WhiteFrame;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.text.TextFieldAutoSize;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class TeamScoreFieldBase extends Sprite
   {
      
      private static const LABEL_Y:int = 6;
      
      protected static const BG_COLOR_RED:uint = 9249024;
      
      protected static const FONT_COLOR_RED:uint = 16742221;
      
      protected static const BG_COLOR_BLUE:uint = 16256;
      
      protected static const FONT_COLOR_BLUE:uint = 4760319;
      
      protected var _scoreRed:int;
      
      protected var _scoreBlue:int;
      
      protected var labelRed:Label;
      
      protected var labelBlue:Label;
      
      private var background:Shape;
      
      protected var border:WhiteFrame;
      
      public function TeamScoreFieldBase()
      {
         super();
         addChild(this.background = new Shape());
         addChild(this.border = new WhiteFrame());
         this.labelRed = this.createLabel(FONT_COLOR_RED);
         this.labelBlue = this.createLabel(FONT_COLOR_BLUE);
      }
      
      public function setScore(param1:int, param2:int) : void
      {
         this._scoreRed = param1;
         this.labelRed.text = param1.toString();
         this._scoreBlue = param2;
         this.labelBlue.text = param2.toString();
         this.update();
      }
      
      public function setTeamScore(param1:BattleTeam, param2:int) : void
      {
         switch(param1)
         {
            case BattleTeam.RED:
               this.scoreRed = param2;
               break;
            case BattleTeam.BLUE:
               this.scoreBlue = param2;
         }
         this.update();
      }
      
      public function set scoreRed(param1:int) : void
      {
         this._scoreRed = param1;
         this.labelRed.text = param1.toString();
         this.update();
      }
      
      public function set scoreBlue(param1:int) : void
      {
         this._scoreBlue = param1;
         this.labelBlue.text = param1.toString();
         this.update();
      }
      
      public function update() : void
      {
         this.updateBgAndBorder(this.calculateWidth());
      }
      
      protected function calculateWidth() : int
      {
         return 0;
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
         _loc8_.createGradientBox(param1 - _loc7_,this.border.height - _loc7_,0,0,0);
         var _loc9_:String = SpreadMethod.PAD;
         var _loc10_:Graphics = this.background.graphics;
         _loc10_.clear();
         _loc10_.beginGradientFill(_loc2_,_loc3_,_loc4_,_loc6_,_loc8_,_loc9_);
         _loc10_.drawRect(_loc7_,_loc7_,param1 - 2 * _loc7_,this.border.height - _loc7_ - 1);
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
         addChild(_loc2_);
         return _loc2_;
      }
   }
}

