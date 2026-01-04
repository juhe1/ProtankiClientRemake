package alternativa.tanks.gui.tables
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.model.item.kit.GarageKit;
   import alternativa.tanks.service.item.ItemService;
   import assets.Diamond;
   import controls.Money;
   import controls.base.LabelBase;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.text.TextFormatAlign;
   import forms.ColorConstants;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.garage.models.item.kit.KitItem;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class KitInfoTable extends Sprite
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var itemService:ItemService;
      
      private static const upgradeSelectionLeftClass:Class = KitInfoTable_upgradeSelectionLeftClass;
      
      private static const upgradeSelectionCenterClass:Class = KitInfoTable_upgradeSelectionCenterClass;
      
      private const LEFT_TOP_MARGIN:int = 12;
      
      private const SUMMARY_TOP_MARGIN:int = 13;
      
      private const CRYSTAL_TOP_MARGIN:int = 4;
      
      private const ITEM_HEIGHT:int = 17;
      
      private var selection:Shape = new Shape();
      
      private var _width:int;
      
      private var topPartHeight:int;
      
      private var bottomPartHeight:int;
      
      private var kitObject:IGameObject;
      
      private var kit:GarageKit;
      
      public function KitInfoTable(param1:int)
      {
         super();
         this._width = param1;
         this.topPartHeight = 0;
      }
      
      public function show(param1:IGameObject) : void
      {
         this.kitObject = param1;
         this.kit = GarageKit(param1.adapt(GarageKit));
         var _loc2_:int = int(this.kit.getItems().length);
         this.topPartHeight = this.LEFT_TOP_MARGIN + (_loc2_ + 1) * this.ITEM_HEIGHT;
         this.clearTable();
         this.addHeader();
         this.addRows();
         this.addSum();
         this.addSummary();
      }
      
      public function clearTable() : void
      {
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      private function addHeader() : void
      {
         var _loc1_:LabelBase = new LabelBase();
         _loc1_.color = ColorConstants.GREEN_LABEL;
         _loc1_.align = TextFormatAlign.LEFT;
         _loc1_.text = localeService.getText(TanksLocale.TEXT_ITEMS_IN_KIT);
         _loc1_.x = this.LEFT_TOP_MARGIN;
         _loc1_.y = this.LEFT_TOP_MARGIN;
         addChild(_loc1_);
         var _loc2_:LabelBase = new LabelBase();
         _loc2_.color = ColorConstants.GREEN_LABEL;
         _loc2_.align = TextFormatAlign.RIGHT;
         _loc2_.text = localeService.getText(TanksLocale.TEXT_GARAGE_PRICE);
         _loc2_.x = this._width - _loc2_.width - _loc1_.x;
         _loc2_.y = _loc1_.y;
         addChild(_loc2_);
      }
      
      private function addRows() : void
      {
         var _loc2_:KitItem = null;
         var _loc3_:KitItemInfoRow = null;
         this.kit.getItems().sort(this.compareItems);
         var _loc1_:int = this.LEFT_TOP_MARGIN + this.ITEM_HEIGHT;
         for each(_loc2_ in this.kit.getItems())
         {
            _loc3_ = new KitItemInfoRow(_loc1_,this._width,_loc2_,this.LEFT_TOP_MARGIN,this.CRYSTAL_TOP_MARGIN);
            addChild(_loc3_);
            _loc1_ += this.ITEM_HEIGHT;
         }
      }
      
      private function addSum() : void
      {
         var _loc1_:LabelBase = new LabelBase();
         _loc1_.color = ColorConstants.GREEN_LABEL;
         _loc1_.align = TextFormatAlign.LEFT;
         _loc1_.text = localeService.getText(TanksLocale.TEXT_TOTAL_PRICE_KIT);
         _loc1_.x = this.LEFT_TOP_MARGIN;
         _loc1_.y = this.topPartHeight + this.ITEM_HEIGHT - 6;
         addChild(_loc1_);
         var _loc2_:Diamond = new Diamond();
         _loc2_.x = this._width - _loc1_.x - _loc2_.width;
         addChild(_loc2_);
         _loc2_.y = _loc1_.y + this.CRYSTAL_TOP_MARGIN;
         var _loc3_:LabelBase = new LabelBase();
         _loc3_.color = ColorConstants.GREEN_LABEL;
         _loc3_.align = TextFormatAlign.RIGHT;
         _loc3_.text = Money.numToString(this.kit.getPriceWithoutDiscount(),false);
         _loc3_.x = _loc2_.x - _loc3_.width - 1;
         _loc3_.y = _loc1_.y;
         addChild(_loc3_);
      }
      
      private function addSummary() : void
      {
         addChild(this.selection);
         this.selection.y = this.SUMMARY_TOP_MARGIN + this.ITEM_HEIGHT + this.topPartHeight;
         this.resizeSelection();
         var _loc1_:int = int(itemService.getDiscount(this.kitObject));
         var _loc2_:int = int(itemService.getPrice(this.kitObject));
         var _loc3_:String = localeService.getText(TanksLocale.TEXT_DISCOUNTED_AT_KIT);
         _loc3_ = _loc3_.replace("{0}",_loc1_ + "%");
         this.addSummaryRow(_loc3_,_loc2_);
         this.bottomPartHeight = 2 * this.ITEM_HEIGHT;
      }
      
      private function addSummaryRow(param1:String, param2:int) : void
      {
         var _loc3_:LabelBase = new LabelBase();
         _loc3_.align = TextFormatAlign.LEFT;
         _loc3_.text = param1;
         _loc3_.x = this.LEFT_TOP_MARGIN;
         _loc3_.y = this.SUMMARY_TOP_MARGIN + this.ITEM_HEIGHT + this.topPartHeight;
         addChild(_loc3_);
         var _loc4_:Diamond = new Diamond();
         _loc4_.x = this._width - _loc3_.x - _loc4_.width;
         addChild(_loc4_);
         _loc4_.y = _loc3_.y + this.CRYSTAL_TOP_MARGIN;
         var _loc5_:LabelBase = new LabelBase();
         _loc5_.align = TextFormatAlign.RIGHT;
         _loc5_.text = Money.numToString(param2,false);
         _loc5_.x = _loc4_.x - _loc5_.width - 1;
         _loc5_.y = _loc3_.y;
         addChild(_loc5_);
      }
      
      private function resizeSelection() : void
      {
         var _loc1_:int = this._width - 18;
         var _loc2_:BitmapData = new upgradeSelectionLeftClass().bitmapData;
         this.selection.x = 9;
         this.selection.graphics.clear();
         this.selection.graphics.beginBitmapFill(_loc2_);
         this.selection.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         var _loc3_:BitmapData = new upgradeSelectionCenterClass().bitmapData;
         this.selection.graphics.beginBitmapFill(_loc3_);
         this.selection.graphics.drawRect(_loc2_.width,0,_loc1_ - _loc2_.width * 2,_loc3_.height);
         var _loc4_:Matrix = new Matrix(-1,0,0,1,_loc1_,0);
         this.selection.graphics.beginBitmapFill(_loc2_,_loc4_);
         this.selection.graphics.drawRect(_loc1_ - _loc2_.width,0,_loc2_.width,_loc2_.height);
         this.selection.graphics.endFill();
      }
      
      private function compareItems(param1:KitItem, param2:KitItem) : Number
      {
         var _loc3_:int = this.getTypeIndex(param1);
         var _loc4_:int = this.getTypeIndex(param2);
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         var _loc5_:int = itemService.getPrice(param1.item) * param1.count;
         var _loc6_:int = itemService.getPrice(param2.item) * param2.count;
         if(_loc5_ < _loc6_)
         {
            return 1;
         }
         if(_loc5_ > _loc6_)
         {
            return -1;
         }
         return 0;
      }
      
      private function getTypeIndex(param1:KitItem) : int
      {
         switch(itemService.getCategory(param1.item))
         {
            case ItemCategoryEnum.WEAPON:
               return 0;
            case ItemCategoryEnum.ARMOR:
               return 1;
            case ItemCategoryEnum.INVENTORY:
               return 3;
            case ItemCategoryEnum.PLUGIN:
               return 4;
            case ItemCategoryEnum.COLOR:
               return 5;
            default:
               return 6;
         }
      }
      
      public function getTopPartTableHeight() : int
      {
         return this.topPartHeight;
      }
      
      public function getFullTableHeight() : int
      {
         return this.SUMMARY_TOP_MARGIN + this.topPartHeight + this.bottomPartHeight;
      }
      
      public function getBottomPartTableHeight() : int
      {
         return this.bottomPartHeight;
      }
   }
}

