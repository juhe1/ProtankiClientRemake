package alternativa.tanks.models.battle.gui.inventory
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class InventoryIcons extends Sprite
   {
      
      public static const NEUTRAL_STATE:int = 0;
      
      public static const EFFECT_STATE:int = 1;
      
      public static const COOLDOWN_STATE:int = 2;
      
      private var _neutralIcon:Bitmap;
      
      private var _effectIcon:Bitmap;
      
      private var _cooldownIcon:Bitmap;
      
      public function InventoryIcons(param1:int)
      {
         super();
         this._neutralIcon = new Bitmap(HudInventoryIcon.getNeutralInventoryIcon(param1));
         addChild(this._neutralIcon);
         this._effectIcon = new Bitmap(HudInventoryIcon.getEffectInventoryIcon(param1));
         addChild(this._effectIcon);
         this._cooldownIcon = new Bitmap(HudInventoryIcon.getCooldownInventoryIcon(param1));
         addChild(this._cooldownIcon);
         this.state = NEUTRAL_STATE;
      }
      
      public function set state(param1:int) : void
      {
         this._neutralIcon.visible = param1 == NEUTRAL_STATE;
         this._effectIcon.visible = param1 == EFFECT_STATE;
         this._cooldownIcon.visible = param1 == COOLDOWN_STATE;
      }
   }
}

