package alternativa.tanks.model.item.resistance.view
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.shop.components.itemscategory.ItemsCategoryViewGrid;
   import alternativa.tanks.service.resistance.ResistanceService;
   import base.DiscreteSprite;
   import controls.TankWindowInner;
   import controls.base.LabelBase;
   import forms.ColorConstants;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class MountedResistancesPanel extends DiscreteSprite
   {
      
      [Inject]
      public static var resistanceService:ResistanceService;
      
      [Inject]
      public static var localeService:ILocaleService;
      
      private static const VERTICAL_MARGIN:int = 9;
      
      private static const SLOTS:int = 3;
      
      private var background:TankWindowInner;
      
      private var panel:ItemsCategoryViewGrid;
      
      private var cells:Vector.<ResistanceButton>;
      
      private var label:LabelBase;
      
      public function MountedResistancesPanel()
      {
         var _loc2_:ResistanceButton = null;
         this.background = new TankWindowInner(164,0,TankWindowInner.GREEN);
         this.panel = new ItemsCategoryViewGrid();
         this.cells = new Vector.<ResistanceButton>();
         this.label = new LabelBase();
         super();
         var _loc1_:int = 0;
         while(_loc1_ < SLOTS)
         {
            _loc2_ = new ResistanceButton(_loc1_);
            this.cells.push(_loc2_);
            this.panel.addItem(_loc2_);
            _loc1_++;
         }
         this.label.text = localeService.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_RESISTANCE_MODULES);
         this.label.size = 18;
         this.label.color = ColorConstants.GREEN_TEXT;
         this.label.y += VERTICAL_MARGIN >> 1;
         this.background.addChild(this.label);
         this.panel.y = this.label.y + this.label.height + 4;
         this.panel.horizontalSpacing = 8;
         this.background.addChild(this.panel);
         this.background.height += VERTICAL_MARGIN >> 1;
         addChild(this.background);
         resistanceService.registerView(this);
      }
      
      public function resize(param1:Number) : void
      {
         this.render();
         this.background.width = param1;
         if(this.background.height == 0)
         {
            this.background.height = this.height + VERTICAL_MARGIN;
         }
         this.panel.x = this.background.width - this.panel.width >> 1;
         this.label.x = this.background.width - this.label.width >> 1;
      }
      
      public function isFull() : Boolean
      {
         var _loc1_:ResistanceButton = null;
         for each(_loc1_ in this.cells)
         {
            if(_loc1_.isFree())
            {
               return false;
            }
         }
         return true;
      }
      
      public function getFreeSlot() : int
      {
         var _loc1_:int = 0;
         while(_loc1_ < SLOTS)
         {
            if(this.cells[_loc1_].isFree())
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function render() : void
      {
         if(parent != null)
         {
            this.panel.render();
         }
      }
      
      public function getIndex(param1:IGameObject) : int
      {
         var _loc2_:ResistanceButton = null;
         if(param1 == null)
         {
            return -1;
         }
         for each(_loc2_ in this.cells)
         {
            if(_loc2_.item == param1)
            {
               return _loc2_.getIndex();
            }
         }
         return -1;
      }
      
      public function setResistInCell(param1:int, param2:IGameObject) : void
      {
         this.cells[param1].item = param2;
         this.cells[param1].setDeviceImageFromItem(param2);
      }
      
      public function setAllResist(param1:IGameObject) : void
      {
         var _loc2_:ResistanceButton = null;
         for each(_loc2_ in this.cells)
         {
            _loc2_.item = param1;
            _loc2_.setDeviceImageFromItem(param1);
         }
      }
      
      public function unequipResist(param1:IGameObject) : void
      {
         var _loc2_:ResistanceButton = null;
         for each(_loc2_ in this.cells)
         {
            if(param1 == _loc2_.item)
            {
               _loc2_.reset();
            }
         }
      }
      
      public function onlyUnmountMode() : *
      {
         var _loc1_:ResistanceButton = null;
         for each(_loc1_ in this.cells)
         {
            if(_loc1_.isFree())
            {
               _loc1_.disable();
            }
         }
      }
      
      public function disable() : void
      {
         var _loc1_:ResistanceButton = null;
         for each(_loc1_ in this.cells)
         {
            _loc1_.disable();
         }
      }
      
      public function enable() : void
      {
         var _loc1_:ResistanceButton = null;
         for each(_loc1_ in this.cells)
         {
            _loc1_.enable();
         }
      }
      
      public function destroy() : void
      {
         resistanceService.unregisterView();
      }
   }
}

