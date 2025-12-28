package alternativa.tanks.gui
{
   import base.DiscreteSprite;
   import controls.base.TankDefaultButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class TabPanel extends DiscreteSprite
   {
      
      private static const BUTTON_WIDTH:int = 100;
      
      private static const BUTTON_HEIGHT:int = 30;
      
      private static const MARGIN:int = 11;
      
      public static const LEFT:String = "LEFT";
      
      public static const RIGHT:String = "RIGHT";
      
      private var contents:Dictionary = new Dictionary();
      
      private var selected:TankDefaultButton;
      
      private var buttonPanel:DiscreteSprite = new DiscreteSprite();
      
      private var contentPanel:DiscreteSprite = new DiscreteSprite();
      
      private var countButtonLine:int;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _buttonAlign:String;
      
      public function TabPanel(param1:String = "LEFT")
      {
         super();
         this._buttonAlign = param1;
         addChild(this.buttonPanel);
         addChild(this.contentPanel);
         addEventListener(Event.ADDED_TO_STAGE,this.addResizeListener);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      }
      
      private function addResizeListener(param1:Event) : void
      {
         stage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize();
      }
      
      private function onRemoveFromStage(param1:Event) : void
      {
         stage.removeEventListener(Event.RESIZE,this.onResize);
      }
      
      public function onResize(param1:Event = null) : void
      {
         var _loc3_:TankDefaultButton = null;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         this.countButtonLine = this.width / (MARGIN + BUTTON_WIDTH);
         var _loc2_:int = 0;
         while(_loc2_ < this.buttonPanel.numChildren)
         {
            _loc3_ = TankDefaultButton(this.buttonPanel.getChildAt(_loc2_));
            _loc3_.width = BUTTON_WIDTH;
            _loc4_ = MARGIN;
            if(_loc2_ + 1 > this.countButtonLine)
            {
               _loc4_ = 2 * MARGIN + _loc3_.height;
            }
            if(this._buttonAlign == LEFT)
            {
               _loc3_.x = MARGIN + _loc2_ % this.countButtonLine * (_loc3_.width + MARGIN);
            }
            else
            {
               _loc3_.x = this.width - _loc3_.width - MARGIN - _loc2_ % this.countButtonLine * (_loc3_.width + MARGIN);
            }
            _loc3_.y = _loc4_;
            _loc2_++;
         }
         this.contentPanel.y = BUTTON_HEIGHT + 2 * MARGIN;
         if(this.selected != null)
         {
            _loc5_ = this.contents[this.selected];
            _loc5_.width = this.width;
            _loc5_.height = this.height - (BUTTON_HEIGHT + 2 * MARGIN);
         }
      }
      
      public function addTab(param1:String, param2:DiscreteSprite, param3:Class) : Object
      {
         var _loc4_:TankDefaultButton = new param3();
         _loc4_.label = param1;
         _loc4_.width = BUTTON_WIDTH;
         _loc4_.addEventListener(MouseEvent.CLICK,this.onClickTab);
         this.buttonPanel.addChild(_loc4_);
         this.contents[_loc4_] = param2;
         this.onResize();
         return _loc4_;
      }
      
      public function select(param1:int) : void
      {
         this.selectTab(TankDefaultButton(this.buttonPanel.getChildAt(param1)));
      }
      
      private function selectTab(param1:TankDefaultButton) : void
      {
         if(this.selected != null)
         {
            this.selected.enable = true;
            this.contentPanel.removeChild(this.contents[this.selected]);
         }
         param1.enable = false;
         var _loc2_:DiscreteSprite = this.contents[param1];
         this.contentPanel.addChild(_loc2_);
         this.selected = param1;
         this.onResize();
      }
      
      private function onClickTab(param1:MouseEvent) : void
      {
         var _loc2_:TankDefaultButton = TankDefaultButton(param1.currentTarget);
         this.selectTab(_loc2_);
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
         this.onResize();
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = param1;
         this.onResize();
      }
      
      public function destroy() : void
      {
         var _loc1_:DiscreteSprite = this.contents[this.selected];
         if(this.contentPanel.contains(_loc1_))
         {
            this.contentPanel.removeChild(_loc1_);
         }
         if(this.contentPanel != null && contains(this.contentPanel))
         {
            removeChild(this.contentPanel);
         }
         if(this.buttonPanel != null && contains(this.buttonPanel))
         {
            removeChild(this.buttonPanel);
         }
         _loc1_ = null;
      }
   }
}

