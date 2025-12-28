package controls.dropdownlist
{
   import alternativa.osgi.service.display.IDisplay;
   import base.DiscreteSprite;
   import controls.ComboButton;
   import controls.base.LabelBase;
   import fl.controls.List;
   import fl.data.DataProvider;
   import fl.events.ListEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
   import utils.ScrollStyleUtils;
   
   public class DropDownList extends DiscreteSprite
   {
      
      [Inject] // added
      public static var display:IDisplay;
      
      protected var button:ComboButton = new ComboButton();
      
      protected var _listBg:DPLBackground;
      
      protected var list:List = new List();
      
      protected var dp:DataProvider = new DataProvider();
      
      private var _label:LabelBase;
      
      private var hiddenInput:TextField;
      
      protected var _selectedItem:Object;
      
      protected var _selectedIndex:int = 0;
      
      private var _width:int;
      
      private var _listWidthExtension:int;
      
      private var _height:int = 151;
      
      protected var _value:Object;
      
      private var _isOpen:Boolean;
      
      private var _isOver:Boolean;
      
      private var viewName:String;
      
      public function DropDownList(param1:String = "gameName")
      {
         super();
         this.viewName = param1;
         this.init();
      }
      
      protected function init() : void
      {
         this.hiddenInput = new TextField();
         this.hiddenInput.visible = false;
         this.hiddenInput.type = TextFieldType.INPUT;
         this._label = new LabelBase();
         this._label.x = -10;
         this._label.y = 7;
         addChild(this.listBg);
         addChild(this.list);
         addChild(this.button);
         addChild(this._label);
         this.listBg.y = 5;
         this.list.y = 33;
         this.list.x = 3;
         this.list.setSize(144,241);
         this.list.rowHeight = 20;
         this.list.dataProvider = this.dp;
         this.setRenderer(ComboR);
         ScrollStyleUtils.setGrayStyle(this.list);
         this.list.focusEnabled = false;
         this.list.visible = false;
         this.listBg.visible = false;
         this.button._label.x;
         this.button.addEventListener(MouseEvent.CLICK,this.onButtonClick);
      }
      
      public function setRenderer(param1:Class) : void
      {
         this.list.setStyle("cellRenderer",param1);
      }
      
      protected function onButtonClick(param1:MouseEvent) : void
      {
         if(this.isOpen)
         {
            this.close();
         }
         else
         {
            this.open();
         }
      }
      
      protected function open() : void
      {
         if(!this.isOpen)
         {
            this.setEvent();
            this.listBg.visible = this.list.visible = true;
            display.stage.focus = this.hiddenInput;
            display.stage.addChild(this.hiddenInput);
            this._isOpen = true;
            this._isOver = true;
            dispatchEvent(new Event(Event.OPEN));
         }
      }
      
      public function get isOpen() : Boolean
      {
         return this._isOpen;
      }
      
      private function setEvent() : void
      {
         this.list.addEventListener(ListEvent.ITEM_CLICK,this.onItemClick);
         this.hiddenInput.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHiddenInput);
         display.stage.addEventListener(MouseEvent.CLICK,this.onClickStage);
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function onClickStage(param1:MouseEvent) : void
      {
         if(!this._isOver)
         {
            this.close();
         }
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         this._isOver = true;
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         this._isOver = false;
      }
      
      protected function close() : void
      {
         if(this.isOpen)
         {
            this.removeEvents();
            this.listBg.visible = this.list.visible = false;
            removeDisplayObject(this.hiddenInput);
            this.clearFocus();
            this._isOpen = false;
         }
      }
      
      private function removeEvents() : void
      {
         this.hiddenInput.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHiddenInput);
         this.list.removeEventListener(ListEvent.ITEM_CLICK,this.onItemClick);
         display.stage.removeEventListener(MouseEvent.CLICK,this.onClickStage);
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function clearFocus() : void
      {
         if(display.stage.focus == this.hiddenInput)
         {
            display.stage.focus = null;
         }
      }
      
      public function get selectedItem() : Object
      {
         return this._selectedItem;
      }
      
      public function set selectedItem(param1:Object) : void
      {
         if(param1 == null)
         {
            this._selectedItem = null;
            this.button.label = "";
         }
         else
         {
            this._selectedIndex = this.dp.getItemIndex(param1);
            this._selectedItem = this.dp.getItemAt(this._selectedIndex);
            this.button.label = param1[this.viewName];
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set label(param1:String) : void
      {
         this._label.text = param1;
         this._label.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      public function getLabelWidth() : int
      {
         return this._label.width;
      }
      
      protected function onItemClick(param1:ListEvent) : void
      {
         var _loc2_:Object = param1.item;
         this._selectedIndex = param1.index;
         if(_loc2_.rang == 0)
         {
            this.button.label = _loc2_[this.viewName];
            this._selectedItem = _loc2_;
         }
         this.close();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function addItem(param1:Object) : void
      {
         var _loc2_:Object = null;
         this.dp.addItem(param1);
         _loc2_ = this.dp.getItemAt(0);
         this._selectedItem = _loc2_;
         this.button.label = _loc2_[this.viewName];
      }
      
      public function replaceItemAt(param1:Object, param2:int) : void
      {
         this.dp.replaceItemAt(param1,param2);
      }
      
      public function sortOn(param1:Object, param2:Object = null) : void
      {
         var _loc3_:Object = null;
         this.dp.sortOn(param1,param2);
         if(this.dp.length > 0)
         {
            _loc3_ = this.dp.getItemAt(0);
            this._selectedItem = _loc3_;
            this._value = this._selectedItem[this.viewName];
            this.button.label = _loc3_[this.viewName];
         }
      }
      
      public function clear() : void
      {
         this.dp = new DataProvider();
         this.list.dataProvider = this.dp;
         this.button.label = "";
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
         this.draw();
      }
      
      public function set listWidthExtension(param1:Number) : void
      {
         this._listWidthExtension = param1;
         this.draw();
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = param1;
         this.draw();
      }
      
      protected function draw() : void
      {
         this.listBg.width = this._width + this._listWidthExtension;
         this.listBg.height = this._height - 2;
         this.button.width = this._width;
         this.list.setSize(this._width + this._listWidthExtension,this._height - 34);
         this.list.invalidate();
      }
      
      public function set value(param1:Object) : void
      {
         var _loc2_:Object = null;
         this._value = "";
         this.button.label = this._value.toString();
         this._selectedItem = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.dp.length)
         {
            _loc2_ = this.dp.getItemAt(_loc3_);
            if(_loc2_[this.viewName] == param1)
            {
               this._selectedItem = _loc2_;
               this._value = this._selectedItem[this.viewName];
               this.button.label = this._value.toString();
               this.list.selectedIndex = _loc3_;
               this.list.scrollToSelected();
            }
            _loc3_++;
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function selectItemByField(param1:String, param2:Object) : void
      {
         var _loc3_:int = this.findItemIndexByField(param1,param2);
         if(_loc3_ != -1)
         {
            this._selectedItem = this.dp.getItemAt(_loc3_);
            this._value = this._selectedItem[this.viewName];
            this.button.label = this._value.toString();
            this.list.selectedIndex = _loc3_;
            this.list.scrollToSelected();
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function selectItemAt(param1:int) : void
      {
         if(param1 >= this.dp.length)
         {
            return;
         }
         this._selectedItem = this.dp.getItemAt(param1);
         this._value = this._selectedItem[this.viewName];
         this.button.label = this._value.toString();
         this.list.selectedIndex = param1;
         this.list.scrollToSelected();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function findItemIndexByField(param1:String, param2:Object) : int
      {
         var _loc4_:Object = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.dp.length)
         {
            _loc4_ = this.dp.getItemAt(_loc3_);
            if(_loc4_[param1] == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function get value() : Object
      {
         return this._value;
      }
      
      private function onKeyUpHiddenInput(param1:KeyboardEvent) : void
      {
         if(AlertUtils.isCancelKey(param1.keyCode))
         {
            this.close();
         }
         else
         {
            this.getItemByFirstChar(this.hiddenInput.text.substr(0,1));
            this.hiddenInput.text = "";
         }
      }
      
      public function getItemByFirstChar(param1:String) : Object
      {
         var _loc4_:Object = null;
         var _loc2_:uint = this.dp.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.dp.getItemAt(_loc3_);
            if(_loc4_[this.viewName].substr(0,1).toLowerCase() == param1.toLowerCase())
            {
               this._selectedItem = _loc4_;
               this._value = this._selectedItem[this.viewName];
               this.button.label = this._value.toString();
               this.list.selectedIndex = _loc3_;
               this.list.verticalScrollPosition = _loc3_ * 20;
               dispatchEvent(new Event(Event.CHANGE));
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      protected function get listBg() : DPLBackground
      {
         if(!this._listBg)
         {
            this._listBg = new DPLBackground(100,275);
         }
         return this._listBg;
      }
      
      public function get rowHeight() : Number
      {
         return this.list.rowHeight;
      }
      
      protected function getList() : List
      {
         return this.list;
      }
   }
}

