package alternativa.tanks.gui.category
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.friends.button.friends.NewRequestIndicator;
   import controls.buttons.IconButton;
   import flash.display.Bitmap;
   import projects.tanks.client.commons.types.ItemViewCategoryEnum;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class ItemCategoryButton extends IconButton
   {
      
      public static const specialIconClass:Class = ItemCategoryButton_specialIconClass;
      
      public static const weaponIconClass:Class = ItemCategoryButton_weaponIconClass;
      
      public static const armorIconClass:Class = ItemCategoryButton_armorIconClass;
      
      public static const colorIconClass:Class = ItemCategoryButton_colorIconClass;
      
      public static const kitIconClass:Class = ItemCategoryButton_kitIconClass;
      
      public static const inventoryIconClass:Class = ItemCategoryButton_inventoryIconClass;
      
      public static const discountIconClass:Class = ItemCategoryButton_discountIconClass;
      
      public static const givenPresentsIconClass:Class = ItemCategoryButton_givenPresentsIconClass;
      
      public static const resistanceIconClass:Class = ItemCategoryButton_resistanceIconClass;
      
      private static const droneIconClass:Class = ItemCategoryButton_droneIconClass;
      
      private var category:ItemViewCategoryEnum;
      
      private var _newItemIndicator:Bitmap;
      
      private var _discountIndicator:Bitmap;
      
      private var _width:int;
      
      public function ItemCategoryButton(param1:ItemViewCategoryEnum)
      {
         var _loc3_:String = null;
         var _loc4_:Class = null;
         this._newItemIndicator = new NewRequestIndicator.attentionIconClass();
         this._discountIndicator = new discountIconClass();
         var _loc2_:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
         switch(param1)
         {
            case ItemViewCategoryEnum.SPECIAL:
               _loc3_ = _loc2_.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_SPECIAL);
               _loc4_ = specialIconClass;
               break;
            case ItemViewCategoryEnum.WEAPON:
               _loc3_ = _loc2_.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_TURRETS);
               _loc4_ = weaponIconClass;
               break;
            case ItemViewCategoryEnum.ARMOR:
               _loc3_ = _loc2_.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_HULLS);
               _loc4_ = armorIconClass;
               break;
            case ItemViewCategoryEnum.PAINT:
               _loc3_ = _loc2_.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_PAINTS);
               _loc4_ = colorIconClass;
               break;
            case ItemViewCategoryEnum.KIT:
               _loc3_ = _loc2_.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_KITS);
               _loc4_ = kitIconClass;
               break;
            case ItemViewCategoryEnum.INVENTORY:
               _loc3_ = _loc2_.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_SUPPLIES);
               _loc4_ = inventoryIconClass;
               break;
            //case ItemViewCategoryEnum.RESISTANCE:
            //   _loc3_ = _loc2_.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_RESISTANCE_MODULES);
            //   _loc4_ = resistanceIconClass;
            //   break;
            case ItemViewCategoryEnum.GIVEN_PRESENTS:
               _loc3_ = _loc2_.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_PRESENTS);
               _loc4_ = givenPresentsIconClass;
               break;
            //case ItemViewCategoryEnum.DRONE:
            //   _loc3_ = _loc2_.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_DRONES);
            //   _loc4_ = droneIconClass;
         }
         super(_loc3_,_loc4_);
         enabled = true;
         this.category = param1;
         addChild(this._newItemIndicator);
         this._newItemIndicator.y = -5;
         this._newItemIndicator.visible = false;
         addChild(this._discountIndicator);
         this._discountIndicator.y = -5;
         this._discountIndicator.visible = false;
         alignIcon();
      }
      
      public function getCategory() : ItemViewCategoryEnum
      {
         return this.category;
      }
      
      public function setIconState() : void
      {
         icon.visible = true;
         _label.visible = false;
         this.width = 30;
      }
      
      public function setTextState() : void
      {
         icon.visible = false;
         _label.visible = true;
         this.width = 6 + _label.width + 6;
      }
      
      public function setIconTextState() : void
      {
         icon.visible = true;
         _label.visible = true;
         this.width = 27 + _label.width + 6;
      }
      
      public function showNewItemIndicator() : void
      {
         this._newItemIndicator.visible = true;
      }
      
      public function hideNewItemIndicator() : void
      {
         this._newItemIndicator.visible = false;
      }
      
      public function showDiscountIndicator() : void
      {
         this._discountIndicator.visible = true;
      }
      
      public function hideDiscountIndicator() : void
      {
         this._discountIndicator.visible = false;
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
         if(_label.visible)
         {
            if(Boolean(icon) && Boolean(icon.visible))
            {
               _label.x = 21 + (this._width - 21 - _label.width >> 1);
            }
            else
            {
               _label.x = this._width - _label.width >> 1;
            }
         }
         this._newItemIndicator.x = param1 - (this._newItemIndicator.width >> 1) - 4;
         this._discountIndicator.x = param1 - (this._discountIndicator.width >> 1) - 4;
         super.width = this._width;
      }
   }
}

