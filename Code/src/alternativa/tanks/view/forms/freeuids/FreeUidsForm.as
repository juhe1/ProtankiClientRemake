package alternativa.tanks.view.forms.freeuids
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import controls.base.LabelBase;
   import controls.dropdownlist.DPLBackground;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class FreeUidsForm extends Sprite
   {
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      public static const DEFAULT_WIDTH:int = 200;
      
      public static const BGD_HEIGHT:int = 137;
      
      public static const LABEL_POS_X:int = 6;
      
      public static const LABEL_POS_Y:int = 3;
      
      public static const ITEM_POS_Y:int = 36;
      
      private var _background:DPLBackground;
      
      private var _label:LabelBase;
      
      private var _items:Array;
      
      private var _selectedItemIndex:int = -1;
      
      private var _width:int = 200;
      
      public function FreeUidsForm()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.visible = false;
         this._items = [];
         this._background = new DPLBackground(this._width,BGD_HEIGHT);
         addChild(this._background);
         this._label = new LabelBase();
         this._label.width = this._width;
         this._label.text = localeService.getText(TanksLocale.TEXT_FREE_UIDS_FORM_HEADER);
         this._label.x = LABEL_POS_X;
         this._label.y = LABEL_POS_Y;
         addChild(this._label);
      }
      
      public function create(param1:Vector.<String>) : void
      {
         var _loc4_:FreeUidsFormRender = null;
         this.destroy();
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new FreeUidsFormRender(this._width,_loc3_,param1[_loc3_]);
            if(_loc3_ == 0)
            {
               _loc4_.y = ITEM_POS_Y;
            }
            else
            {
               _loc4_.y = this._items[_loc3_ - 1].y + this._items[_loc3_ - 1].height;
            }
            _loc4_.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverItem);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutItem);
            _loc4_.addEventListener(MouseEvent.CLICK,this.onClickItem);
            addChild(_loc4_);
            this._items.push(_loc4_);
            _loc3_++;
         }
         this.selectedItemIndex = 0;
         this.show();
      }
      
      private function onRollOverItem(param1:MouseEvent) : void
      {
         this.selectedItemIndex = FreeUidsFormRender(param1.currentTarget).index;
      }
      
      private function onRollOutItem(param1:MouseEvent) : void
      {
         this.resetCurrentSelectedItem();
      }
      
      private function onClickItem(param1:MouseEvent) : void
      {
         var _loc2_:FreeUidsFormEvent = new FreeUidsFormEvent(FreeUidsFormEvent.CLICK_ITEM);
         _loc2_.uid = FreeUidsFormRender(param1.currentTarget).uid;
         dispatchEvent(_loc2_);
      }
      
      public function destroy() : void
      {
         var _loc3_:FreeUidsFormRender = null;
         this.hide();
         var _loc1_:int = int(this._items.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._items[_loc2_];
            _loc3_.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverItem);
            _loc3_.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutItem);
            _loc3_.removeEventListener(MouseEvent.CLICK,this.onClickItem);
            removeChild(_loc3_);
            _loc2_++;
         }
         this._selectedItemIndex = -1;
         this._items = [];
      }
      
      public function show() : void
      {
         this.visible = true;
         display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:FreeUidsFormEvent = null;
         if(param1.keyCode == Keyboard.TAB || param1.keyCode == Keyboard.ESCAPE)
         {
            dispatchEvent(new FreeUidsFormEvent(FreeUidsFormEvent.FOCUS_OUT));
         }
         if(param1.keyCode == Keyboard.DOWN)
         {
            this.setSelectedNextItem();
         }
         if(param1.keyCode == Keyboard.UP)
         {
            this.setSelectedPreviousItem();
         }
         if(param1.keyCode == Keyboard.ENTER && this.hasSelectedItem())
         {
            _loc2_ = new FreeUidsFormEvent(FreeUidsFormEvent.CLICK_ITEM);
            _loc2_.uid = this._items[this._selectedItemIndex].uid;
            dispatchEvent(_loc2_);
         }
      }
      
      private function setSelectedNextItem() : void
      {
         if(this.hasSelectedItem())
         {
            ++this.selectedItemIndex;
         }
         else
         {
            this.selectedItemIndex = 0;
         }
      }
      
      private function setSelectedPreviousItem() : void
      {
         if(this.hasSelectedItem())
         {
            --this.selectedItemIndex;
         }
         else
         {
            this.selectedItemIndex = this.getLastItemIndex();
         }
      }
      
      public function hide() : void
      {
         this.visible = false;
         display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      
      public function get selectedItemIndex() : int
      {
         return this._selectedItemIndex;
      }
      
      public function set selectedItemIndex(param1:int) : void
      {
         if(this._items.length == 0 || this._selectedItemIndex == param1)
         {
            return;
         }
         this.resetCurrentSelectedItem();
         if(param1 > this.getLastItemIndex())
         {
            this._selectedItemIndex = 0;
         }
         else
         {
            this._selectedItemIndex = param1;
         }
         if(this._selectedItemIndex < 0)
         {
            this._selectedItemIndex = this.getLastItemIndex();
         }
         this._items[this._selectedItemIndex].setSelected(true);
      }
      
      private function resetCurrentSelectedItem() : void
      {
         if(this.hasSelectedItem())
         {
            this._items[this._selectedItemIndex].setSelected(false);
            this._selectedItemIndex = -1;
         }
      }
      
      private function hasSelectedItem() : Boolean
      {
         return this._selectedItemIndex != -1;
      }
      
      private function getLastItemIndex() : int
      {
         return this._items.length - 1;
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
         this._background.width = this._width;
         this._label.width = this._width;
      }
   }
}

