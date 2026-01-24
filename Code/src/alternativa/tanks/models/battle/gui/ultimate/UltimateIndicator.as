package alternativa.tanks.models.battle.gui.ultimate
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.models.battle.gui.inventory.HudInventoryIcon;
   import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
   import alternativa.tanks.models.battle.gui.inventory.InventoryIcons;
   import alternativa.tanks.models.battle.gui.inventory.InventoryModel;
   import alternativa.tanks.models.battle.gui.inventory.InventoryPanelSlot;
   import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
   import alternativa.tanks.models.battle.gui.inventory.cooldown.CooldownIndicator;
   import alternativa.tanks.models.battle.gui.inventory.cooldown.InventoryCooldownItem;
   import alternativa.tanks.models.battle.gui.inventory.readytouse.LightPillarEffect;
   import alternativa.tanks.models.battle.gui.inventory.splash.SplashColor;
   import alternativa.tanks.models.battle.gui.inventory.splash.SplashController;
   import alternativa.tanks.models.inventory.InventoryItemType;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import alternativa.tanks.services.battlegui.BattleGUIServiceEvent;
   import alternativa.tanks.services.battlegui.InventoryChangePositionEvent;
   import alternativa.tanks.services.battleinput.BattleInputLockEvent;
   import alternativa.tanks.services.battleinput.BattleInputService;
   import alternativa.utils.removeDisplayObject;
   import controls.Label;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import forms.ColorConstants;
   
   public class UltimateIndicator
   {
      
      [Inject] // added
      public static var battleInputService:BattleInputService;
      
      [Inject] // added
      public static var inventoryPanel:IInventoryPanel;
      
      [Inject] // added
      public static var display:IDisplay;
      
      [Inject] // added
      public static var battleGuiService:BattleGUIService;
      
      [Inject] // added
      public static var inventorySoundService:InventorySoundService;
      
      private static const KEY_ICON_OFFSET_X:int = -6;
      
      private static const KEY_ICON_OFFSET_Y:int = -20;
      
      private static const ICON_SIZE:int = 78;
      
      private var cooldownItem:InventoryCooldownItem;
      
      private var splashController:SplashController;
      
      private var cooldownIndicator:CooldownIndicator = new CooldownIndicator(HudInventoryIcon.getIcon(HudInventoryIcon.OVERDRIVE_COOLDOWN_OVERLAY));
      
      private var inventoryIcon:InventoryIcons = new InventoryIcons(InventoryItemType.ULTIMATE);
      
      private var baseContainer:Sprite = new Sprite();
      
      private var percentLabel:Label = new Label();
      
      private var keyLabel:Label = new Label();
      
      private var lockIcon:Bitmap;
      
      private var disabled:Boolean = true;
      
      private var charged:Boolean;
      
      private var lightPillarEffect:LightPillarEffect = new LightPillarEffect();
      
      private var resizeTimer:uint;
      
      private var flashTimer:uint;
      
      public function UltimateIndicator()
      {
         super();
         this.lightPillarEffect.scaleX = 2;
         this.baseContainer.addChild(this.lightPillarEffect);
         var _loc1_:Sprite = new Sprite();
         this.baseContainer.addChild(_loc1_);
         var _loc2_:Bitmap = new Bitmap(HudInventoryIcon.getIcon(HudInventoryIcon.OVERDRIVE_BG));
         _loc1_.addChild(_loc2_);
         var _loc3_:CooldownIndicator = new CooldownIndicator(HudInventoryIcon.getBgdIcon(InventoryItemType.ULTIMATE));
         _loc1_.addChild(this.inventoryIcon);
         _loc1_.addChild(this.cooldownIndicator);
         _loc1_.addChild(_loc3_);
         this.keyLabel.text = "Shift";
         this.keyLabel.x = ICON_SIZE - this.keyLabel.width + KEY_ICON_OFFSET_X;
         this.keyLabel.y = ICON_SIZE + KEY_ICON_OFFSET_Y;
         this.keyLabel.visible = false;
         _loc1_.addChild(this.keyLabel);
         this.percentLabel.y = -19;
         this.percentLabel.color = InventoryPanelSlot.QUANTITY_COLOR_WHITE;
         this.percentLabel.autoSize = TextFieldAutoSize.CENTER;
         this.percentLabel.filters = [InventoryPanelSlot.GLOW_FILTER];
         _loc1_.addChild(this.percentLabel);
         this.setPercentText(0);
         this.lockIcon = new Bitmap(HudInventoryIcon.getIcon(HudInventoryIcon.OVERDRIVE_LOCK_OVERLAY));
         this.lockIcon.visible = true;
         _loc1_.addChild(this.lockIcon);
         this.splashController = new SplashController(_loc1_);
         this.cooldownItem = new InventoryCooldownItem(0,_loc3_,this.cooldownIndicator,this.splashController,this.inventoryIcon,this.finishEffectAndCooldown,this.startCooldownCallback);
         this.onResize();
         _loc1_.visible = true;
         battleGuiService.getGuiContainer().addChild(this.baseContainer);
         display.stage.addEventListener(Event.RESIZE,this.onResize,false,int.MIN_VALUE);
         display.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         battleInputService.addEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
         battleInputService.addEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
         battleGuiService.addEventListener(InventoryChangePositionEvent.ON_CHANGE_POSITION,this.onResize);
      }
      
      private function startCooldownCallback() : void
      {
      }
      
      public function markDisabled(param1:Boolean) : void
      {
         this.disabled = param1;
         this.updateState();
      }
      
      private function onInputLocked(param1:BattleInputLockEvent) : void
      {
         this.markDisabled(true);
      }
      
      private function onInputUnlocked(param1:BattleInputLockEvent) : void
      {
         this.markDisabled(false);
      }
      
      private function updateState() : void
      {
         this.disableVisual(this.disabled || !this.charged);
      }
      
      private function disableVisual(param1:Boolean) : void
      {
         this.keyLabel.visible = !param1;
         this.lockIcon.visible = param1;
         this.percentLabel.color = param1 ? InventoryPanelSlot.QUANTITY_COLOR_GRAY : InventoryPanelSlot.QUANTITY_COLOR_WHITE;
      }
      
      public function updateCharge(param1:int) : void
      {
         this.charged = param1 >= 100;
         this.setPercentText(param1);
         this.cooldownIndicator.setProgress(param1 / 100,1);
         this.updateState();
      }
      
      private function setPercentText(param1:int) : void
      {
         this.percentLabel.text = param1.toString() + " %";
         this.percentLabel.x = ICON_SIZE - this.percentLabel.width >> 1;
      }
      
      public function onCharged() : void
      {
         this.keyLabel.visible = true;
         this.inventoryIcon.state = InventoryIcons.NEUTRAL_STATE;
         this.flashIcon();
         inventorySoundService.playReadySound(InventoryItemType.ULTIMATE);
         this.lightPillarEffect.init(ColorConstants.WHITE);
         this.lightPillarEffect.y = -this.lightPillarEffect.height + ICON_SIZE - 2;
         this.lightPillarEffect.start();
         this.flashTimer = setTimeout(this.flashIcon,350);
      }
      
      private function flashIcon() : void
      {
         this.clearFlashTimer();
         this.splashController.startFlash(SplashColor.WHITE);
      }
      
      private function onResize(param1:Event = null) : void
      {
         if(this.resizeTimer == 0)
         {
            this.resizeTimer = setTimeout(this.doResize,0);
            battleGuiService.dispatchEvent(new BattleGUIServiceEvent(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT));
         }
      }
      
      private function doResize() : void
      {
         this.baseContainer.x = 10;
         this.baseContainer.y = display.stage.stageHeight - InventoryModel.PANEL_OFFSET_Y - 40;
         this.clearResizeTimer();
      }
      
      public function destroy() : void
      {
         battleGuiService.removeEventListener(InventoryChangePositionEvent.ON_CHANGE_POSITION,this.onResize);
         battleInputService.removeEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
         battleInputService.removeEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
         removeDisplayObject(this.baseContainer);
         display.stage.removeEventListener(Event.RESIZE,this.onResize);
         display.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.percentLabel = null;
         this.baseContainer = null;
         this.lockIcon = null;
         this.clearFlashTimer();
         this.clearResizeTimer();
      }
      
      public function activate() : void
      {
         this.keyLabel.visible = false;
         this.cooldownItem.activateCooldown(1);
      }
      
      private function finishEffectAndCooldown() : void
      {
         this.inventoryIcon.state = InventoryIcons.COOLDOWN_STATE;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         this.splashController.update(_loc2_);
         this.cooldownItem.update(_loc2_);
         this.lightPillarEffect.update(_loc2_);
      }
      
      private function clearFlashTimer() : void
      {
         if(this.flashTimer != 0)
         {
            clearInterval(this.flashTimer);
            this.flashTimer = 0;
         }
      }
      
      private function clearResizeTimer() : void
      {
         if(this.resizeTimer != 0)
         {
            clearTimeout(this.resizeTimer);
            this.resizeTimer = 0;
         }
      }
   }
}

