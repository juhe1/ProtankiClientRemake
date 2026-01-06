package alternativa.tanks.models.controlpoints.hud.panel
{
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.LayoutManager;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.Widget;
   import alternativa.tanks.models.controlpoints.hud.*;
   import controls.Label;
   import controls.resultassets.WhiteFrame;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class KeyPointsHUDPanel extends Sprite implements Renderer, Widget
   {
      
      private static const SPACING:int = 1;
      
      private var shape:Shape = new Shape();
      
      private var indicators:Vector.<KeyPointHUDIndicator>;
      
      private var _width:int;
      
      private var _height:int;
      
      public function KeyPointsHUDPanel(param1:Vector.<KeyPoint>)
      {
         super();
         this.createIndicators(param1);
         this.createBorder(param1.length);
         addChild(this.shape);
         this.bringLabelsToFront();
      }
      
      public function removeFromParent() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      private function bringLabelsToFront() : void
      {
         var _loc1_:KeyPointHUDIndicator = null;
         for each(_loc1_ in this.indicators)
         {
            addChild(_loc1_.getLabel());
         }
      }
      
      public function setLayoutManager(param1:LayoutManager) : void
      {
      }
      
      public function render(param1:int, param2:int) : void
      {
         this.update();
      }
      
      public function update() : void
      {
         var _loc1_:KeyPointHUDIndicator = null;
         for each(_loc1_ in this.indicators)
         {
            _loc1_.update();
         }
      }
      
      private function createIndicators(param1:Vector.<KeyPoint>) : void
      {
         var _loc5_:KeyPoint = null;
         var _loc6_:KeyPointHUDIndicator = null;
         var _loc7_:Label = null;
         var _loc2_:Vector.<KeyPoint> = this.sortPoints(param1);
         var _loc3_:int = 2;
         this.indicators = new Vector.<KeyPointHUDIndicator>(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_];
            _loc6_ = new KeyPointHUDIndicator(_loc5_);
            _loc6_.x = _loc3_;
            _loc6_.y = 2;
            addChild(_loc6_);
            _loc7_ = _loc6_.getLabel();
            _loc7_.y = 8;
            _loc7_.x = int(_loc6_.x + (_loc6_.width - _loc7_.width) / 2);
            if(_loc4_ < _loc2_.length - 1)
            {
               this.shape.graphics.lineStyle(0,16777215);
               this.shape.graphics.moveTo(_loc6_.x + 36,2);
               this.shape.graphics.lineTo(_loc6_.x + 36,38);
            }
            this.indicators[_loc4_] = _loc6_;
            _loc3_ += _loc6_.width + SPACING;
            _loc4_++;
         }
      }
      
      private function sortPoints(param1:Vector.<KeyPoint>) : Vector.<KeyPoint>
      {
         var points:Vector.<KeyPoint> = param1;
         return points.concat().sort(function(param1:KeyPoint, param2:KeyPoint):Number
         {
            if(param1.getName() < param2.getName())
            {
               return -1;
            }
            if(param1.getName() > param2.getName())
            {
               return 1;
            }
            return 0;
         });
      }
      
      private function createBorder(param1:int) : void
      {
         var _loc2_:WhiteFrame = new WhiteFrame();
         _loc2_.width = param1 * (36 + SPACING) - SPACING + 4;
         addChild(_loc2_);
         this._width = _loc2_.width;
         this._height = _loc2_.height;
      }
      
      [Obfuscation(rename="false")]
      override public function get width() : Number
      {
         return this._width;
      }
      
      [Obfuscation(rename="false")]
      override public function get height() : Number
      {
         return this._height;
      }
   }
}

