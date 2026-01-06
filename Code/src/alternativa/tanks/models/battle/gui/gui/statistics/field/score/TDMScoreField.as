package alternativa.tanks.models.battle.gui.gui.statistics.field.score
{
   import assets.icons.BattleInfoIcons;
   
   public class TDMScoreField extends TeamScoreFieldBase implements TeamScoreIndicator
   {
      
      private static const ICON_WIDTH:int = 17;
      
      private static const ICON_Y:int = 10;
      
      private var icon:BattleInfoIcons;
      
      public function TDMScoreField()
      {
         super();
         this.icon = new BattleInfoIcons();
         this.icon.type = BattleInfoIcons.KILL_LIMIT;
         addChild(this.icon);
         this.icon.y = ICON_Y;
      }
      
      override protected function calculateWidth() : int
      {
         var _loc1_:int = 5;
         var _loc2_:int = labelRed.width > labelBlue.width ? int(labelRed.width) : int(labelBlue.width);
         labelRed.x = _loc1_ + _loc1_ + (_loc2_ - labelRed.width >> 1);
         this.icon.x = labelRed.x + _loc2_ + _loc1_;
         labelBlue.x = this.icon.x + ICON_WIDTH + _loc1_ + (_loc2_ - labelBlue.width >> 1);
         return labelBlue.x + _loc2_ + _loc1_ + _loc1_;
      }
   }
}

