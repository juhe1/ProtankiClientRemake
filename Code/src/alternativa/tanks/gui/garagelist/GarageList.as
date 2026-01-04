package alternativa.tanks.gui.garagelist
{
   import alternativa.tanks.gui.resistance.GarageResistancesIconsUtils;
   import assets.Diamond;
   import assets.icons.GarageItemBackground;
   import assets.icons.IconGarageMod;
   import assets.icons.InputCheckIcon;
   import base.DiscreteSprite;
   import controls.Money;
   import controls.base.LabelBase;
   import controls.labels.CountDownTimerLabel;
   import controls.saleicons.SaleIcons;
   import controls.timer.CountDownTimer;
   import fl.controls.LabelButton;
   import fl.controls.ScrollBar;
   import fl.controls.ScrollBarDirection;
   import fl.controls.TileList;
   import fl.data.DataProvider;
   import fl.events.ListEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   import forms.events.PartsListEvent;
   import forms.premium.PremiumItemLock;
   import forms.ranks.BigRankIcon;
   import forms.ranks.RankIcon;
   import forms.registration.CallsignIconStates;
   import platform.client.fp10.core.resource.IResourceLoadingListener;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
   import utils.ScrollStyleUtils;
   
   public class GarageList extends DiscreteSprite implements IResourceLoadingListener
   {
      
      private static const SALE_RED_LABEL:Bitmap = SaleIcons.createSaleRedLabelInstance();
      
      private static const mountedIconClass:Class = GarageList_mountedIconClass;
      
      private static const mountedIcon:BitmapData = new mountedIconClass().bitmapData;
      
      private static const MIN_POSIBLE_SPEED:Number = 70;
      
      private static const MAX_DELTA_FOR_SELECT:Number = 7;
      
      private static const ADDITIONAL_SCROLL_AREA_HEIGHT:Number = 3;
      
      private static const PREMIUM_ITEM_LOCK_X:int = 118;
      
      private static const PREMIUM_ITEM_LOCK_Y:int = 58;
      
      private var list:TileList;
      
      private var dp:DataProvider;
      
      private var _selectedItem:IGameObject = null;
      
      private var previousPositionX:Number;
      
      private var currrentPositionX:Number;
      
      private var sumDragWay:Number;
      
      private var lastItemIndex:int;
      
      private var previousTime:int;
      
      private var currentTime:int;
      
      private var scrollSpeed:Number = 0;
      
      private var _width:int;
      
      private var _height:int;
      
      public function GarageList()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.dp = new DataProvider();
         this.list = new TileList();
         this.list.dataProvider = this.dp;
         this.list.rowCount = 1;
         this.list.rowHeight = 130;
         this.list.columnWidth = 203;
         this.list.setStyle("cellRenderer",GarageListRenderer);
         this.list.direction = ScrollBarDirection.HORIZONTAL;
         this.list.focusEnabled = false;
         this.list.horizontalScrollBar.focusEnabled = false;
         addChild(this.list);
         addEventListener(Event.ADDED_TO_STAGE,this.addListeners);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removeListeners);
         ScrollStyleUtils.setGreenStyle(this.list);
      }
      
      public function get selectedItem() : IGameObject
      {
         return this._selectedItem;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = Math.ceil(param1);
         this.list.width = this._width;
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = Math.ceil(param1);
         this.list.height = this._height;
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      private function updateScrollOnEnterFrame(param1:Event) : void
      {
         var _loc4_:Sprite = null;
         var _loc5_:Sprite = null;
         var _loc2_:ScrollBar = this.list.horizontalScrollBar;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.numChildren)
         {
            _loc4_ = Sprite(_loc2_.getChildAt(_loc3_));
            if(_loc4_.hitArea != null)
            {
               _loc5_ = _loc4_.hitArea;
               _loc5_.graphics.clear();
            }
            else
            {
               _loc5_ = new Sprite();
               _loc5_.mouseEnabled = false;
               _loc4_.hitArea = _loc5_;
               this.list.addChild(_loc5_);
            }
            _loc5_.graphics.beginFill(0,0);
            if(_loc4_ is LabelButton)
            {
               _loc5_.graphics.drawRect(_loc4_.y - 14,_loc2_.y - ADDITIONAL_SCROLL_AREA_HEIGHT,_loc4_.height + 28,_loc4_.width + ADDITIONAL_SCROLL_AREA_HEIGHT);
            }
            else
            {
               _loc5_.graphics.drawRect(_loc4_.y,_loc2_.y - ADDITIONAL_SCROLL_AREA_HEIGHT,_loc4_.height,_loc4_.width + ADDITIONAL_SCROLL_AREA_HEIGHT);
            }
            _loc5_.graphics.endFill();
            _loc3_++;
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this.scrollSpeed = 0;
         var _loc2_:Rectangle = this.list.horizontalScrollBar.getBounds(stage);
         _loc2_.top -= ADDITIONAL_SCROLL_AREA_HEIGHT;
         if(!_loc2_.contains(param1.stageX,param1.stageY))
         {
            this.sumDragWay = 0;
            this.previousPositionX = this.currrentPositionX = param1.stageX;
            this.currentTime = this.previousTime = getTimer();
            this.lastItemIndex = this.list.selectedIndex;
            stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
            stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         }
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         this.previousPositionX = this.currrentPositionX;
         this.currrentPositionX = param1.stageX;
         this.previousTime = this.currentTime;
         this.currentTime = getTimer();
         var _loc2_:Number = this.currrentPositionX - this.previousPositionX;
         this.sumDragWay += Math.abs(_loc2_);
         if(this.sumDragWay > MAX_DELTA_FOR_SELECT)
         {
            this.list.horizontalScrollPosition -= _loc2_;
         }
         param1.updateAfterEvent();
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         var _loc2_:Number = (getTimer() - this.previousTime) / 1000;
         if(_loc2_ == 0)
         {
            _loc2_ = 0.1;
         }
         var _loc3_:Number = param1.stageX - this.previousPositionX;
         this.scrollSpeed = _loc3_ / _loc2_;
         this.previousTime = this.currentTime;
         this.currentTime = getTimer();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.previousTime = this.currentTime;
         this.currentTime = getTimer();
         var _loc2_:Number = (this.currentTime - this.previousTime) / 1000;
         this.list.horizontalScrollPosition -= this.scrollSpeed * _loc2_;
         var _loc3_:Number = Number(this.list.horizontalScrollPosition);
         var _loc4_:Number = Number(this.list.maxHorizontalScrollPosition);
         if(Math.abs(this.scrollSpeed) > MIN_POSIBLE_SPEED && 0 < _loc3_ && _loc3_ < _loc4_)
         {
            this.scrollSpeed *= Math.exp(-1.5 * _loc2_);
         }
         else
         {
            this.scrollSpeed = 0;
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      private function selectItemWithDoubleClick(param1:ListEvent) : void
      {
         var _loc2_:GarageListRendererData = null;
         if(this.sumDragWay < MAX_DELTA_FOR_SELECT)
         {
            _loc2_ = GarageListRendererData(param1.item);
            this.scrollSpeed = 0;
            if(this._selectedItem != _loc2_.id)
            {
               this._selectedItem = _loc2_.id;
               this.list.selectedItem = _loc2_;
               this.list.scrollToSelected();
            }
            dispatchEvent(new PartsListEvent(PartsListEvent.ITEM_DOUBLE_CLICK));
         }
         else
         {
            this.list.addEventListener(Event.CHANGE,this.onChangeItem);
         }
      }
      
      private function selectItem(param1:ListEvent) : void
      {
         var _loc2_:GarageListRendererData = null;
         if(this.sumDragWay < MAX_DELTA_FOR_SELECT)
         {
            _loc2_ = GarageListRendererData(param1.item);
            this.scrollSpeed = 0;
            if(this._selectedItem != _loc2_.id)
            {
               this._selectedItem = _loc2_.id;
               this.list.selectedItem = _loc2_;
               this.list.scrollToSelected();
               dispatchEvent(new PartsListEvent(PartsListEvent.SELECT_PARTS_LIST_ITEM));
            }
            dispatchEvent(new PartsListEvent(PartsListEvent.ITEM_CLICK));
         }
         else
         {
            this.list.addEventListener(Event.CHANGE,this.onChangeItem);
         }
      }
      
      private function onChangeItem(param1:Event) : void
      {
         this.list.selectedIndex = this.lastItemIndex;
         this.list.removeEventListener(Event.CHANGE,this.onChangeItem);
      }
      
      private function update(param1:IGameObject, param2:String, param3:* = null, param4:Boolean = true) : void
      {
         var _loc5_:int = this.indexById(param1);
         if(_loc5_ != -1)
         {
            this.updateByIndex(_loc5_,param2,param3,param4);
         }
      }
      
      private function updateByIndex(param1:int, param2:String, param3:*, param4:Boolean) : void
      {
         var _loc5_:GarageListRendererData = GarageListRendererData(this.dp.getItemAt(param1));
         _loc5_[param2] = param3;
         if(param4)
         {
            _loc5_.iconNormal = this.createIcon(_loc5_,false);
            _loc5_.iconSelected = this.createIcon(_loc5_,true);
            this.dp.replaceItemAt(_loc5_,param1);
            this.dp.invalidateItemAt(param1);
         }
      }
      
      public function mount(param1:IGameObject) : void
      {
         this.update(param1,"installed",true);
      }
      
      public function unmount(param1:IGameObject) : void
      {
         this.update(param1,"installed",false);
      }
      
      public function updateCount(param1:IGameObject, param2:int) : void
      {
         this.update(param1,"count",param2);
      }
      
      public function updateDiscountWithTimer(param1:IGameObject, param2:int, param3:CountDownTimer) : void
      {
         this.update(param1,"discount",param2,false);
         this.update(param1,"timerDiscount",param3);
      }
      
      public function updateDiscountAndCost(param1:IGameObject, param2:int, param3:CountDownTimer, param4:int) : void
      {
         this.update(param1,"discount",param2,false);
         this.update(param1,"timerDiscount",param3,false);
         this.updateCost(param1,param4);
      }
      
      public function updatePreview(param1:ImageResource) : void
      {
         var _loc2_:GarageListRendererData = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.dp.length)
         {
            _loc2_ = GarageListRendererData(this.dp.getItemAt(_loc3_));
            if(_loc2_.preview.id == param1.id)
            {
               this.update(_loc2_.id,"preview",param1);
            }
            _loc3_++;
         }
      }
      
      public function deleteItem(param1:IGameObject) : void
      {
         var _loc2_:int = this.indexById(param1);
         var _loc3_:Object = this.dp.getItemAt(_loc2_);
         if(this.list.selectedIndex == _loc2_)
         {
            this._selectedItem = null;
            this.list.selectedItem = null;
         }
         this.dp.removeItem(_loc3_);
      }
      
      public function select(param1:IGameObject) : void
      {
         var _loc2_:int = 0;
         this.scrollSpeed = 0;
         if(this._selectedItem != param1)
         {
            _loc2_ = this.indexById(param1);
            this.list.selectedIndex = _loc2_;
            this._selectedItem = param1;
            dispatchEvent(new PartsListEvent(PartsListEvent.SELECT_PARTS_LIST_ITEM));
         }
      }
      
      public function scrollTo(param1:IGameObject) : void
      {
         this.scrollSpeed = 0;
         var _loc2_:int = this.indexById(param1);
         this.list.scrollToIndex(_loc2_);
      }
      
      public function unselect() : void
      {
         this._selectedItem = null;
         this.list.selectedItem = null;
      }
      
      private function createIcon(param1:GarageListRendererData, param2:Boolean) : DisplayObject
      {
         var _loc5_:BitmapData = null;
         var _loc9_:GarageItemBackground = null;
         var _loc14_:Bitmap = null;
         var _loc15_:IconGarageMod = null;
         var _loc16_:Bitmap = null;
         var _loc17_:CountDownTimer = null;
         var _loc18_:CountDownTimerLabel = null;
         var _loc3_:Sprite = new DiscreteSprite();
         var _loc4_:Sprite = new DiscreteSprite();
         var _loc6_:LabelBase = new LabelBase();
         var _loc7_:LabelBase = new LabelBase();
         var _loc8_:LabelBase = new LabelBase();
         var _loc10_:Diamond = new Diamond();
         var _loc11_:InputCheckIcon = new InputCheckIcon();
         if((param1.preview as ImageResource).data == null)
         {
            _loc4_.addChild(_loc11_);
            _loc11_.gotoAndStop(CallsignIconStates.CALLSIGN_ICON_STATE_PROGRESS);
            _loc11_.x = 200 - _loc11_.width >> 1;
            _loc11_.y = 130 - _loc11_.height >> 1;
            param1.preview.addLazyListener(this);
         }
         else
         {
            _loc14_ = new Bitmap(param1.preview.data);
            _loc14_.x = 200 - param1.preview.data.width >> 1;
            _loc14_.y = 18;
            _loc4_.addChild(_loc14_);
            GarageResistancesIconsUtils.addIconsToParent(_loc14_,param1.id);
         }
         var _loc12_:Boolean = param1.rank > 0 || param1.showLockPremium;
         if(_loc12_)
         {
            if(param1.type != ItemCategoryEnum.PLUGIN)
            {
               this.addLockItem(param1,_loc4_);
            }
            param1.installed = false;
         }
         else if(param1.garageElement && param1.mod != -1)
         {
            _loc15_ = new IconGarageMod(param1.mod);
            _loc4_.addChild(_loc15_);
            _loc15_.x = 159;
            _loc15_.y = 8;
         }
         if(param1.type == ItemCategoryEnum.INVENTORY || param1.count > 1)
         {
            param1.installed = false;
            _loc4_.addChild(_loc8_);
            _loc8_.x = 15;
            _loc8_.y = 100;
            _loc8_.autoSize = TextFieldAutoSize.NONE;
            _loc8_.size = 16;
            _loc8_.align = TextFormatAlign.LEFT;
            _loc8_.width = 100;
            _loc8_.height = 25;
            _loc8_.text = param1.count == 0 ? " " : "×" + String(param1.count);
         }
         if(_loc12_)
         {
            if(param2)
            {
               _loc9_ = new GarageItemBackground(GarageItemBackground.OFF_NORMAL_SELECTED);
            }
            else
            {
               _loc9_ = new GarageItemBackground(GarageItemBackground.OFF_NORMAL);
            }
            _loc8_.color = _loc7_.color = _loc6_.color = 12632256;
         }
         else if(param1.garageElement || param1.type == ItemCategoryEnum.INVENTORY)
         {
            _loc8_.color = _loc7_.color = _loc6_.color = 11194762;
            if(param2)
            {
               _loc9_ = new GarageItemBackground(GarageItemBackground.GUN_INSTALLED_SELECTED);
            }
            else
            {
               _loc9_ = new GarageItemBackground(GarageItemBackground.GUN_INSTALLED);
            }
         }
         else
         {
            _loc8_.color = _loc7_.color = _loc6_.color = 5898034;
            if(param2)
            {
               _loc9_ = new GarageItemBackground(GarageItemBackground.GUN_NORMAL_SELECTED);
            }
            else
            {
               _loc9_ = new GarageItemBackground(GarageItemBackground.GUN_NORMAL);
            }
         }
         if(param1.installed)
         {
            _loc16_ = new Bitmap(mountedIcon);
            _loc16_.x = 2;
            _loc16_.y = 2;
            _loc4_.addChild(_loc16_);
         }
         _loc6_.text = param1.name;
         if(!param1.garageElement && param1.crystalPrice > 0)
         {
            _loc7_.text = Money.numToString(param1.crystalPrice,false);
            _loc7_.x = 181 - _loc7_.textWidth;
            _loc7_.y = 3;
            _loc4_.addChild(_loc10_);
            _loc4_.addChild(_loc7_);
            _loc10_.x = 186;
            _loc10_.y = 6;
         }
         _loc6_.y = 3;
         _loc6_.x = 3;
         _loc4_.addChildAt(_loc9_,0);
         _loc4_.addChild(_loc6_);
         var _loc13_:LabelBase = new LabelBase();
         if(param1.discount > 0 && (param1.rank <= 0 || param1.garageElement))
         {
            SALE_RED_LABEL.y = _loc9_.height - SALE_RED_LABEL.height - 8;
            SALE_RED_LABEL.x = _loc9_.width - SALE_RED_LABEL.width - 2;
            _loc4_.addChild(SALE_RED_LABEL);
            _loc13_.color = 16777215;
            _loc13_.align = TextFormatAlign.CENTER;
            _loc13_.text = "-" + String(param1.discount) + "%";
            _loc13_.size = 13;
            _loc13_.x = int(SALE_RED_LABEL.x + SALE_RED_LABEL.width / 2 - _loc13_.textWidth / 2);
            _loc13_.y = SALE_RED_LABEL.y + 6;
            _loc4_.addChild(_loc13_);
            if(param1.timerDiscount != null)
            {
               _loc17_ = param1.timerDiscount;
               if(_loc17_.getEndTime() > getTimer())
               {
                  _loc18_ = new CountDownTimerLabel();
                  _loc18_.color = 15258050;
                  _loc18_.start(param1.timerDiscount);
                  _loc18_.y = SALE_RED_LABEL.y + 18;
                  _loc18_.autoSize = TextFieldAutoSize.NONE;
                  _loc18_.align = TextFormatAlign.CENTER;
                  _loc18_.width = SALE_RED_LABEL.width - 8;
                  _loc18_.x = int(SALE_RED_LABEL.x + SALE_RED_LABEL.width / 2 - _loc18_.width / 2);
                  _loc3_.addChild(_loc18_);
               }
               else
               {
                  param1.timerDiscount = null;
                  _loc13_.y += 5;
               }
            }
            else
            {
               _loc13_.y += 5;
            }
         }
         _loc5_ = new BitmapData(_loc4_.width,_loc4_.height,true,0);
         _loc5_.draw(_loc4_);
         _loc3_.addChildAt(new Bitmap(_loc5_),0);
         return _loc3_;
      }
      
      private function addLockItem(param1:GarageListRendererData, param2:Sprite) : void
      {
         if(param1.rank > 0)
         {
            param2.addChild(this.createRankIcon(param1));
         }
         else
         {
            param2.addChild(this.createPremiumIcon());
         }
      }
      
      private function createRankIcon(param1:GarageListRendererData) : RankIcon
      {
         var _loc2_:RankIcon = new BigRankIcon();
         if(param1.showLockPremium)
         {
            _loc2_.setPremium(param1.rank);
            _loc2_.x = PREMIUM_ITEM_LOCK_X;
            _loc2_.y = PREMIUM_ITEM_LOCK_Y;
         }
         else
         {
            _loc2_.setDefaultAccount(param1.rank);
            _loc2_.x = 135;
            _loc2_.y = 65;
         }
         return _loc2_;
      }
      
      private function createPremiumIcon() : Bitmap
      {
         var _loc1_:Bitmap = PremiumItemLock.createInstance();
         _loc1_.x = PREMIUM_ITEM_LOCK_X;
         _loc1_.y = PREMIUM_ITEM_LOCK_Y;
         return _loc1_;
      }
      
      public function indexById(param1:IGameObject) : int
      {
         var _loc2_:GarageListRendererData = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.dp.length)
         {
            _loc2_ = GarageListRendererData(this.dp.getItemAt(_loc3_));
            if(_loc2_.id == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function updateCost(param1:IGameObject, param2:int) : void
      {
         this.update(param1,"crystalPrice",param2);
      }
      
      public function updateShowLockPremium(param1:IGameObject, param2:Boolean) : void
      {
         this.update(param1,"showLockPremium",param2);
      }
      
      public function getItemAt(param1:int) : IGameObject
      {
         return GarageListRendererData(this.dp.getItemAt(param1)).id;
      }
      
      public function itemsCount() : int
      {
         return this.dp.length;
      }
      
      private function scrollList(param1:MouseEvent) : void
      {
         this.scrollSpeed = 0;
         this.list.horizontalScrollPosition -= param1.delta * (Boolean(Capabilities.os.search("Linux") != -1) ? 50 : 10);
      }
      
      public function onResourceLoadingComplete(param1:Resource) : void
      {
         this.updatePreview(param1 as ImageResource);
      }
      
      private function addListeners(param1:Event) : void
      {
         this.list.horizontalScrollBar.addEventListener(Event.ENTER_FRAME,this.updateScrollOnEnterFrame);
         this.list.addEventListener(ListEvent.ITEM_CLICK,this.selectItem);
         this.list.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.selectItemWithDoubleClick);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.scrollList);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      private function removeListeners(param1:Event) : void
      {
         this.list.horizontalScrollBar.removeEventListener(Event.ENTER_FRAME,this.updateScrollOnEnterFrame);
         this.list.removeEventListener(ListEvent.ITEM_CLICK,this.selectItem);
         this.list.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.selectItemWithDoubleClick);
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.scrollList);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      public function onResourceLoadingError(param1:Resource, param2:String) : void
      {
      }
      
      public function onResourceLoadingFatalError(param1:Resource, param2:String) : void
      {
      }
      
      public function onResourceLoadingProgress(param1:Resource, param2:int) : void
      {
      }
      
      public function onResourceLoadingStart(param1:Resource) : void
      {
      }
      
      public function destroy() : void
      {
         removeDisplayObject(this.list);
         this.removePreviewLazyListeners();
         this.dp.removeAll();
         this.list.removeAll();
         this.list = null;
         this.dp = null;
      }
      
      private function removePreviewLazyListeners() : void
      {
         var _loc1_:GarageListRendererData = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.dp.length)
         {
            _loc1_ = GarageListRendererData(this.dp.getItemAt(_loc2_));
            _loc1_.preview.removeLazyListener(this);
            _loc2_++;
         }
      }
      
      public function clearList() : void
      {
         this.removePreviewLazyListeners();
         this.dp.removeAll();
      }
      
      public function addItem(param1:GarageListRendererData) : void
      {
         param1.iconNormal = this.createIcon(param1,false);
         param1.iconSelected = this.createIcon(param1,true);
         this.dp.addItem(param1);
      }
      
      public function sort() : void
      {
         this.dp.sortOn(["appearanceTime","garageElement","rank","showLockPremium","sort"],[Array.DESCENDING,Array.DESCENDING,Array.NUMERIC,Array.NUMERIC,Array.NUMERIC]);
      }
   }
}

