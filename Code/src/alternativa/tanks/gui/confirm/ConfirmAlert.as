package alternativa.tanks.gui.confirm
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.resistance.GarageResistancesIconsUtils;
   import alternativa.tanks.service.item.ItemService;
   import assets.Diamond;
   import assets.icons.IconGarageMod;
   import controls.Money;
   import controls.TankWindow;
   import controls.TankWindowInner;
   import controls.ValidationIcon;
   import controls.base.DefaultButtonBase;
   import controls.base.LabelBase;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
   import utils.preview.IImageResource;
   import utils.preview.ImageResourceLoadingWrapper;
   
   public class ConfirmAlert extends DialogWindow implements IImageResource
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var itemService:ItemService;
      
      private var upgradeIndicator:IconGarageMod;
      
      protected var previewInner:TankWindowInner;
      
      private var confirmButton:DefaultButtonBase;
      
      private var cancelButton:DefaultButtonBase;
      
      protected const WINDOW_MARGIN:int = 11;
      
      protected const SPACE_MODULE:int = 7;
      
      protected const PREVIEW_SIZE:Point = new Point(164,106);
      
      protected const BUTTON_SIZE:Point = new Point(104,33);
      
      protected var windowWidth:int;
      
      protected var nameLabel:LabelBase = new LabelBase();
      
      private var cost:int;
      
      private var previewLoadingIcon:ValidationIcon;
      
      private var previewLoadingWrapper:ImageResourceLoadingWrapper;
      
      private var preview:ImageResource;
      
      private var item:IGameObject;
      
      public function ConfirmAlert(param1:IGameObject, param2:int, param3:int = -1)
      {
         super();
         this.preview = itemService.getPreviewResource(param1);
         this.item = param1;
         var _loc4_:String = this.getItemName(param1);
         var _loc5_:int = int(itemService.getModificationIndex(param1));
         this.windowWidth = Math.max(this.BUTTON_SIZE.x * 2 + this.WINDOW_MARGIN * 2 + this.SPACE_MODULE,this.PREVIEW_SIZE.x + this.WINDOW_MARGIN * 4);
         var _loc6_:TankWindow = new TankWindow(this.windowWidth,this.getWindowHeight());
         addChild(_loc6_);
         this.previewInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
         this.previewInner.x = this.WINDOW_MARGIN;
         this.previewInner.y = this.WINDOW_MARGIN;
         this.previewInner.width = this.windowWidth - this.WINDOW_MARGIN * 2;
         this.previewInner.height = this.PREVIEW_SIZE.y + this.WINDOW_MARGIN * 2;
         addChild(this.previewInner);
         this.loadAndAddPreview();
         if(_loc5_ != -1)
         {
            this.upgradeIndicator = new IconGarageMod();
            addChild(this.upgradeIndicator);
            this.upgradeIndicator.x = this.windowWidth - this.WINDOW_MARGIN - this.SPACE_MODULE - this.upgradeIndicator.width + 2;
            this.upgradeIndicator.y = this.WINDOW_MARGIN + this.SPACE_MODULE - 1;
            this.upgradeIndicator.mod = _loc5_;
         }
         var _loc7_:LabelBase = new LabelBase();
         addChild(_loc7_);
         _loc7_.text = this.getQuestion();
         _loc7_.x = this.windowWidth - _loc7_.width >> 1;
         _loc7_.width = this.windowWidth - this.WINDOW_MARGIN * 2;
         _loc7_.y = this.previewInner.y + this.PREVIEW_SIZE.y + this.WINDOW_MARGIN * 2 + this.SPACE_MODULE;
         addChild(this.nameLabel);
         if(_loc5_ > 0)
         {
            this.nameLabel.text = "\"" + _loc4_ + "\" " + localeService.getText(TanksLocale.TEXT_GARAGE_CONFIRM_ALERT_COST_PREFIX);
         }
         else
         {
            this.nameLabel.text = "\"" + _loc4_ + "\" " + (param3 > 1 ? "(" + param3 + ") " : "") + localeService.getText(TanksLocale.TEXT_GARAGE_CONFIRM_ALERT_COST_PREFIX);
         }
         var _loc8_:Diamond = new Diamond();
         addChild(_loc8_);
         var _loc9_:LabelBase = new LabelBase();
         addChild(_loc9_);
         _loc9_.text = Money.numToString(param2,false);
         var _loc10_:int = this.nameLabel.width + _loc9_.width + _loc8_.width + 2;
         var _loc11_:int = this.windowWidth - _loc10_ >> 1;
         this.nameLabel.x = _loc11_;
         this.nameLabel.y = _loc7_.y + _loc7_.height + this.WINDOW_MARGIN;
         _loc8_.x = this.nameLabel.x + this.nameLabel.width + 2;
         _loc8_.y = this.nameLabel.y + 5;
         _loc9_.x = _loc8_.x + _loc8_.width;
         _loc9_.y = this.nameLabel.y;
         this.cancelButton = new DefaultButtonBase();
         addChild(this.cancelButton);
         this.cancelButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_CONFIRM_ALERT_CANCEL_BUTTON_TEXT);
         this.cancelButton.x = this.windowWidth - this.BUTTON_SIZE.x - 3;
         this.cancelButton.y = this.getWindowHeight() - this.WINDOW_MARGIN - this.BUTTON_SIZE.y + 2;
         this.confirmButton = new DefaultButtonBase();
         addChild(this.confirmButton);
         this.confirmButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_CONFIRM_ALERT_CONFIRM_BUTTON_TEXT);
         this.confirmButton.x = this.WINDOW_MARGIN;
         this.confirmButton.y = this.getWindowHeight() - this.WINDOW_MARGIN - this.BUTTON_SIZE.y + 2;
         this.cancelButton.addEventListener(MouseEvent.CLICK,this.onClickCancel);
         this.confirmButton.addEventListener(MouseEvent.CLICK,this.onClickConfirm);
         dialogService.addDialog(this);
         this.cost = param2;
      }
      
      private function loadAndAddPreview() : void
      {
         if(this.preview.isLoaded)
         {
            this.addPreview(this.preview.data);
         }
         else
         {
            this.addAndStartLoadingIcon();
            this.previewLoadingWrapper = new ImageResourceLoadingWrapper(this);
            this.preview.loadLazyResource(this.previewLoadingWrapper);
         }
      }
      
      private function addAndStartLoadingIcon() : void
      {
         this.previewLoadingIcon = new ValidationIcon();
         addChild(this.previewLoadingIcon);
         this.previewLoadingIcon.x = this.windowWidth - this.previewLoadingIcon.width >> 1;
         this.previewLoadingIcon.y = this.WINDOW_MARGIN + (this.previewInner.height - this.previewLoadingIcon.height >> 1);
         this.previewLoadingIcon.startProgress();
      }
      
      private function addPreview(param1:BitmapData) : void
      {
         var _loc2_:Bitmap = new Bitmap(param1);
         addChild(_loc2_);
         _loc2_.x = this.previewInner.x + (this.previewInner.width - param1.width >> 1);
         _loc2_.y = this.previewInner.y + (this.previewInner.height - param1.height >> 1);
         //if(itemService.getCategory(this.item) == ItemCategoryEnum.RESISTANCE_MODULE)
         //{
         //   GarageResistancesIconsUtils.addIconsToParent(_loc2_,this.item);
         //}
      }
      
      public function setPreviewResource(param1:ImageResource) : void
      {
         this.previewLoadingWrapper = null;
         this.previewLoadingIcon.turnOff();
         this.addPreview(param1.data);
      }
      
      protected function getWindowHeight() : int
      {
         return 240;
      }
      
      protected function getQuestion() : String
      {
         return localeService.getText(TanksLocale.TEXT_GARAGE_CONFIRM_ALERT_BUY_QEUSTION_TEXT);
      }
      
      protected function getItemName(param1:IGameObject) : String
      {
         return itemService.getName(param1);
      }
      
      override protected function cancelKeyPressed() : void
      {
         this.onClickCancel();
      }
      
      private function onClickCancel(param1:MouseEvent = null) : void
      {
         this.hide();
         dispatchEvent(new Event(Event.CANCEL));
      }
      
      private function hide() : void
      {
         if(Boolean(this.previewLoadingWrapper))
         {
            this.preview.removeLazyListener(this.previewLoadingWrapper);
         }
         this.cancelButton.removeEventListener(MouseEvent.CLICK,this.onClickCancel);
         this.confirmButton.removeEventListener(MouseEvent.CLICK,this.onClickConfirm);
         dialogService.removeDialog(this);
      }
      
      override protected function confirmationKeyPressed() : void
      {
         this.onClickConfirm();
      }
      
      private function onClickConfirm(param1:MouseEvent = null) : void
      {
         this.hide();
         dispatchEvent(new ConfirmAlertEvent(this.cost));
      }
   }
}

