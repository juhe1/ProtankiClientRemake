package alternativa.tanks.gui
{
   import alternativa.tanks.model.garage.resistance.ResistancesIcons;
   import controls.base.LabelBase;
   import controls.labels.MouseDisabledLabel;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.text.TextFormatAlign;
   
   public class ItemPropertyIcon extends Sprite
   {
      
      public var bmp:Bitmap;
      
      private var label:LabelBase;
      
      public function ItemPropertyIcon(param1:BitmapData, param2:BitmapData = null)
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         super();
         if(param2 == null)
         {
            param2 = ItemInfoPanelBitmaps.backIcon;
         }
         if(param2 == ItemInfoPanelBitmaps.backIcon)
         {
            _loc3_ = _loc4_ = 1;
         }
         else
         {
            _loc3_ = _loc4_ = -4;
         }
         var _loc5_:BitmapData = new BitmapData(param2.width,param2.height,true,0);
         _loc5_.draw(param2);
         _loc5_.draw(param1,new Matrix(1,0,0,1,_loc3_,_loc4_));
         this.bmp = new Bitmap(_loc5_);
         addChild(this.bmp);
         if(param2 == ResistancesIcons.resistanceIcon)
         {
            this.bmp.x = 2;
         }
         this.label = new MouseDisabledLabel();
         this.label.size = 10;
         addChild(this.label);
         this.label.color = 59156;
         this.label.align = TextFormatAlign.CENTER;
         this.label.sharpness = -100;
         this.label.thickness = 100;
         this.posLabel();
         this.label.y = this.bmp.height + 2;
      }
      
      public function setValue(param1:String, param2:uint) : void
      {
         this.label.text = param1;
         this.label.color = param2;
         this.posLabel();
      }
      
      public function getLabel() : LabelBase
      {
         return this.label;
      }
      
      private function posLabel() : void
      {
         if(this.bmp.width > this.label.textWidth)
         {
            this.label.x = Math.round((this.bmp.width - this.label.textWidth) * 0.5) - 3;
         }
         else
         {
            this.label.x = -Math.round((this.label.textWidth - this.bmp.width) * 0.5) - 3;
         }
      }
      
      public function removeValue() : void
      {
         this.label.text = "";
      }
   }
}

