package alternativa.tanks.gui
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.buttons.GarageButton;
   import alternativa.tanks.gui.buttons.TimerButton;
   import alternativa.tanks.gui.buttons.TimerButtonEvent;
   import alternativa.tanks.gui.effects.BlinkEffect;
   import alternativa.tanks.gui.effects.GlowEffect;
   import alternativa.tanks.gui.resistance.GarageResistancesIconsUtils;
   import alternativa.tanks.gui.tables.KitInfoTable;
   import alternativa.tanks.gui.upgrade.ItemPropertyUpgradeEvent;
   import alternativa.tanks.gui.upgrade.SelectUpgradeWindow;
   import alternativa.tanks.gui.upgrade.UpgradeButton;
   import alternativa.tanks.gui.upgrade.UpgradeColors;
   import alternativa.tanks.help.DateTimeHelper;
   import alternativa.tanks.model.item.fitting.ItemFitting;
   import alternativa.tanks.model.item.info.ItemActionPanel;
   import alternativa.tanks.model.item.kit.GarageKit;
   import alternativa.tanks.model.item.present.PresentImage;
   import alternativa.tanks.model.item.present.UserPresent;
   import alternativa.tanks.model.item.properties.ItemPropertyValue;
   import alternativa.tanks.model.item.resistance.view.MountedResistancesPanel;
   import alternativa.tanks.model.item.skins.AvailableSkins;
   import alternativa.tanks.model.item.temporary.ITemporaryItem;
   import alternativa.tanks.model.item.upgradable.UpgradableItem;
   import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
   import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
   import alternativa.tanks.service.delaymountcategory.IDelayMountCategoryService;
   import alternativa.tanks.service.item.ItemService;
   import alternativa.tanks.service.item3d.ITank3DViewer;
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParams;
   import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
   import alternativa.tanks.service.money.IMoneyService;
   import alternativa.types.Long;
   import base.DiscreteSprite;
   import controls.Money;
   import controls.NumStepper;
   import controls.TankWindowInner;
   import controls.base.LabelBase;
   import controls.buttons.h50px.GreyBigButton;
   import controls.containers.VerticalStackPanel;
   import controls.timer.CountDownTimer;
   import fl.containers.ScrollPane;
   import fl.controls.ScrollPolicy;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   import forms.ColorConstants;
   import forms.TankWindowWithHeader;
   import platform.client.fp10.core.resource.Resource;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.garage.UserGarageActionsService;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeChildrenFrom;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
   import utils.ScrollStyleUtils;
   import utils.resource.IResourceLoadingComplete;
   import utils.resource.ResourceLoadingWrapper;
   
   public class ItemInfoPanel extends Sprite implements IResourceLoadingComplete
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      [Inject] // added
      public static var userPropertiesService:IUserPropertiesService;
      
      [Inject] // added
      public static var itemService:ItemService;
      
      [Inject] // added
      public static var moneyService:IMoneyService;
      
      [Inject] // added
      public static var propertyService:ItemPropertyParamsService;
      
      [Inject] // added
      public static var dialogService:IDialogsService;
      
      [Inject] // added
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject] // added
      public static var battleInfoService:IBattleInfoService;
      
      [Inject] // added
      public static var delayMountCategoryService:IDelayMountCategoryService;
      
      [Inject] // added
      public static var paymentDisplayService:PaymentDisplayService;
      
      [Inject] // added
      public static var userGarageActionsService:UserGarageActionsService;
      
      [Inject] // added
      public static var tank3dView:ITank3DViewer;
      
      //[Inject]
      //public static var deviceService:DeviceService;
      
      public static const INVENTORY_MAX_VALUE:int = 9999;
      
      private static const TOP_PREVIEW_WITH_NAME_PENETRATION_SIZE:int = 15;
      
      private static const BOTTOM_MARGIN:int = 64;
      
      private static const BUTTON_SIZE:Point = new Point(120,50);
      
      private static const ICON_SPACING_H:int = 10;
      
      private static const HORIZONTAL_MARGIN:int = 12;
      
      private static const VERTICAL_MARGIN:int = 9;
      
      private static const MODULE_SPACING:int = 3;
      
      private static const PREVIEW_OFFSET_X:int = 0;
      
      private static const KIT_INFO_TOP_MARGIN:int = 10;
      
      public const margin:int = 11;
      
      public var size:Point;
      
      public var inventoryNumStepper:NumStepper;
      
      public var buyButton:GarageButton;
      
      public var equipButton:TimerButton;
      
      public var upgradeButton:UpgradeButton;
      
      public var deletePresentButton:GreyBigButton;
      
      private var fittingButton:GreyBigButton;
      
      private var itemNameLabel:LabelBase;
      
      private var descriptionCaptionLabel:LabelBase;
      
      private var itemDescriptionLabel:LabelBase;
      
      private var window:TankWindowWithHeader;
      
      private var inner:TankWindowInner;
      
      private var itemPreview:Bitmap;
      
      private var itemPreviewContainer:DiscreteSprite;
      
      private var kitFullImage:Bitmap;
      
      private var presentFullImage:Bitmap;
      
      private var propertiesParams:Vector.<ItemPropertyParams>;
      
      private var scrollPane:ScrollPane;
      
      private var scrollContainer:VerticalStackPanel;
      
      private var propertiesPanel:Sprite;
      
      private var propertiesPanelLeft:Bitmap;
      
      private var propertiesPanelCenter:Bitmap;
      
      private var propertiesPanelRight:Bitmap;
      
      private var area:Shape;
      
      private var areaRect:Rectangle;
      
      private var areaRect2:Rectangle;
      
      private var timeIndicator:LabelBase;
      
      private var modTable:ModTable;
      
      private var kitInfoTable:KitInfoTable;
      
      private var kitInfoPanel:Sprite;
      
      private var kitInfoPanelTopLeftCorner:Bitmap;
      
      private var kitInfoPanelCenterTopLine:Bitmap;
      
      private var kitInfoPanelTopRightCorner:Bitmap;
      
      private var kitInfoPanelLeftLine:Bitmap;
      
      private var kitInfoPanelRightLine:Bitmap;
      
      private var kitInfoPanelLeftLineSummary:Bitmap;
      
      private var kitInfoPanelRightLineSummary:Bitmap;
      
      private var kitInfoPanelLeftLineCenterSummary:Bitmap;
      
      private var kitInfoPanelRightLineCenterSummary:Bitmap;
      
      private var kitInfoPanelCenterMiddleLine:Bitmap;
      
      private var kitInfoPanelCenterBottomLine:Bitmap;
      
      private var kitInfoPanelLeftCenterLine:Bitmap;
      
      private var kitInfoPanelRightCenterLine:Bitmap;
      
      private var kitInfoPanelBackgroundUp:Shape;
      
      private var kitInfoPanelBackgroundBottom:Shape;
      
      private var isKit:Boolean;
      
      private var kitItemTopPreviewDiscount:LabelBase;
      
      private var item:IGameObject;
      
      private var itemCategory:ItemCategoryEnum;
      
      private var itemPrice:int;
      
      private var isCountable:Boolean = false;
      
      private var maxRankIndex:int;
      
      private var minRankIndex:int;
      
      private var previewLoadingId:Long;
      
      private var kitLoadingId:Long;
      
      private var presentLoadingId:Long;
      
      private var selectWindow:SelectUpgradeWindow;
      
      private var blinkEffects:Dictionary;
      
      private var enabledUpgrades:Boolean;
      
      private var presentInfoPanel:PresentInfoPanel;
      
      private var actionButtonsContainer:DiscreteSprite;
      
      private var oldActionButtonsContainer:DiscreteSprite;
      
      private var devicesAvailable:Boolean = false;
      
      //private var devicesPanel:ItemInfoDevicesPanel;
      
      private var resistPanel:MountedResistancesPanel;
      
      public function ItemInfoPanel(param1:Boolean, param2:int)
      {
         var _loc4_:TextFormat = null;
         this.propertiesParams = new Vector.<ItemPropertyParams>();
         this.blinkEffects = new Dictionary();
         this.actionButtonsContainer = new DiscreteSprite();
         this.oldActionButtonsContainer = new DiscreteSprite();
         super();
         this.enabledUpgrades = param1;
         this.size = new Point(400,300);
         this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_INFORMATION,this.size.x,this.size.y);
         addChild(this.window);
         this.inner = new TankWindowInner(164,106,TankWindowInner.GREEN);
         this.inner.showBlink = true;
         addChild(this.inner);
         this.inner.x = this.margin;
         this.inner.y = this.margin;
         this.area = new Shape();
         this.areaRect = new Rectangle();
         this.areaRect2 = new Rectangle(HORIZONTAL_MARGIN,VERTICAL_MARGIN,0,0);
         this.areaRect.width = param2 - this.margin * 2 - 2;
         this.areaRect2.width = this.areaRect.width - HORIZONTAL_MARGIN * 2;
         this.scrollContainer = new VerticalStackPanel();
         this.scrollContainer.x = this.margin + 1;
         this.scrollContainer.y = this.margin + 1;
         this.scrollContainer.addChild(this.area);
         this.scrollPane = new ScrollPane();
         addChild(this.scrollPane);
         ScrollStyleUtils.setGreenStyle(this.scrollPane);
         this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.scrollPane.verticalScrollPolicy = ScrollPolicy.AUTO;
         this.scrollPane.source = this.scrollContainer;
         this.scrollPane.focusEnabled = false;
         this.scrollPane.x = this.margin + 1;
         this.scrollPane.y = this.margin + 1 + MODULE_SPACING;
         this.itemNameLabel = new LabelBase();
         this.itemNameLabel.text = "A";
         this.itemNameLabel.size = 18;
         this.itemNameLabel.color = ColorConstants.GREEN_TEXT;
         this.scrollContainer.addChild(this.itemNameLabel);
         this.itemNameLabel.x = HORIZONTAL_MARGIN - 3;
         this.itemNameLabel.y = VERTICAL_MARGIN - 7;
         //this.devicesPanel = new ItemInfoDevicesPanel();
         //this.devicesPanel.x = HORIZONTAL_MARGIN;
         //this.scrollContainer.addChild(this.devicesPanel);
         this.descriptionCaptionLabel = new LabelBase();
         this.descriptionCaptionLabel.text = localeService.getText(TanksLocale.TEXT_DESCRIPTION);
         this.descriptionCaptionLabel.size = 18;
         this.descriptionCaptionLabel.color = ColorConstants.GREEN_TEXT;
         this.scrollContainer.addChild(this.descriptionCaptionLabel);
         this.descriptionCaptionLabel.x = HORIZONTAL_MARGIN - 3;
         this.itemDescriptionLabel = new LabelBase();
         var _loc3_:String = localeService.language;
         if(_loc3_ == "cn")
         {
            _loc4_ = this.itemDescriptionLabel.getTextFormat();
            _loc4_.leading = 3;
            this.itemDescriptionLabel.defaultTextFormat = _loc4_;
         }
         this.itemDescriptionLabel.multiline = true;
         this.itemDescriptionLabel.wordWrap = true;
         this.itemDescriptionLabel.color = ColorConstants.GREEN_TEXT;
         this.itemDescriptionLabel.text = "Description";
         this.itemDescriptionLabel.mouseWheelEnabled = false;
         this.scrollContainer.addChild(this.itemDescriptionLabel);
         this.itemDescriptionLabel.x = HORIZONTAL_MARGIN - 3;
         this.itemPreviewContainer = new DiscreteSprite();
         this.scrollContainer.addChild(this.itemPreviewContainer);
         this.presentInfoPanel = new PresentInfoPanel(this.areaRect2.width);
         this.presentInfoPanel.x = 9;
         this.itemPreview = new Bitmap();
         this.kitFullImage = new Bitmap();
         this.presentFullImage = new Bitmap();
         this.buyButton = new GarageButton();
         this.upgradeButton = new UpgradeButton();
         this.upgradeButton.addEventListener(MouseEvent.CLICK,this.onButtonUpgradeClick);
         this.equipButton = new TimerButton();
         this.equipButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_EQUIP_TEXT);
         this.fittingButton = new GreyBigButton();
         this.fittingButton.label = localeService.getText(TanksLocale.TEXT_FITTING_BUTTON_TEXT);
         this.fittingButton.visible = false;
         this.fittingButton.addEventListener(MouseEvent.CLICK,this.onFittingButtonClick);
         addChild(this.oldActionButtonsContainer);
         this.deletePresentButton = new GreyBigButton();
         this.deletePresentButton.label = localeService.getText(TanksLocale.TEXT_DELETE_PRESENT_BUTTON);
         this.deletePresentButton.visible = false;
         this.oldActionButtonsContainer.addChild(this.deletePresentButton);
         this.buyButton.visible = false;
         this.upgradeButton.visible = false;
         this.equipButton.visible = false;
         this.oldActionButtonsContainer.addChild(this.buyButton);
         this.oldActionButtonsContainer.addChild(this.upgradeButton);
         this.oldActionButtonsContainer.addChild(this.equipButton);
         this.oldActionButtonsContainer.addChild(this.fittingButton);
         addChild(this.actionButtonsContainer);
         this.inventoryNumStepper = new NumStepper();
         this.oldActionButtonsContainer.addChild(this.inventoryNumStepper);
         this.inventoryNumStepper.value = 1;
         this.inventoryNumStepper.minValue = 1;
         this.inventoryNumStepper.maxValue = INVENTORY_MAX_VALUE;
         this.inventoryNumStepper.visible = false;
         this.inventoryNumStepper.mouseEnabled = false;
         this.inventoryNumStepper.addEventListener(Event.CHANGE,this.inventoryNumChanged);
         this.propertiesPanel = new Sprite();
         this.propertiesPanelLeft = new Bitmap(ItemInfoPanelBitmaps.propertiesLeft);
         this.propertiesPanel.addChild(this.propertiesPanelLeft);
         this.propertiesPanelCenter = new Bitmap(ItemInfoPanelBitmaps.propertiesCenter);
         this.propertiesPanel.addChild(this.propertiesPanelCenter);
         this.propertiesPanelRight = new Bitmap(ItemInfoPanelBitmaps.propertiesRight);
         this.propertiesPanel.addChild(this.propertiesPanelRight);
         this.propertiesPanelCenter.x = this.propertiesPanelLeft.width;
         this.propertiesPanel.x = HORIZONTAL_MARGIN;
         this.propertiesPanel.y = Math.round(VERTICAL_MARGIN * 2 + this.itemNameLabel.textHeight - 7);
         this.getResistPanel().visible = false;
         addChild(this.getResistPanel());
         this.addKitInfoPanel();
         addEventListener(ItemPropertyUpgradeEvent.SELECT_WINDOW_OPENED,this.openUpgradeWindow);
         this.timeIndicator = new LabelBase();
         this.timeIndicator.size = 18;
         this.timeIndicator.color = ColorConstants.GREEN_TEXT;
         this.modTable = new ModTable(this.areaRect2.width);
         this.modTable.x = HORIZONTAL_MARGIN;
         this.kitItemTopPreviewDiscount = new LabelBase();
         this.kitItemTopPreviewDiscount.color = 16777215;
         this.kitItemTopPreviewDiscount.align = TextFormatAlign.CENTER;
         this.kitItemTopPreviewDiscount.size = 23;
         this.kitItemTopPreviewDiscount.bold = true;
         if(_loc3_ == "cn")
         {
            this.kitItemTopPreviewDiscount.size = 20;
         }
      }
      
      public static function getRequiredRank(param1:int, param2:int) : int
      {
         var _loc3_:int = int(userPropertiesService.rank);
         var _loc4_:int = param1;
         if(_loc3_ < param1)
         {
            _loc4_ = -param1;
         }
         else if(_loc3_ > param2)
         {
            _loc4_ = -param2;
         }
         return _loc4_;
      }
      
      public function getResistPanel() : MountedResistancesPanel
      {
         if(this.resistPanel == null)
         {
            this.resistPanel = new MountedResistancesPanel();
            this.resistPanel.visible = false;
         }
         return this.resistPanel;
      }
      
      private function addKitInfoPanel() : void
      {
         this.kitInfoPanel = new Sprite();
         this.kitInfoPanelTopLeftCorner = new Bitmap(ItemInfoPanelBitmaps.leftTopCornerTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelTopLeftCorner);
         this.kitInfoPanelCenterTopLine = new Bitmap(ItemInfoPanelBitmaps.centerTopTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelCenterTopLine);
         this.kitInfoPanelTopRightCorner = new Bitmap(ItemInfoPanelBitmaps.rightTopCornerTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelTopRightCorner);
         this.kitInfoPanelCenterTopLine.x = this.kitInfoPanelTopLeftCorner.width;
         this.kitInfoPanelLeftLine = new Bitmap(ItemInfoPanelBitmaps.leftLineTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelLeftLine);
         this.kitInfoPanelRightLine = new Bitmap(ItemInfoPanelBitmaps.rightLineTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelRightLine);
         this.kitInfoPanelLeftCenterLine = new Bitmap(ItemInfoPanelBitmaps.leftCenterTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelLeftCenterLine);
         this.kitInfoPanelRightCenterLine = new Bitmap(ItemInfoPanelBitmaps.rightCenterTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelRightCenterLine);
         this.kitInfoPanelCenterMiddleLine = new Bitmap(ItemInfoPanelBitmaps.centerTopTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelCenterMiddleLine);
         this.kitInfoPanelLeftLineSummary = new Bitmap(ItemInfoPanelBitmaps.leftBottomLineTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelLeftLineSummary);
         this.kitInfoPanelRightLineSummary = new Bitmap(ItemInfoPanelBitmaps.rightBottomLineTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelRightLineSummary);
         this.kitInfoPanelCenterBottomLine = new Bitmap(ItemInfoPanelBitmaps.centerBottomLineTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelCenterBottomLine);
         this.kitInfoPanelLeftLineCenterSummary = new Bitmap(ItemInfoPanelBitmaps.leftLineTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelLeftLineCenterSummary);
         this.kitInfoPanelRightLineCenterSummary = new Bitmap(ItemInfoPanelBitmaps.rightLineTableKit);
         this.kitInfoPanel.addChild(this.kitInfoPanelRightLineCenterSummary);
         this.kitInfoPanelBackgroundUp = new Shape();
         this.kitInfoPanel.addChild(this.kitInfoPanelBackgroundUp);
         this.kitInfoPanelBackgroundBottom = new Shape();
         this.kitInfoPanel.addChild(this.kitInfoPanelBackgroundBottom);
         this.kitInfoPanel.x = HORIZONTAL_MARGIN;
         this.kitInfoTable = new KitInfoTable(this.areaRect2.width);
         this.kitInfoTable.x = HORIZONTAL_MARGIN;
      }
      
      public function destroy() : void
      {
         this.window = null;
         this.inner = null;
         this.itemPreviewContainer = null;
         this.itemPreview = null;
         this.kitFullImage = null;
         this.presentFullImage = null;
         this.item = null;
         this.itemNameLabel = null;
         this.itemDescriptionLabel = null;
         if(this.resistPanel != null)
         {
            this.resistPanel.destroy();
            this.resistPanel = null;
         }
         this.scrollPane = null;
         this.scrollContainer = null;
         this.propertiesPanel = null;
         this.propertiesPanelLeft = null;
         this.propertiesPanelCenter = null;
         this.propertiesPanelRight = null;
         this.kitInfoPanel = null;
         this.kitInfoPanelTopLeftCorner = null;
         this.kitInfoPanelCenterTopLine = null;
         this.kitInfoPanelTopRightCorner = null;
         this.kitInfoPanelLeftLine = null;
         this.area = null;
         this.areaRect = null;
         this.areaRect2 = null;
         this.oldActionButtonsContainer = null;
         this.buyButton = null;
         this.fittingButton.removeEventListener(MouseEvent.CLICK,this.onFittingButtonClick);
         this.fittingButton = null;
         if(this.equipButton != null)
         {
            this.equipButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
            this.equipButton.hideTime();
            this.equipButton = null;
         }
         if(this.upgradeButton != null)
         {
            this.upgradeButton.removeEventListener(MouseEvent.CLICK,this.onButtonUpgradeClick);
            this.upgradeButton = null;
         }
         removeEventListener(ItemPropertyUpgradeEvent.SELECT_WINDOW_OPENED,this.openUpgradeWindow);
         //if(this.devicesPanel != null)
         //{
         //   this.devicesPanel.destroy();
         //   this.devicesPanel = null;
         //}
         this.previewLoadingId = null;
         this.stopBlinkEffects();
         this.blinkEffects = null;
         if(Boolean(this.selectWindow))
         {
            this.selectWindow.destroy();
            this.selectWindow = null;
         }
         this.presentInfoPanel.destroy();
         this.presentInfoPanel = null;
         this.actionButtonsContainer = null;
      }
      
      private function onFittingButtonClick(param1:MouseEvent) : void
      {
         ItemFitting(this.item.adapt(ItemFitting)).fit();
         this.fittingButton.enabled = false;
      }
      
      private function stopBlinkEffects() : void
      {
         var _loc1_:BlinkEffect = null;
         for each(_loc1_ in this.blinkEffects)
         {
            _loc1_.stop();
         }
      }
      
      private function hideIcons() : void
      {
         var _loc1_:ItemPropertyParams = null;
         for each(_loc1_ in this.propertiesParams)
         {
            if(this.propertiesPanel.contains(_loc1_.icon))
            {
               this.propertiesPanel.removeChild(_loc1_.icon);
            }
         }
      }
      
      private function showIcons() : void
      {
         var _loc1_:ItemPropertyParams = null;
         for each(_loc1_ in this.propertiesParams)
         {
            if(!this.propertiesPanel.contains(_loc1_.icon))
            {
               this.propertiesPanel.addChild(_loc1_.icon);
            }
         }
      }
      
      public function onLoadingComplete(param1:Resource) : void
      {
         if(this.previewLoadingId == param1.id)
         {
            if(!this.isKit && !itemService.isGivenPresent(this.item))
            {
               this.itemPreview.bitmapData = ImageResource(param1).data;
               this.resize(this.size.x,this.size.y);
            }
         }
         if(this.kitLoadingId == param1.id)
         {
            if(this.isKit)
            {
               this.kitFullImage.bitmapData = ImageResource(param1).data;
               this.showBitmap(this.kitFullImage);
               this.resize(this.size.x,this.size.y);
            }
         }
         if(this.presentLoadingId == param1.id)
         {
            if(itemService.isGivenPresent(this.item))
            {
               this.presentFullImage.bitmapData = ImageResource(param1).data;
               this.showBitmap(this.presentFullImage);
               this.resize(this.size.x,this.size.y);
            }
         }
      }
      
      public function showItemInfo(param1:IGameObject, param2:Boolean) : void
      {
         var _loc4_:UserPresent = null;
         this.itemCategory = itemService.getCategory(param1);
         this.itemPrice = itemService.getPrice(param1);
         this.isCountable = itemService.isCountable(param1);
         //this.devicesAvailable = !param2 && (Boolean(deviceService.isDevicesAvailable(param1)) || Boolean(param1.hasModel(AvailableSkins)) && AvailableSkins(param1.adapt(AvailableSkins)).getSkins().length > 0);
         //if(this.devicesAvailable)
         //{
         //   this.devicesPanel.init(param1);
         //}
         if(!param2 && !itemService.isGivenPresent(param1))
         {
            this.updateUpgradeButton(param1);
         }
         removeChildrenFrom(this.itemPreviewContainer);
         removeChildrenFrom(this.actionButtonsContainer);
         this.updateFittingButton(param2,this.item,param1);
         if(this.item != param1)
         {
            tank3dView.closePreview();
            this.item = param1;
         }
         this.itemNameLabel.text = itemService.getName(param1);
         this.itemDescriptionLabel.visible = !itemService.isGivenPresent(param1);
         this.descriptionCaptionLabel.visible = this.devicesAvailable && Boolean(this.itemDescriptionLabel.visible);
         if(this.itemDescriptionLabel.visible)
         {
            this.itemDescriptionLabel.htmlText = itemService.getDescription(param1);
         }
         this.loadAndSetupImageResources(param1);
         this.maxRankIndex = itemService.getMaxRankIndex(param1);
         this.minRankIndex = itemService.getMinRankIndex(param1);
         this.hideIcons();
         if(itemService.isGivenPresent(param1))
         {
            _loc4_ = UserPresent(param1.adapt(UserPresent));
            this.presentInfoPanel.update(_loc4_.getPresenterId(),_loc4_.getDate(),_loc4_.getText());
            this.itemPreviewContainer.addChild(this.presentInfoPanel);
         }
         else
         {
            this.presentInfoPanel.destroyPresenterLabel();
         }
         if(itemService.isKit(param1))
         {
            this.isKit = true;
            this.showKitInfoTable(param1);
         }
         else
         {
            this.isKit = false;
            this.hideKitInfoTable();
            if(this.scrollContainer.contains(this.kitItemTopPreviewDiscount))
            {
               this.scrollContainer.removeChild(this.kitItemTopPreviewDiscount);
            }
         }
         var _loc3_:Vector.<IGameObject> = itemService.isModificationItem(param1) ? itemService.getModifications(param1) : null;
         this.showItemProperties(param1,param2,_loc3_);
         this.setButtonsVisibility(param1,param2,_loc3_);
         this.updateStepperAndBuyButton(param1,param2);
         this.updateBlinkEffect();
         this.setButtonsPosition();
         this.updateEquipButton();
         this.setupRemainingTimer(param1,param2);
         if(!(this.oldActionButtonsContainer.visible = !param1.hasModel(ItemActionPanel)))
         {
            ItemActionPanel(param1.event(ItemActionPanel)).updateActionElements(this.actionButtonsContainer,this);
         }
      }
      
      private function showEquippedPanel(param1:TankWindowInner) : Number
      {
         //var _loc2_:MountedResistancesPanel = this.getResistPanel();
         //_loc2_.visible = this.itemCategory == ItemCategoryEnum.RESISTANCE_MODULE;
         //if(_loc2_.visible)
         //{
         //   param1.height -= _loc2_.height + VERTICAL_MARGIN / 2;
         //   _loc2_.resize(param1.width);
         //}
         return param1.height;
      }
      
      private function loadAndSetupImageResources(param1:IGameObject) : void
      {
         var _loc2_:ImageResource = null;
         var _loc3_:ImageResource = null;
         var _loc4_:ImageResource = null;
         this.kitFullImage.bitmapData = null;
         this.presentFullImage.bitmapData = null;
         this.itemPreview.bitmapData = null;
         if(itemService.isKit(param1))
         {
            _loc2_ = GarageKit(param1.adapt(GarageKit)).getImage();
            this.kitLoadingId = _loc2_.id;
            if(Boolean(_loc2_.isLazy) && !_loc2_.isLoaded)
            {
               _loc2_.loadLazyResource(new ResourceLoadingWrapper(this));
            }
            this.kitFullImage.bitmapData = _loc2_.data;
            if(this.kitFullImage.bitmapData != null)
            {
               this.showBitmap(this.kitFullImage);
            }
            else
            {
               removeDisplayObject(this.kitFullImage);
            }
         }
         else if(itemService.isGivenPresent(param1))
         {
            _loc3_ = PresentImage(param1.adapt(PresentImage)).getImage();
            this.presentLoadingId = _loc3_.id;
            if(Boolean(_loc3_.isLazy) && !_loc3_.isLoaded)
            {
               _loc3_.loadLazyResource(new ResourceLoadingWrapper(this));
            }
            this.presentFullImage.bitmapData = _loc3_.data;
            if(this.presentFullImage.bitmapData != null)
            {
               this.showBitmap(this.presentFullImage);
            }
            else
            {
               removeDisplayObject(this.presentFullImage);
            }
         }
         else
         {
            _loc4_ = itemService.getPreviewResource(param1);
            this.previewLoadingId = _loc4_.id;
            if(Boolean(_loc4_.isLazy) && !_loc4_.isLoaded)
            {
               _loc4_.loadLazyResource(new ResourceLoadingWrapper(this));
            }
            this.itemPreview.bitmapData = _loc4_.data;
         }
      }
      
      private function setupRemainingTimer(param1:IGameObject, param2:Boolean) : void
      {
         if(!param2 && Boolean(param1.hasModel(ITemporaryItem)))
         {
            if(!this.scrollContainer.contains(this.timeIndicator))
            {
               this.scrollContainer.addChild(this.timeIndicator);
            }
            this.setTimeRemaining(param1);
         }
         else if(this.scrollContainer.contains(this.timeIndicator))
         {
            this.scrollContainer.removeChild(this.timeIndicator);
         }
      }
      
      private function updateStepperAndBuyButton(param1:IGameObject, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:IGameObject = null;
         var _loc8_:int = 0;
         if(this.buyButton.visible)
         {
            _loc3_ = getRequiredRank(itemService.getMinRankIndex(param1),itemService.getMaxRankIndex(param1));
            _loc4_ = 1;
            if(this.isCountable)
            {
               this.inventoryNumStepper.visible = true;
               _loc6_ = Math.min(INVENTORY_MAX_VALUE,Math.floor(moneyService.crystal / this.itemPrice));
               if(_loc3_ > 0)
               {
                  if(_loc6_ > 0)
                  {
                     this.inventoryNumStepper.enabled = true;
                     this.inventoryNumStepper.alpha = 1;
                  }
                  else
                  {
                     this.inventoryNumStepper.enabled = false;
                     this.inventoryNumStepper.alpha = 0.7;
                  }
               }
               else
               {
                  this.inventoryNumStepper.enabled = false;
                  this.inventoryNumStepper.alpha = 0.7;
                  this.inventoryNumStepper.value = 1;
               }
               _loc5_ = int(itemService.getPrice(param1));
               _loc4_ = int(this.inventoryNumStepper.value);
            }
            else if(!param2 && Boolean(itemService.isModificationItem(param1)))
            {
               this.inventoryNumStepper.visible = false;
               this.inventoryNumStepper.enabled = false;
               _loc7_ = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
               _loc5_ = int(itemService.getPrice(_loc7_));
               _loc8_ = int(itemService.getMinRankIndex(_loc7_));
               _loc3_ = userPropertiesService.rank >= _loc8_ ? _loc8_ : int(-_loc8_);
            }
            else
            {
               _loc5_ = int(itemService.getPrice(param1));
               this.inventoryNumStepper.visible = false;
               this.inventoryNumStepper.enabled = false;
            }
            this.updateBuyButtonText(param1,param2);
            this.buyButton.setInfo(_loc5_,_loc4_,_loc3_,itemService.isPremiumItem(param1));
         }
         else
         {
            this.inventoryNumStepper.visible = false;
         }
      }
      
      private function setButtonsVisibility(param1:IGameObject, param2:Boolean, param3:Vector.<IGameObject>) : void
      {
         if(itemService.isGivenPresent(param1))
         {
            this.deletePresentButton.visible = true;
            this.buyButton.visible = false;
            this.equipButton.visible = false;
         }
         else
         {
            this.deletePresentButton.visible = false;
            if(param2)
            {
               this.buyButton.visible = true;
               this.equipButton.visible = false;
            }
            else if(this.itemCategory == ItemCategoryEnum.INVENTORY)
            {
               this.buyButton.visible = true;
               this.equipButton.visible = false;
            }
            else
            {
               this.buyButton.visible = false;
               if(this.itemCategory == ItemCategoryEnum.PLUGIN || this.itemCategory == ItemCategoryEnum.EMBLEM)
               {
                  this.equipButton.visible = false;
               }
               else
               {
                  this.equipButton.visible = true;
                  if(itemService.isModificationItem(param1))
                  {
                     this.buyButton.visible = itemService.getModificationIndex(param1) < 3 && param3.length > 1;
                  }
               }
            }
         }
         //this.devicesPanel.visible = this.devicesAvailable;
      }
      
      private function showItemProperties(param1:IGameObject, param2:Boolean, param3:Vector.<IGameObject>) : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:ItemPropertyValue = null;
         var _loc9_:ItemPropertyParams = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:IGameObject = null;
         var _loc13_:ModInfoRow = null;
         var _loc14_:UpgradableItemParams = null;
         var _loc15_:Vector.<UpgradableItemPropertyValue> = null;
         var _loc4_:Boolean = !itemService.isModificationItem(param1);
         var _loc5_:Vector.<ItemPropertyValue> = itemService.getPropertiesForInfoWindow(param1);
         if(_loc5_ != null && _loc5_.length > 0)
         {
            this.propertiesParams.length = _loc5_.length;
            _loc6_ = Boolean(itemService.isUpgradableItem(param1)) && itemService.getUpgradableItemParams(param1).getLevelsCount() > 0;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc8_ = _loc5_[_loc7_];
               _loc9_ = propertyService.getParams(_loc8_.getProperty());
               this.propertiesParams[_loc7_] = _loc9_;
               if(_loc4_)
               {
                  _loc10_ = UpgradeColors.getColorForItem(param1,_loc8_);
                  _loc9_.icon.setValue(itemService.getCurrentValue(param1,_loc8_),_loc10_);
               }
               else
               {
                  _loc9_.icon.removeValue();
               }
               _loc7_++;
            }
            this.upgradeButton.visible = this.enabledUpgrades && !param2 && _loc6_;
            this.showIcons();
            if(!this.scrollContainer.contains(this.propertiesPanel))
            {
               this.scrollContainer.addChild(this.propertiesPanel);
            }
         }
         else
         {
            this.upgradeButton.visible = false;
            this.propertiesParams.length = 0;
            if(this.scrollContainer.contains(this.propertiesPanel))
            {
               this.scrollContainer.removeChild(this.propertiesPanel);
            }
         }
         if(itemService.isModificationItem(param1))
         {
            this.propertiesPanelLeft.bitmapData = ItemInfoPanelBitmaps.upgradeTableLeft;
            this.propertiesPanelCenter.bitmapData = ItemInfoPanelBitmaps.upgradeTableCenter;
            this.propertiesPanelRight.bitmapData = ItemInfoPanelBitmaps.upgradeTableRight;
            this.showModTable();
            if(param2)
            {
               this.modTable.resetSelection();
            }
            else
            {
               this.modTable.select(itemService.getModificationIndex(param1));
            }
            _loc11_ = 0;
            while(_loc11_ < this.modTable.rows.length)
            {
               _loc13_ = ModInfoRow(this.modTable.rows[_loc11_]);
               _loc13_.visible = param3.length != 1 || _loc11_ == 0;
               _loc11_++;
            }
            _loc11_ = 0;
            while(_loc11_ < param3.length)
            {
               _loc12_ = param3[_loc11_];
               _loc13_ = ModInfoRow(this.modTable.rows[_loc11_]);
               _loc13_.upgradeIndicator.visible = param3.length != 1;
               _loc13_.costLabel.text = Money.numToString(itemService.getPriceWithoutDiscount(_loc12_),false);
               this.modTable.maxCostWidth = _loc13_.costLabel.width;
               _loc13_.rankIcon.setDefaultAccount(itemService.getMinRankIndex(_loc12_));
               _loc14_ = itemService.getUpgradableItemParams(_loc12_);
               _loc15_ = _loc14_.visibleProperties;
               _loc13_.setLabelsNum(_loc5_.length);
               _loc13_.setLabelsText(_loc14_,_loc15_);
               _loc11_++;
            }
            this.modTable.correctNonintegralValues();
         }
         else
         {
            this.propertiesPanelLeft.bitmapData = ItemInfoPanelBitmaps.propertiesLeft;
            this.propertiesPanelCenter.bitmapData = ItemInfoPanelBitmaps.propertiesCenter;
            this.propertiesPanelRight.bitmapData = ItemInfoPanelBitmaps.propertiesRight;
            this.hideModTable();
         }
      }
      
      private function updateBuyButtonText(param1:IGameObject, param2:Boolean) : void
      {
         var _loc4_:IGameObject = null;
         var _loc3_:String = localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_BUY_TEXT);
         if(itemService.isModificationItem(param1))
         {
            if(param2)
            {
               _loc4_ = itemService.getMaxAvailableModification(param1);
               if(_loc4_ == null)
               {
                  _loc4_ = param1;
               }
            }
            else
            {
               _loc4_ = itemService.getMaxAvailableOrNextNotAvailableModification(param1);
            }
            this.buyButton.setText(_loc3_ + " M" + itemService.getModificationIndex(_loc4_));
         }
         else
         {
            this.buyButton.setText(_loc3_);
         }
      }
      
      private function showKitInfoTable(param1:IGameObject) : void
      {
         if(!this.scrollContainer.contains(this.kitInfoPanel))
         {
            this.scrollContainer.addChild(this.kitInfoPanel);
         }
         if(!this.scrollContainer.contains(this.kitInfoTable))
         {
            this.scrollContainer.addChild(this.kitInfoTable);
         }
         this.kitInfoTable.show(param1);
      }
      
      private function hideKitInfoTable() : void
      {
         if(this.scrollContainer.contains(this.kitInfoPanel))
         {
            this.scrollContainer.removeChild(this.kitInfoPanel);
         }
         if(this.scrollContainer.contains(this.kitInfoTable))
         {
            this.scrollContainer.removeChild(this.kitInfoTable);
         }
      }
      
      public function updateEquipButton() : void
      {
         this.updateLabelEquipButton();
         if(Boolean(lobbyLayoutService.inBattle()) && !battleInfoService.reArmorEnabled && itemService.getCategory(this.item) != ItemCategoryEnum.COLOR)
         {
            this.equipButton.enabled = false;
            return;
         }
         if(this.itemCouldBeMounted())
         {
            this.controlTimerEquipButton();
         }
         else
         {
            this.equipButton.enabled = false;
            this.equipButton.hideTime();
         }
      }
      
      private function updateLabelEquipButton() : void
      {
         if(this.itemCouldBeMounted())
         {
            this.equipButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_INFO_PANEL_BUTTON_EQUIP_TEXT);
         }
         else
         {
            this.equipButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_EQUIPPED_TEXT);
         }
      }
      
      private function itemCouldBeMounted() : Boolean
      {
         return Boolean(itemService.isMountable(this.item)) && Boolean(itemService.hasItem(this.item)) && !itemService.isMounted(this.item);
      }
      
      private function updateFittingButton(param1:Boolean, param2:IGameObject, param3:IGameObject) : void
      {
         if(param1 && itemService.getCategory(param3) == ItemCategoryEnum.COLOR && !battleInfoService.isInBattle())
         {
            this.fittingButton.visible = true;
            if(param2 != param3)
            {
               this.fittingButton.enabled = true;
            }
         }
         else
         {
            this.fittingButton.visible = false;
         }
      }
      
      private function controlTimerEquipButton() : void
      {
         var _loc1_:CountDownTimer = delayMountCategoryService.getDownTimer(this.item);
         if(itemService.getCategory(this.item) != ItemCategoryEnum.COLOR && Boolean(lobbyLayoutService.inBattle()) && _loc1_.getRemainingSeconds() > 0 && !itemService.isMounted(this.item))
         {
            this.equipButton.startTimer(_loc1_);
            this.equipButton.addEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
         }
         else
         {
            this.equipButton.hideTime();
            this.equipButton.enabled = true;
         }
      }
      
      private function onCompletedTimer(param1:TimerButtonEvent) : void
      {
         this.equipButton.enabled = true;
         this.equipButton.removeEventListener(TimerButtonEvent.TIME_ON_COMPLETE_TIMER_BUTTON,this.onCompletedTimer);
      }
      
      public function upgradeSelectedItem() : void
      {
         userGarageActionsService.upgradeItem(this.item);
         dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.SELECT_WINDOW_OPENED));
      }
      
      private function openUpgradeWindow(param1:ItemPropertyUpgradeEvent) : *
      {
         var _loc2_:UpgradableItemParams = itemService.getUpgradableItemParams(this.item);
         this.showSelectUpgradeWindow(_loc2_);
      }
      
      private function onButtonUpgradeClick(param1:MouseEvent) : void
      {
         this.upgradeSelectedItem();
      }
      
      public function onMountItem() : void
      {
         if(this.item == null)
         {
            return;
         }
         if(!this.oldActionButtonsContainer.visible)
         {
            ItemActionPanel(this.item.event(ItemActionPanel)).updateActionElements(this.actionButtonsContainer,this);
         }
         else
         {
            this.updateEquipButton();
         }
      }
      
      private function showSelectUpgradeWindow(param1:UpgradableItemParams) : void
      {
         this.selectWindow = new SelectUpgradeWindow(param1);
         this.selectWindow.addEventListener(ItemPropertyUpgradeEvent.SELECT_WINDOW_CLOSED,this.onSelectWindowClosed);
         this.selectWindow.addEventListener(ItemPropertyUpgradeEvent.SPEED_UP,this.onSpeedUp);
         this.selectWindow.addEventListener(ItemPropertyUpgradeEvent.UPGRADE_STARTED,this.onUpgradeStarted);
         this.selectWindow.addEventListener(ItemPropertyUpgradeEvent.FLUSH_UPGRADES,this.onFlushUpgrades);
         this.selectWindow.openDialog();
      }
      
      private function onSelectWindowClosed(param1:Event) : void
      {
         this.selectWindow.removeEventListener(ItemPropertyUpgradeEvent.SELECT_WINDOW_CLOSED,this.onSelectWindowClosed);
         this.selectWindow.removeEventListener(ItemPropertyUpgradeEvent.SPEED_UP,this.onSpeedUp);
         this.selectWindow.removeEventListener(ItemPropertyUpgradeEvent.UPGRADE_STARTED,this.onUpgradeStarted);
         this.selectWindow.removeEventListener(ItemPropertyUpgradeEvent.FLUSH_UPGRADES,this.onFlushUpgrades);
         dialogService.removeDialog(this.selectWindow);
         this.selectWindow = null;
         this.updateEquipButton();
      }
      
      private function updateUpgradeButton(param1:IGameObject) : void
      {
         var _loc2_:UpgradableItem = null;
         if(param1.hasModel(UpgradableItem))
         {
            _loc2_ = UpgradableItem(param1.adapt(UpgradableItem));
            //if(_loc2_.isUpgrading())
            //{
            //   this.upgradeButton.setUpgradingButton(_loc2_.getCountDownTimer(),_loc2_.hasSpeedUpDiscount());
            //}
            //else if(itemService.isFullUpgraded(param1))
            //{
            //   this.upgradeButton.setUpgradedButton();
            //}
            //else
            //{
            //   this.upgradeButton.setUpgradeButton(_loc2_.hasUpgradeDiscount());
            //}
         }
      }
      
      private function onFlushUpgrades(param1:ItemPropertyUpgradeEvent) : void
      {
         dispatchEvent(new ItemPropertyUpgradeEvent(param1.type));
      }
      
      private function onSpeedUp(param1:ItemPropertyUpgradeEvent) : void
      {
         var _loc2_:UpgradableItem = UpgradableItem(this.item.adapt(UpgradableItem));
         dispatchEvent(new ItemPropertyUpgradeEvent(param1.type,_loc2_.getCountDownTimer(),param1.getPrice()));
      }
      
      private function onUpgradeStarted(param1:ItemPropertyUpgradeEvent) : void
      {
         var _loc2_:UpgradableItem = UpgradableItem(this.item.adapt(UpgradableItem));
         this.upgradeButton.setUpgradingButton(param1.getTimer(),_loc2_.hasSpeedUpDiscount());
         dispatchEvent(new ItemPropertyUpgradeEvent(param1.type,param1.getTimer(),param1.getPrice()));
         this.startBlinkEffects();
         if(!this.oldActionButtonsContainer.visible)
         {
            this.item.event(ItemActionPanel).updateActionElements(this.actionButtonsContainer,this);
         }
      }
      
      private function setButtonsPosition() : void
      {
         var _loc1_:int = int(this.actionButtonsContainer.y);
         if(this.buyButton.visible)
         {
            this.buyButton.y = _loc1_;
            if(this.isCountable)
            {
               this.inventoryNumStepper.x = -7;
               this.inventoryNumStepper.y = this.buyButton.y + (BUTTON_SIZE.y - this.inventoryNumStepper.height >> 1);
               this.buyButton.x = this.inventoryNumStepper.x + this.inventoryNumStepper.width + 10;
            }
            else
            {
               this.buyButton.x = this.margin;
            }
         }
         if(this.equipButton.visible)
         {
            this.equipButton.y = _loc1_;
            this.equipButton.x = this.size.x - this.margin - BUTTON_SIZE.x;
         }
         if(this.fittingButton.visible)
         {
            this.fittingButton.y = _loc1_;
            this.fittingButton.x = this.size.x - this.margin - BUTTON_SIZE.x;
         }
         this.upgradeButton.y = _loc1_;
         this.upgradeButton.x = this.margin + BUTTON_SIZE.x + 15;
         this.deletePresentButton.x = this.margin;
         this.deletePresentButton.y = _loc1_;
         this.equipButton.y = this.actionButtonsContainer.y;
         this.fittingButton.y = this.actionButtonsContainer.y;
         this.upgradeButton.y = this.actionButtonsContainer.y;
         this.buyButton.y = this.actionButtonsContainer.y;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:ItemPropertyIcon = null;
         var _loc15_:ModInfoRow = null;
         var _loc16_:Vector.<Number> = null;
         var _loc17_:BitmapData = null;
         this.scrollPane.update();
         this.size.x = param1;
         this.size.y = param2;
         this.window.width = param1;
         this.window.height = param2;
         this.inner.width = param1 - this.margin * 2;
         this.inner.height = param2 - this.margin - BOTTOM_MARGIN;
         this.areaRect.width = param1 - this.margin * 2 - 2;
         this.areaRect2.width = this.areaRect.width - HORIZONTAL_MARGIN * 2;
         this.itemDescriptionLabel.x = HORIZONTAL_MARGIN - 3;
         this.itemDescriptionLabel.width = this.areaRect2.width;
         var _loc4_:int = int(this.propertiesParams.length);
         if(_loc4_ > 0)
         {
            _loc3_ = this.propertiesPanel.y + this.propertiesPanel.height + VERTICAL_MARGIN;
            this.propertiesPanelRight.x = this.areaRect2.width - this.propertiesPanelRight.width;
            this.propertiesPanelCenter.width = this.propertiesPanelRight.x - this.propertiesPanelCenter.x;
            _loc9_ = 6;
            _loc10_ = ItemInfoPanelBitmaps.armor.width * _loc4_ + ICON_SPACING_H * (_loc4_ - 1);
            _loc11_ = _loc10_;
            if(this.scrollContainer.contains(this.modTable))
            {
               _loc11_ += this.modTable.constWidth;
            }
            _loc12_ = this.propertiesPanel.width - _loc11_ >> 1;
            if(!itemService.isModificationItem(this.item))
            {
               _loc13_ = 0;
               while(_loc13_ < _loc4_)
               {
                  _loc14_ = this.propertiesParams[_loc13_].icon;
                  _loc14_.x = _loc12_ + _loc13_ * (ItemInfoPanelBitmaps.armor.width + ICON_SPACING_H);
                  _loc14_.y = _loc9_;
                  _loc13_++;
               }
            }
            else
            {
               for each(_loc15_ in this.modTable.rows)
               {
                  _loc15_.updatePositions();
               }
               _loc16_ = _loc15_.getPositions();
               _loc13_ = 0;
               while(_loc13_ < _loc16_.length)
               {
                  _loc14_ = this.propertiesParams[_loc13_].icon;
                  _loc14_.x = _loc16_[_loc13_] - _loc14_.width / 2;
                  _loc14_.y = _loc9_;
                  _loc13_++;
               }
               this.modTable.y = this.propertiesPanel.y + _loc14_.height + 2;
            }
            this.itemDescriptionLabel.y = this.propertiesPanel.y + this.propertiesPanel.height + VERTICAL_MARGIN - 4;
         }
         else
         {
            this.itemDescriptionLabel.y = this.areaRect2.y + 24 - 7;
         }
         if(this.devicesAvailable)
         {
            //this.devicesPanel.y = this.itemDescriptionLabel.y;
            //this.itemDescriptionLabel.y += this.devicesPanel.height + 5;
            if(this.descriptionCaptionLabel.visible)
            {
               this.descriptionCaptionLabel.y = this.itemDescriptionLabel.y;
               this.itemDescriptionLabel.y += this.descriptionCaptionLabel.height + 5;
            }
         }
         if(this.kitFullImage.bitmapData != null)
         {
            this.kitFullImage.y = this.itemNameLabel.y + this.itemNameLabel.height + VERTICAL_MARGIN - TOP_PREVIEW_WITH_NAME_PENETRATION_SIZE;
            this.kitFullImage.x = this.scrollContainer.width - this.kitFullImage.width >> 1;
            this.itemDescriptionLabel.y += this.kitFullImage.bitmapData.height + VERTICAL_MARGIN - TOP_PREVIEW_WITH_NAME_PENETRATION_SIZE;
         }
         if(this.presentFullImage.bitmapData != null)
         {
            this.presentFullImage.y = this.itemNameLabel.y + this.itemNameLabel.height + VERTICAL_MARGIN - TOP_PREVIEW_WITH_NAME_PENETRATION_SIZE;
            this.presentFullImage.x = this.scrollContainer.width - this.presentFullImage.width >> 1;
            this.itemDescriptionLabel.y += this.presentFullImage.bitmapData.height + VERTICAL_MARGIN - TOP_PREVIEW_WITH_NAME_PENETRATION_SIZE;
         }
         _loc3_ += VERTICAL_MARGIN + this.itemDescriptionLabel.textHeight - 4;
         var _loc5_:int = _loc3_;
         var _loc6_:Boolean = this.itemPreview.bitmapData != null;
         if(_loc6_)
         {
            this.itemPreview.x = this.margin;
            this.itemPreview.y = this.itemDescriptionLabel.y;
            this.itemDescriptionLabel.x = this.itemPreview.x + this.itemPreview.width + 5;
            this.itemDescriptionLabel.width = this.areaRect2.width - this.itemDescriptionLabel.x + this.margin;
            _loc3_ = Math.max(this.itemDescriptionLabel.y + 3 + this.itemDescriptionLabel.textHeight + VERTICAL_MARGIN,this.itemPreview.y + this.itemPreview.height + VERTICAL_MARGIN);
         }
         else
         {
            _loc3_ = this.itemDescriptionLabel.y + 3 + this.itemDescriptionLabel.textHeight + VERTICAL_MARGIN;
         }
         var _loc7_:* = this.showEquippedPanel(this.inner) - 2 - MODULE_SPACING * 2;
         var _loc8_:int = Math.max(_loc3_,_loc7_);
         this.areaRect.height = _loc8_;
         this.areaRect2.height = this.area.height - VERTICAL_MARGIN * 2;
         if(_loc8_ > param2 - this.margin - BOTTOM_MARGIN - 2 - MODULE_SPACING * 2)
         {
            _loc6_ = false;
            this.itemDescriptionLabel.x = HORIZONTAL_MARGIN - 3;
            this.itemDescriptionLabel.width = this.areaRect2.width;
            _loc3_ = _loc5_;
            _loc8_ = Math.max(_loc3_,_loc7_);
            this.areaRect.height = _loc8_;
            this.areaRect2.height = this.inner.height - VERTICAL_MARGIN * 2;
         }
         if(this.isKit)
         {
            this.updateKitPreview(this.kitFullImage);
            this.kitInfoPanel.y = this.kitFullImage.bitmapData != null && Boolean(this.scrollContainer.contains(this.kitFullImage)) ? int(this.kitFullImage.height + this.itemNameLabel.height + KIT_INFO_TOP_MARGIN * 2) : int(this.itemNameLabel.height) + KIT_INFO_TOP_MARGIN;
            this.kitInfoTable.y = this.kitInfoPanel.y;
            this.itemDescriptionLabel.y = this.kitInfoPanel.y + this.kitInfoTable.getFullTableHeight() + 10;
            this.kitInfoPanelTopRightCorner.x = this.areaRect2.width - this.kitInfoPanelTopRightCorner.width;
            this.kitInfoPanelCenterTopLine.width = this.kitInfoPanelTopRightCorner.x - this.kitInfoPanelCenterTopLine.x;
            this.kitInfoPanelLeftLine.y = this.kitInfoPanelTopLeftCorner.height;
            this.kitInfoPanelLeftLine.height = this.kitInfoTable.getTopPartTableHeight();
            this.kitInfoPanelRightLine.y = this.kitInfoPanelTopRightCorner.height;
            this.kitInfoPanelRightLine.height = this.kitInfoPanelLeftLine.height;
            this.kitInfoPanelRightLine.x = this.areaRect2.width - this.kitInfoPanelRightLine.width;
            this.kitInfoPanelLeftCenterLine.y = this.kitInfoPanelLeftLine.height + this.kitInfoPanelTopLeftCorner.height;
            this.kitInfoPanelRightCenterLine.y = this.kitInfoPanelLeftCenterLine.y;
            this.kitInfoPanelRightCenterLine.x = this.kitInfoPanelRightLine.x;
            this.kitInfoPanelCenterMiddleLine.x = this.kitInfoPanelLeftCenterLine.width;
            this.kitInfoPanelCenterMiddleLine.y = this.kitInfoPanelRightCenterLine.y;
            this.kitInfoPanelCenterMiddleLine.width = this.kitInfoPanelRightCenterLine.x - this.kitInfoPanelCenterMiddleLine.x;
            this.kitInfoPanelLeftLineCenterSummary.y = this.kitInfoPanelCenterMiddleLine.y + this.kitInfoPanelCenterMiddleLine.height;
            this.kitInfoPanelLeftLineCenterSummary.height = this.kitInfoTable.getBottomPartTableHeight();
            this.kitInfoPanelRightLineCenterSummary.y = this.kitInfoPanelLeftLineCenterSummary.y;
            this.kitInfoPanelRightLineCenterSummary.height = this.kitInfoPanelLeftLineCenterSummary.height;
            this.kitInfoPanelRightLineCenterSummary.x = this.kitInfoPanelRightLine.x;
            this.kitInfoPanelLeftLineSummary.y = this.kitInfoPanelLeftLineCenterSummary.y + this.kitInfoPanelLeftLineCenterSummary.height;
            this.kitInfoPanelRightLineSummary.y = this.kitInfoPanelLeftLineSummary.y;
            this.kitInfoPanelRightLineSummary.x = this.kitInfoPanelRightCenterLine.x;
            this.kitInfoPanelCenterBottomLine.y = this.kitInfoPanelLeftLineSummary.y + this.kitInfoPanelLeftLineSummary.height - this.kitInfoPanelCenterBottomLine.height;
            this.kitInfoPanelCenterBottomLine.x = this.kitInfoPanelLeftLineSummary.width;
            this.kitInfoPanelCenterBottomLine.width = this.kitInfoPanelCenterTopLine.width;
            _loc17_ = ItemInfoPanelBitmaps.backgroundPixelTableKit;
            this.kitInfoPanelBackgroundUp.graphics.clear();
            this.kitInfoPanelBackgroundUp.graphics.beginBitmapFill(_loc17_);
            this.kitInfoPanelBackgroundUp.graphics.drawRect(this.kitInfoPanelTopLeftCorner.width,this.kitInfoPanelTopLeftCorner.height,this.kitInfoPanelCenterTopLine.width,this.kitInfoPanelLeftLine.height);
            this.kitInfoPanelBackgroundBottom.graphics.clear();
            this.kitInfoPanelBackgroundBottom.graphics.beginBitmapFill(_loc17_);
            this.kitInfoPanelBackgroundBottom.graphics.drawRect(this.kitInfoPanelLeftCenterLine.width,this.kitInfoPanelLeftCenterLine.y + this.kitInfoPanelLeftCenterLine.height,this.kitInfoPanelCenterBottomLine.width,this.kitInfoPanelLeftLineCenterSummary.height);
         }
         if(Boolean(this.item) && Boolean(itemService.isGivenPresent(this.item)))
         {
            this.presentInfoPanel.y = this.presentFullImage.bitmapData != null && Boolean(this.scrollContainer.contains(this.presentFullImage)) ? this.presentFullImage.height + this.itemNameLabel.height + 20 : this.itemNameLabel.height + 10;
            this.presentInfoPanel.setMessageWidth(this.areaRect2.width);
         }
         this.area.graphics.clear();
         this.area.graphics.beginFill(16711680,0);
         this.area.graphics.drawRect(this.areaRect.x,this.areaRect.y,this.areaRect.width,this.areaRect.height);
         if(_loc6_)
         {
            if(this.item != null && this.itemPreview != null && this.itemPreview.parent == null)
            {
               this.showBitmap(this.itemPreview);
               GarageResistancesIconsUtils.addIconsToParent(this.itemPreview,this.item);
            }
         }
         else
         {
            removeDisplayObject(this.itemPreview);
         }
         this.actionButtonsContainer.y = this.size.y - this.margin - BUTTON_SIZE.y + 1;
         this.setButtonsPosition();
         if(this.resistPanel.visible)
         {
            this.resistPanel.y = this.actionButtonsContainer.y - this.resistPanel.height - VERTICAL_MARGIN / 2;
            this.resistPanel.x = this.inner.x;
         }
         this.scrollPane.setSize(param1 - this.margin * 2 - 2 + 6,_loc7_);
         this.scrollPane.update();
         this.resizeTimeIndicator();
      }
      
      private function resizeTimeIndicator() : void
      {
         if(this.scrollContainer.contains(this.timeIndicator))
         {
            this.timeIndicator.x = this.areaRect2.x + this.areaRect2.width - this.timeIndicator.width + 3;
            this.timeIndicator.y = this.areaRect2.y - 7;
         }
      }
      
      public function hideModTable() : void
      {
         if(this.scrollContainer.contains(this.modTable))
         {
            this.scrollContainer.removeChild(this.modTable);
         }
      }
      
      public function showModTable() : void
      {
         if(!this.scrollContainer.contains(this.modTable))
         {
            this.scrollContainer.addChild(this.modTable);
         }
      }
      
      private function updateKitPreview(param1:Bitmap) : void
      {
         if(this.kitFullImage.height > 0)
         {
            param1.y += KIT_INFO_TOP_MARGIN;
            this.kitItemTopPreviewDiscount.text = "-" + itemService.getDiscount(this.item) + "%";
            this.kitItemTopPreviewDiscount.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
            this.kitItemTopPreviewDiscount.x = 302;
            this.kitItemTopPreviewDiscount.y = int(this.itemNameLabel.height + KIT_INFO_TOP_MARGIN) + 168;
            if(localeService.language == "cn")
            {
               this.kitItemTopPreviewDiscount.x = 300;
            }
            if(!this.scrollContainer.contains(this.kitItemTopPreviewDiscount))
            {
               this.scrollContainer.addChild(this.kitItemTopPreviewDiscount);
            }
            else
            {
               this.scrollContainer.removeChild(this.kitItemTopPreviewDiscount);
               this.scrollContainer.addChild(this.kitItemTopPreviewDiscount);
            }
         }
      }
      
      private function showBitmap(param1:Bitmap) : void
      {
         if(param1.bitmapData != null && !this.itemPreviewContainer.contains(param1))
         {
            this.itemPreviewContainer.addChild(param1);
         }
      }
      
      private function setTimeRemaining(param1:IGameObject) : void
      {
         var _loc2_:ITemporaryItem = ITemporaryItem(param1.adapt(ITemporaryItem));
         if(_loc2_.getLifeTimeInSec() <= 0)
         {
            return;
         }
         var _loc3_:Date = _loc2_.getStopDate();
         this.timeIndicator.text = DateTimeHelper.formatDateTimeWithExpiredLabel(_loc3_);
         this.resizeTimeIndicator();
      }
      
      private function inventoryNumChanged(param1:Event = null) : void
      {
         var _loc2_:int = getRequiredRank(this.minRankIndex,this.maxRankIndex);
         var _loc3_:int = this.isCountable ? int(this.inventoryNumStepper.value) : 1;
         userGarageActionsService.chooseItemCount(this.item);
         this.buyButton.setInfo(itemService.getPrice(this.item),_loc3_,_loc2_,itemService.isPremiumItem(this.item));
         this.setButtonsPosition();
      }
      
      public function itemUpgraded() : void
      {
         if(this.selectWindow != null)
         {
            this.selectWindow.itemUpgraded();
         }
         this.showItemInfo(this.item,false);
         this.resize(this.size.x,this.size.y);
         this.stopBlinkEffects();
         this.doSomethingForEachLabel(this.showGlowEffect);
      }
      
      private function showGlowEffect(param1:int, param2:LabelBase) : void
      {
         GlowEffect.glow(param2,param2.textColor);
      }
      
      private function updateBlinkEffect() : void
      {
         if(itemService.isUpgrading(this.item))
         {
            this.startBlinkEffects();
         }
         else
         {
            this.stopBlinkEffects();
         }
      }
      
      private function startBlinkEffects() : void
      {
         this.doSomethingForEachLabel(this.startBlinkEffect);
      }
      
      private function doSomethingForEachLabel(param1:Function) : void
      {
         var _loc4_:int = 0;
         var _loc5_:ModInfoRow = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:LabelBase = null;
         var _loc2_:Vector.<UpgradableItemPropertyValue> = itemService.getUpgradableItemParams(this.item).visibleProperties;
         var _loc3_:uint = _loc2_.length;
         if(itemService.isModificationItem(this.item))
         {
            _loc4_ = int(itemService.getModificationIndex(this.item));
            _loc5_ = this.modTable.rows[_loc4_];
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               if(_loc2_[_loc6_].isUpgradable())
               {
                  param1(_loc6_,_loc5_.labels[_loc6_]);
               }
               _loc6_++;
            }
         }
         else
         {
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               if(_loc2_[_loc7_].isUpgradable())
               {
                  _loc8_ = propertyService.getParams(_loc2_[_loc7_].getProperty()).icon.getLabel();
                  param1(_loc7_,_loc8_);
               }
               _loc7_++;
            }
         }
      }
      
      private function startBlinkEffect(param1:int, param2:DisplayObject) : void
      {
         if(this.blinkEffects[param1] == null)
         {
            this.blinkEffects[param1] = new BlinkEffect();
         }
         BlinkEffect(this.blinkEffects[param1]).start(param2);
      }
   }
}

