package alternativa.tanks.models.battle.gui.inventory.cooldown
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import utils.graphics.SectorMask;
   
   public class CooldownIndicator extends Sprite
   {
      
      private var _sectorMask:SectorMask;
      
      public function CooldownIndicator(param1:BitmapData)
      {
         super();
         var _loc2_:Bitmap = new Bitmap(param1);
         addChild(_loc2_);
         this._sectorMask = new SectorMask(_loc2_.width);
         addChild(this._sectorMask);
         mask = this._sectorMask;
      }
      
      public function setProgress(param1:Number, param2:Number) : void
      {
         this._sectorMask.setProgress(param1,param2);
      }
   }
}

