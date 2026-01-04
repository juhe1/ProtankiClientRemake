package alternativa.tanks.gui.itemslist
{
   import alternativa.tanks.model.garage.resistance.ResistancesIconsUtils;
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
   import controls.timer.CountDownTimerOnCompleteBefore;
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
   import projects.tanks.client.commons.types.ItemGarageProperty;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.disposeBitmapsData;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
   import utils.ScrollStyleUtils;
   
   public class PartsList extends Sprite implements IResourceLoadingListener, CountDownTimerOnCompleteBefore
   {
      
      private static const labelRed:Bitmap = SaleIcons.createSaleRedLabelInstance();
      
      private static const MIN_POSIBLE_SPEED:Number = 70;
      
      private static const MAX_DELTA_FOR_SELECT:Number = 7;
      
      private static const ADDITIONAL_SCROLL_AREA_HEIGHT:Number = 3;
      
      private static const PREMIUM_ITEM_LOCK_X:int = 118;
      
      private static const PREMIUM_ITEM_LOCK_Y:int = 58;
      
      private var list:TileList;
      
      private var dp:DataProvider;
      
      private var typeSort:Array = [ItemCategoryEnum.WEAPON,ItemCategoryEnum.ARMOR,ItemCategoryEnum.COLOR,ItemCategoryEnum.PLUGIN,ItemCategoryEnum.INVENTORY,ItemCategoryEnum.KIT];
      
      private var _selectedItem:IGameObject = null;
      
      private var previousPositionX:Number;
      
      private var currrentPositionX:Number;
      
      private var sumDragWay:Number;
      
      private var lastItemIndex:int;
      
      private var previousTime:int;
      
      private var currentTime:int;
      
      private var scrollSpeed:Number = 0;
      
      private var bitmapsData:Array;
      
      private var _width:int;
      
      private var _height:int;
      
      public function PartsList()
      {
         super();
         this.bitmapsData = [];
         this.dp = new DataProvider();
         this.list = new TileList();
         this.list.dataProvider = this.dp;
         this.list.rowCount = 1;
         this.list.rowHeight = 130;
         this.list.columnWidth = 203;
         this.list.setStyle("cellRenderer",PartsListRenderer);
         this.list.direction = ScrollBarDirection.HORIZONTAL;
         this.list.focusEnabled = false;
         this.list.horizontalScrollBar.focusEnabled = false;
         addChild(this.list);
         addEventListener(Event.ADDED_TO_STAGE,this.addListners);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removeListners);
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
      
      public function get columnWidth() : int
      {
         return Math.ceil(this.list.columnWidth);
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
         var _loc3_:Number = this.list.horizontalScrollPosition;
         var _loc4_:Number = this.list.maxHorizontalScrollPosition;
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
      
      private function selectItem(param1:ListEvent) : void
      {
         var _loc2_:Object = null;
         if(this.sumDragWay < MAX_DELTA_FOR_SELECT)
         {
            _loc2_ = param1.item;
            this.scrollSpeed = 0;
            if(this._selectedItem != _loc2_.dat.id)
            {
               this._selectedItem = _loc2_.dat.id;
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
      
      public function addItem(param1:IGameObject, param2:String, param3:ItemCategoryEnum, param4:int, param5:int, param6:int, param7:Boolean, param8:Boolean, param9:int, param10:ImageResource, param11:int = 0, param12:CountDownTimer = null, param13:int = -1, param14:CountDownTimer = null, param15:Vector.<ItemGarageProperty> = null, param16:Boolean = false) : void
      {
         var _loc18_:DisplayObject = null;
         var _loc19_:DisplayObject = null;
         var _loc17_:Object = {};
         _loc17_.id = param1;
         _loc17_.name = param2;
         _loc17_.type = param3;
         _loc17_.typeSort = this.typeSort[param3];
         _loc17_.mod = param13;
         _loc17_.crystalPrice = param5;
         _loc17_.rank = param6 == 0 && !param7 ? -1 : param6;
         _loc17_.showLockPremium = param7;
         _loc17_.installed = false;
         _loc17_.garageElement = param8;
         _loc17_.count = param9;
         _loc17_.preview = param10;
         _loc17_.sort = param4;
         _loc17_.discount = param11;
         _loc17_.timer = param12;
         _loc17_.timerDiscount = param14;
         _loc17_.resistances = param15;
         _loc17_.isUpgradingInAvailableItemsAlert = param16;
         if(param12 != null && param16)
         {
            _loc17_.timer.addListener(CountDownTimerOnCompleteBefore,this);
         }
         _loc18_ = this.myIcon(_loc17_,false);
         _loc19_ = this.myIcon(_loc17_,true);
         this.dp.addItem({
            "iconNormal":_loc18_,
            "iconSelected":_loc19_,
            "dat":_loc17_,
            "rank":_loc17_.rank,
            "type":param3,
            "typesort":_loc17_.typeSort,
            "sort":param4
         });
         this.dp.sortOn(["rank","sort"],[Array.NUMERIC,Array.NUMERIC]);
      }
      
      private function update(param1:IGameObject, param2:String, param3:* = null, param4:Boolean = true) : void
      {
         var _loc5_:int = this.indexById(param1);
         this.updateByIndex(_loc5_,param2,param3,param4);
      }
      
      private function updateByIndex(param1:int, param2:String, param3:*, param4:Boolean) : void
      {
         var _loc7_:DisplayObject = null;
         var _loc8_:DisplayObject = null;
         var _loc5_:Object = this.dp.getItemAt(param1);
         var _loc6_:Object = _loc5_.dat;
         _loc6_[param2] = param3;
         if(param4)
         {
            _loc7_ = this.myIcon(_loc6_,false);
            _loc8_ = this.myIcon(_loc6_,true);
            _loc5_.dat = _loc6_;
            _loc5_.iconNormal = _loc7_;
            _loc5_.iconSelected = _loc8_;
            this.dp.replaceItemAt(_loc5_,param1);
            this.dp.sortOn(["rank","sort"],[Array.NUMERIC,Array.NUMERIC]);
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
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.dp.length)
         {
            _loc2_ = this.dp.getItemAt(_loc3_);
            if((_loc2_.dat.preview as ImageResource).id == param1.id)
            {
               this.update(_loc2_.dat.id,"preview",param1 as ImageResource);
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
      
      public function selectByIndex(param1:uint) : void
      {
         var _loc2_:Object = null;
         this.scrollSpeed = 0;
         if(this.list.selectedIndex != param1)
         {
            _loc2_ = (this.dp.getItemAt(param1) as Object).dat;
            this.list.selectedIndex = param1;
            this._selectedItem = _loc2_.id;
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
      
      private function myIcon(param1:Object, param2:Boolean) : DisplayObject
      {
         var _loc5_:BitmapData = null;
         var _loc9_:GarageItemBackground = null;
         var _loc10_:String = null;
         var _loc14_:Bitmap = null;
         var _loc15_:IconGarageMod = null;
         var _loc16_:CountDownTimer = null;
         var _loc17_:CountDownTimerLabel = null;
         var _loc3_:Sprite = new DiscreteSprite();
         var _loc4_:Sprite = new DiscreteSprite();
         var _loc6_:LabelBase = new LabelBase();
         var _loc7_:LabelBase = new LabelBase();
         var _loc8_:LabelBase = new LabelBase();
         var _loc11_:Diamond = new Diamond();
         var _loc12_:InputCheckIcon = new InputCheckIcon();
         if((param1.preview as ImageResource).data == null)
         {
            _loc4_.addChild(_loc12_);
            _loc12_.gotoAndStop(CallsignIconStates.CALLSIGN_ICON_STATE_PROGRESS);
            _loc12_.x = 200 - _loc12_.width >> 1;
            _loc12_.y = 130 - _loc12_.height >> 1;
            (param1.preview as ImageResource).addLazyListener(this);
         }
         else
         {
            _loc14_ = new Bitmap((param1.preview as ImageResource).data);
            if(param1.resistances != null)
            {
               _loc14_.x = 200 - _loc14_.width >> 1;
               _loc14_.y = 14 + (130 - _loc14_.height) >> 1;
               _loc4_.addChild(_loc14_);
               ResistancesIconsUtils.addResistanceIcons(_loc14_,Vector.<ItemGarageProperty>(param1.resistances));
            }
            else
            {
               _loc14_.x = 19;
               _loc14_.y = 18;
               _loc4_.addChild(_loc14_);
            }
         }
         if(param1.rank > 0 || Boolean(param1.showLockPremium))
         {
            if(param1.type != ItemCategoryEnum.PLUGIN)
            {
               this.addLockItem(param1,_loc4_);
            }
            _loc10_ = "OFF";
            param1.installed = false;
            _loc8_.color = _loc7_.color = _loc6_.color = 12632256;
         }
         else
         {
            _loc8_.color = _loc7_.color = _loc6_.color = 5898034;
            if(Boolean(param1.garageElement) && param1.mod != -1)
            {
               _loc15_ = new IconGarageMod(param1.mod);
               _loc4_.addChild(_loc15_);
               _loc15_.x = 159;
               _loc15_.y = 7;
            }
            switch(param1.type)
            {
               case ItemCategoryEnum.WEAPON:
                  if(Boolean(param1.garageElement) && Boolean(param1.installed))
                  {
                     _loc6_.color = 8693863;
                  }
                  _loc10_ = "GUN";
                  break;
               case ItemCategoryEnum.ARMOR:
                  if(Boolean(param1.garageElement) && Boolean(param1.installed))
                  {
                     _loc6_.color = 9411748;
                  }
                  _loc10_ = "SHIELD";
                  break;
               case ItemCategoryEnum.COLOR:
                  _loc10_ = "COLOR";
                  if(Boolean(param1.installed))
                  {
                     _loc6_.color = 11049390;
                  }
                  break;
               case ItemCategoryEnum.INVENTORY:
                  _loc10_ = "ENGINE";
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
                  break;
               default:
                  _loc10_ = "PLUGIN";
            }
         }
         _loc10_ += (Boolean(param1.installed) ? "_INSTALLED" : "_NORMAL") + (param2 ? "_SELECTED" : "");
         _loc9_ = new GarageItemBackground(GarageItemBackground.idByName(_loc10_));
         _loc6_.text = param1.name;
         if(!param1.garageElement || param1.type == ItemCategoryEnum.INVENTORY)
         {
            if(param1.crystalPrice > 0)
            {
               _loc7_.text = Money.numToString(param1.crystalPrice,false);
               _loc7_.x = 181 - _loc7_.textWidth;
               _loc7_.y = 2;
               _loc4_.addChild(_loc11_);
               _loc4_.addChild(_loc7_);
               _loc11_.x = 186;
               _loc11_.y = 6;
            }
         }
         _loc6_.y = 2;
         _loc6_.x = 3;
         _loc4_.addChildAt(_loc9_,0);
         _loc4_.addChild(_loc6_);
         var _loc13_:LabelBase = new LabelBase();
         if(param1.discount > 0 && (param1.rank <= 0 || param1.garageElement))
         {
            labelRed.y = _loc9_.height - labelRed.height - 8;
            labelRed.x = _loc9_.width - labelRed.width - 2;
            _loc4_.addChild(labelRed);
            _loc13_.color = 16777215;
            _loc13_.align = TextFormatAlign.CENTER;
            _loc13_.text = "-" + String(param1.discount) + "%";
            _loc13_.size = 13;
            _loc13_.x = int(labelRed.x + labelRed.width / 2 - _loc13_.textWidth / 2);
            _loc13_.y = labelRed.y + 6;
            _loc4_.addChild(_loc13_);
            if(param1.timerDiscount != null)
            {
               _loc16_ = param1.timerDiscount;
               if(_loc16_.getEndTime() > getTimer())
               {
                  _loc17_ = new CountDownTimerLabel();
                  _loc17_.color = 15258050;
                  _loc17_.start(param1.timerDiscount);
                  _loc17_.y = labelRed.y + 18;
                  _loc17_.autoSize = TextFieldAutoSize.NONE;
                  _loc17_.align = TextFormatAlign.CENTER;
                  _loc17_.width = labelRed.width - 8;
                  _loc17_.x = int(labelRed.x + labelRed.width / 2 - _loc17_.width / 2);
                  _loc3_.addChild(_loc17_);
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
         this.bitmapsData.push(_loc5_);
         _loc5_.draw(_loc4_);
         _loc3_.addChildAt(new Bitmap(_loc5_),0);
         if(param1.timer != null)
         {
            if(Boolean(param1.isUpgradingInAvailableItemsAlert))
            {
               _loc17_ = new CountDownTimerLabel();
               _loc17_.start(param1.timer);
               _loc17_.y = _loc9_.height - _loc17_.textHeight - 7;
               _loc17_.width = _loc9_.width - 7;
               _loc17_.autoSize = TextFieldAutoSize.NONE;
               _loc17_.align = TextFormatAlign.RIGHT;
               _loc17_.x = 0;
               _loc3_.addChild(_loc17_);
            }
         }
         return _loc3_;
      }
      
      private function addLockItem(param1:Object, param2:Sprite) : void
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
      
      private function createRankIcon(param1:Object) : RankIcon
      {
         var _loc2_:RankIcon = new BigRankIcon();
         if(Boolean(param1.showLockPremium))
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
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.dp.length)
         {
            _loc2_ = this.dp.getItemAt(_loc3_);
            if(_loc2_.dat.id == param1)
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
      
      public function removeDiscountItem(param1:IGameObject) : void
      {
         this.update(param1,"saleImage",null);
      }
      
      public function getItemAt(param1:int) : IGameObject
      {
         return this.dp.getItemAt(param1).dat.id;
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
      
      private function addListners(param1:Event) : void
      {
         this.list.horizontalScrollBar.addEventListener(Event.ENTER_FRAME,this.updateScrollOnEnterFrame);
         this.list.addEventListener(ListEvent.ITEM_CLICK,this.selectItem);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.scrollList);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      private function removeListners(param1:Event) : void
      {
         this.list.horizontalScrollBar.removeEventListener(Event.ENTER_FRAME,this.updateScrollOnEnterFrame);
         this.list.removeEventListener(ListEvent.ITEM_CLICK,this.selectItem);
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
      
      public function onCompleteBefore(param1:CountDownTimer, param2:Boolean) : void
      {
         var _loc4_:Object = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.dp.length)
         {
            _loc4_ = this.dp.getItemAt(_loc3_).dat;
            if(_loc4_.timer == param1)
            {
               this.updateByIndex(_loc3_,"timer",null,false);
            }
            _loc3_++;
         }
      }
      
      public function destroy() : void
      {
         disposeBitmapsData(this.bitmapsData);
         this.bitmapsData = null;
         removeDisplayObject(this.list);
         this.removePreviewLazyListeners();
         this.removeAllElements();
         this.list.removeAll();
         this.list = null;
         this.dp = null;
      }
      
      private function removeAllElements() : void
      {
         var _loc2_:Object = null;
         var _loc3_:CountDownTimer = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.dp.length)
         {
            _loc2_ = this.dp.getItemAt(_loc1_).dat;
            if(_loc2_.timer != null)
            {
               _loc3_ = _loc2_.timer;
               _loc3_.removeListener(CountDownTimerOnCompleteBefore,this);
            }
            _loc1_++;
         }
         this.dp.removeAll();
      }
      
      private function removePreviewLazyListeners() : void
      {
         var _loc1_:Object = null;
         var _loc2_:ImageResource = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.dp.length)
         {
            _loc1_ = this.dp.getItemAt(_loc3_);
            _loc2_ = _loc1_.dat.preview as ImageResource;
            _loc2_.removeLazyListener(this);
            _loc3_++;
         }
      }
   }
}

