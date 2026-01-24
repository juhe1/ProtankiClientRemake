package alternativa.tanks.gui.settings.tabs.control
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.settings.SettingsWindow;
   import alternativa.tanks.gui.settings.tabs.SettingsTabView;
   import alternativa.tanks.service.settings.keybinding.GameActionEnum;
   import alternativa.tanks.service.settings.keybinding.KeysBindingService;
   import base.DiscreteSprite;
   import controls.base.DefaultButtonBase;
   import controls.containers.StackPanel;
   import controls.containers.VerticalStackPanel;
   import flash.events.MouseEvent;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class KeyBindingsPanel extends DiscreteSprite
   {
      
      [Inject] // added
      public static var keysBindingService:KeysBindingService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private var keyBindingsPanel:VerticalStackPanel = new VerticalStackPanel();
      
      private var keyBindingVisualElements:Vector.<KeyBinding> = new Vector.<KeyBinding>();
      
      private var restoreDefaultBindingsButton:DefaultButtonBase = new DefaultButtonBase();
      
      public function KeyBindingsPanel()
      {
         super();
         this.restoreDefaultBindingsButton.label = localeService.getText(TanksLocale.TEXT_BUTTON_LABEL_RESTORE_DEFAULT_BUTTONS);
         this.restoreDefaultBindingsButton.width = 250;
         this.restoreDefaultBindingsButton.addEventListener(MouseEvent.CLICK,this.restoreDefaultBindings);
         addChild(this.restoreDefaultBindingsButton);
         this.keyBindingsPanel.setMargin(SettingsTabView.MARGIN * 2);
         this.keyBindingsPanel.addItem(this.createTurretActionsPanel());
         this.keyBindingsPanel.addItem(this.createChassisActionsPanel());
         this.keyBindingsPanel.addItem(this.createInventoryActionsPanel());
         this.keyBindingsPanel.addItem(this.createBattleActionsPanel());
         this.keyBindingsPanel.addItem(this.createWindowActionsPanel());
         this.keyBindingsPanel.addItem(this.createCameraActionsPanel());
         this.keyBindingsPanel.y = SettingsTabView.MARGIN + this.restoreDefaultBindingsButton.height;
         addChild(this.keyBindingsPanel);
      }
      
      private function restoreDefaultBindings(param1:MouseEvent) : void
      {
         var _loc2_:KeyBinding = null;
         keysBindingService.restoreDefaultBindings();
         for each(_loc2_ in this.keyBindingVisualElements)
         {
            _loc2_.restoreDefaultBinding();
         }
      }
      
      private function createTurretActionsPanel() : StackPanel
      {
         var _loc1_:StackPanel = new VerticalStackPanel();
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.ROTATE_TURRET_LEFT,localeService.getText(TanksLocale.TEXT_GAME_ACTION_TURRET_TURN_LEFT)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.ROTATE_TURRET_RIGHT,localeService.getText(TanksLocale.TEXT_GAME_ACTION_TURRET_TURN_RIGHT)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.CENTER_TURRET,localeService.getText(TanksLocale.TEXT_GAME_ACTION_TURRET_CENTER)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.SHOT,localeService.getText(TanksLocale.TEXT_GAME_ACTION_SHOOT)));
         return _loc1_;
      }
      
      private function createChassisActionsPanel() : StackPanel
      {
         var _loc1_:StackPanel = new VerticalStackPanel();
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.CHASSIS_LEFT_MOVEMENT,localeService.getText(TanksLocale.TEXT_GAME_ACTION_TANK_TURN_LEFT)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.CHASSIS_FORWARD_MOVEMENT,localeService.getText(TanksLocale.TEXT_GAME_ACTION_TANK_MOVE_FORWARD)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.CHASSIS_RIGHT_MOVEMENT,localeService.getText(TanksLocale.TEXT_GAME_ACTION_TANK_TURN_RIGHT)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.CHASSIS_BACKWARD_MOVEMENT,localeService.getText(TanksLocale.TEXT_GAME_ACTION_TANK_MOVE_BACKWARD)));
         return _loc1_;
      }
      
      private function createInventoryActionsPanel() : StackPanel
      {
         var _loc1_:StackPanel = new VerticalStackPanel();
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.USE_FIRS_AID,localeService.getText(TanksLocale.TEXT_GAME_ACTION_USE_FIRST_AID)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.USE_DOUBLE_ARMOR,localeService.getText(TanksLocale.TEXT_GAME_ACTION_USE_DOUBLE_ARMOR)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.USE_DOUBLE_DAMAGE,localeService.getText(TanksLocale.TEXT_GAME_ACTION_USE_DOBLE_DAMAGE)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.USE_NITRO,localeService.getText(TanksLocale.TEXT_GAME_ACTION_USE_NITRO)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.USE_MINE,localeService.getText(TanksLocale.TEXT_GAME_ACTION_USE_MINE)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.DROP_GOLD_BOX,localeService.getText(TanksLocale.TEXT_GAME_ACTION_DROP_GOLD_BOX)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.ULTIMATE,localeService.getText(TanksLocale.TEXT_ULTIMATES)));
         return _loc1_;
      }
      
      private function createWindowActionsPanel() : StackPanel
      {
         var _loc1_:StackPanel = new VerticalStackPanel();
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.BATTLE_VIEW_INCREASE,localeService.getText(TanksLocale.TEXT_GAME_ACTION_SCREEN_SIZE_INCREASE)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.BATTLE_VIEW_DECREASE,localeService.getText(TanksLocale.TEXT_GAME_ACTION_SCREEN_SIZE_DECREASE)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.FULL_SCREEN,localeService.getText(TanksLocale.TEXT_GAME_ACTION_FULL_SCREEN)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.OPEN_GARAGE,localeService.getText(TanksLocale.TEXT_OPEN_GARAGE)));
         return _loc1_;
      }
      
      private function createBattleActionsPanel() : StackPanel
      {
         var _loc1_:StackPanel = new VerticalStackPanel();
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.DROP_FLAG,localeService.getText(TanksLocale.TEXT_GAME_ACTION_DROP_FLAG)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.BATTLE_PAUSE,localeService.getText(TanksLocale.TEXT_GAME_ACTION_PAUSE)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.SHOW_TANK_PARAMETERS,localeService.getText(TanksLocale.TEXT_GAME_ACTION_SHOW_TANK_STATS)));
         return _loc1_;
      }
      
      private function createCameraActionsPanel() : StackPanel
      {
         var _loc1_:StackPanel = new VerticalStackPanel();
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.FOLLOW_CAMERA_UP,localeService.getText(TanksLocale.TEXT_GAME_ACTION_CAMERA_UP)));
         _loc1_.addItem(this.createKeyBinding(GameActionEnum.FOLLOW_CAMERA_DOWN,localeService.getText(TanksLocale.TEXT_GAME_ACTION_CAMERA_DOWN)));
         return _loc1_;
      }
      
      private function createKeyBinding(param1:GameActionEnum, param2:String) : KeyBinding
      {
         var _loc3_:KeyBinding = new KeyBinding(param1,param2,SettingsTabView.MARGIN,SettingsWindow.TAB_VIEW_MAX_WIDTH);
         this.keyBindingVisualElements.push(_loc3_);
         return _loc3_;
      }
      
      public function destroy() : void
      {
         var _loc1_:KeyBinding = null;
         this.restoreDefaultBindingsButton.removeEventListener(MouseEvent.CLICK,this.restoreDefaultBindings);
         for each(_loc1_ in this.keyBindingVisualElements)
         {
            _loc1_.destroy();
         }
         this.keyBindingsPanel = null;
         this.keyBindingVisualElements = null;
      }
   }
}

