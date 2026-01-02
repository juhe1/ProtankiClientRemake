package alternativa.tanks.gui.crystalbutton
{
   import alternativa.tanks.gui.icons.CrystalIcon;
   import controls.Money;
   import controls.labels.MouseDisabledLabel;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class CrystalLabel extends Sprite
   {
      
      private var crystalIcon:Bitmap;
      
      private var label:MouseDisabledLabel;
      
      private var color:uint = 16777215;
      
      private var strikeColor:uint = 11645361;
      
      private var line:Shape = new Shape();
      
      private var isStrike:Boolean = false;
      
      public function CrystalLabel(param1:int = 0)
      {
         super();
         mouseEnabled = false;
         this.label = new MouseDisabledLabel();
         this.crystalIcon = CrystalIcon.createSmallInstance();
         addChild(this.label);
         addChild(this.crystalIcon);
         this.crystalIcon.y = 4;
         this.setCost(param1);
      }
      
      public function setText(param1:String) : void
      {
         this.label.text = param1;
         this.crystalIcon.x = this.label.x + this.label.textWidth + 5;
      }
      
      public function setCost(param1:int) : void
      {
         this.label.text = Money.numToString(param1,false);
         this.crystalIcon.x = this.label.x + this.label.textWidth + 5;
         this.setStrike(false);
      }
      
      public function setColor(param1:int) : void
      {
         this.color = param1;
         if(!this.isStrike)
         {
            this.label.textColor = param1;
         }
      }
      
      public function setSharpness(param1:int) : void
      {
         this.label.sharpness = param1;
      }
      
      public function setThickness(param1:int) : void
      {
         this.label.thickness = param1;
      }
      
      public function setStrikeColor(param1:int) : void
      {
         this.strikeColor = param1;
      }
      
      public function setStrike(param1:Boolean) : void
      {
         var _loc2_:Graphics = null;
         var _loc3_:int = 0;
         this.isStrike = param1;
         if(param1)
         {
            this.label.textColor = this.strikeColor;
            _loc2_ = this.line.graphics;
            _loc2_.clear();
            _loc2_.lineStyle(1,this.strikeColor);
            _loc3_ = int(this.label.y + this.label.height * 0.5) + 1;
            _loc2_.moveTo(0,_loc3_);
            _loc2_.lineTo(0 + width + 2,_loc3_);
            if(!contains(this.line))
            {
               addChild(this.line);
            }
         }
         else
         {
            this.label.textColor = this.color;
            if(contains(this.line))
            {
               removeChild(this.line);
            }
         }
      }
   }
}

