package alternativa.tanks.gui.category
{
   import base.DiscreteSprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import projects.tanks.client.commons.types.ItemViewCategoryEnum;
   
   public class CategoryButtonsList extends DiscreteSprite
   {
      
      private static const SPACE_BETWEEN_BUTTON:int = 5;
      
      private var selectedCategory:ItemViewCategoryEnum;
      
      private var buttons:Vector.<ItemCategoryButton> = new Vector.<ItemCategoryButton>();
      
      private var categoryToButton:Dictionary = new Dictionary();
      
      private var textMaxButtonWidth:int;
      
      private var iconAndTextMaxButtonWidth:int;
      
      private var maxWidth:int = 100;
      
      public function CategoryButtonsList()
      {
         super();
         this.addButton(ItemViewCategoryEnum.WEAPON);
         this.addButton(ItemViewCategoryEnum.ARMOR);
         //this.addButton(ItemViewCategoryEnum.DRONE);
         //this.addButton(ItemViewCategoryEnum.RESISTANCE);
         this.addButton(ItemViewCategoryEnum.PAINT);
         this.addButton(ItemViewCategoryEnum.INVENTORY);
         this.addButton(ItemViewCategoryEnum.KIT);
         this.addButton(ItemViewCategoryEnum.SPECIAL);
         this.addButton(ItemViewCategoryEnum.GIVEN_PRESENTS);
         this.buttons[0].enabled = false;
         this.selectedCategory = this.buttons[0].getCategory();
         this.calculateWidth();
      }
      
      public function select(param1:ItemViewCategoryEnum) : void
      {
         this.categoryToButton[this.selectedCategory].enabled = true;
         this.categoryToButton[param1].enabled = false;
         this.selectedCategory = param1;
         dispatchEvent(new CategoryButtonsListEvent(CategoryButtonsListEvent.CATEGORY_SELECTED,this.selectedCategory));
      }
      
      public function getSelectedCategory() : ItemViewCategoryEnum
      {
         return this.selectedCategory;
      }
      
      public function setCategoryButtonVisibility(param1:ItemViewCategoryEnum, param2:Boolean) : void
      {
         this.categoryToButton[param1].visible = param2;
         this.calculateWidth();
      }
      
      public function getCategoryButtonVisibility(param1:ItemViewCategoryEnum) : Boolean
      {
         return this.categoryToButton[param1].visible;
      }
      
      public function showNewItemIndicator(param1:ItemViewCategoryEnum) : void
      {
         this.categoryToButton[param1].showNewItemIndicator();
      }
      
      public function hideNewItemIndicator(param1:ItemViewCategoryEnum) : void
      {
         this.categoryToButton[param1].hideNewItemIndicator();
      }
      
      public function showDiscountIndicator(param1:ItemViewCategoryEnum) : void
      {
         this.categoryToButton[param1].showDiscountIndicator();
      }
      
      public function hideDiscountIndicator(param1:ItemViewCategoryEnum) : void
      {
         this.categoryToButton[param1].hideDiscountIndicator();
      }
      
      private function addButton(param1:ItemViewCategoryEnum) : void
      {
         var _loc2_:ItemCategoryButton = new ItemCategoryButton(param1);
         this.buttons.push(_loc2_);
         this.categoryToButton[param1] = _loc2_;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onButtonClick);
         addChild(_loc2_);
      }
      
      private function calculateWidth() : void
      {
         var _loc1_:ItemCategoryButton = null;
         this.textMaxButtonWidth = this.iconAndTextMaxButtonWidth = 0;
         for each(_loc1_ in this.buttons)
         {
            if(_loc1_.visible)
            {
               _loc1_.setTextState();
               this.textMaxButtonWidth = Math.max(this.textMaxButtonWidth,_loc1_.width);
               _loc1_.setIconTextState();
               this.iconAndTextMaxButtonWidth = Math.max(this.iconAndTextMaxButtonWidth,_loc1_.width);
            }
         }
         this.selectLod();
      }
      
      override public function get width() : Number
      {
         return this.maxWidth;
      }
      
      override public function set width(param1:Number) : void
      {
         this.maxWidth = param1;
         this.selectLod();
      }
      
      private function selectLod() : void
      {
         var _loc3_:ItemCategoryButton = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for each(_loc3_ in this.buttons)
         {
            if(_loc3_.visible)
            {
               _loc2_++;
            }
         }
         _loc4_ = (this.maxWidth - (_loc2_ - 1) * SPACE_BETWEEN_BUTTON) / _loc2_;
         if(_loc4_ >= this.iconAndTextMaxButtonWidth)
         {
            _loc4_ = Math.min(_loc4_,this.iconAndTextMaxButtonWidth + 7);
         }
         else if(_loc4_ >= this.textMaxButtonWidth)
         {
            _loc4_ = Math.min(_loc4_,this.textMaxButtonWidth + 14);
         }
         for each(_loc3_ in this.buttons)
         {
            if(_loc3_.visible)
            {
               if(this.iconAndTextMaxButtonWidth <= _loc4_)
               {
                  _loc3_.setIconTextState();
                  _loc3_.width = _loc4_;
               }
               else if(this.textMaxButtonWidth <= _loc4_)
               {
                  _loc3_.setTextState();
                  _loc3_.width = _loc4_;
               }
               else
               {
                  _loc3_.setIconState();
               }
               _loc3_.x = _loc1_;
               _loc1_ += _loc3_.width;
               _loc1_ += SPACE_BETWEEN_BUTTON;
            }
         }
      }
      
      private function onButtonClick(param1:MouseEvent) : void
      {
         if(param1.target is ItemCategoryButton)
         {
            this.select(ItemCategoryButton(param1.target).getCategory());
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:ItemCategoryButton = null;
         for each(_loc1_ in this.buttons)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         }
         this.buttons = null;
         this.categoryToButton = null;
      }
      
      public function findVisibleCategory() : ItemViewCategoryEnum
      {
         var _loc1_:ItemCategoryButton = null;
         for each(_loc1_ in this.buttons)
         {
            if(_loc1_.visible)
            {
               return _loc1_.getCategory();
            }
         }
         throw new Error("No category to show");
      }
   }
}

