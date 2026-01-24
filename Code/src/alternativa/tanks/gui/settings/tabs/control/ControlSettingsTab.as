package alternativa.tanks.gui.settings.tabs.control
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.gui.settings.SettingsWindow;
   import alternativa.tanks.gui.settings.tabs.ScrollableSettingsTabView;
   import alternativa.tanks.service.settings.SettingEnum;
   import base.DiscreteSprite;
   import controls.Slider;
   import controls.TankWindowInner;
   import controls.base.LabelBase;
   import controls.containers.VerticalStackPanel;
   import forms.events.SliderEvent;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
   
   public class ControlSettingsTab extends ScrollableSettingsTabView
   {
      
      [Inject] // added
      public static var fullScreenService:FullscreenService;
      
      [Inject] // added
      public static var display:IDisplay;
      
      public static const MIN_SENSITIVITY_MOUSE:int = 1;
      
      public static const MAX_SENSITIVITY_MOUSE:int = 20;
      
      private var mouseSensitivity:Slider;
      
      public function ControlSettingsTab()
      {
         super();
         var _loc1_:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,SettingsWindow.TAB_VIEW_MAX_HEIGHT,TankWindowInner.TRANSPARENT);
         addChildAt(_loc1_,0);
         var _loc2_:VerticalStackPanel = new VerticalStackPanel();
         _loc2_.setMargin(MARGIN);
         _loc2_.x = MARGIN;
         _loc2_.y = TOP_MARGIN_FOR_SCROLL_TAB;
         if(!fullScreenService.isMouseLockDisabled())
         {
            _loc2_.addItem(this.createMouseControlPanel());
         }
         _loc2_.addItem(createCheckBox(SettingEnum.INVERSE_BACK_DRIVING,localeService.getText(TanksLocale.TEXT_SETTINGS_INVERSE_TURN_CONTROL_CHECKBOX_LABEL_TEXT),settingsService.inverseBackDriving));
         _loc2_.addItem(new KeyBindingsPanel());
         addItem(_loc2_);
      }
      
      private function createMouseControlPanel() : DiscreteSprite
      {
         var _loc1_:VerticalStackPanel = new VerticalStackPanel();
         _loc1_.setMargin(MARGIN);
         _loc1_.addItem(createCheckBox(SettingEnum.MOUSE_CONTROL,localeService.getText(TanksLocale.TEXT_SETTINGS_MOUSE_CONTROL_CHECKBOX),settingsService.mouseControl));
         _loc1_.addItem(this.createMouseSensitivityBlock());
         _loc1_.addItem(createCheckBox(SettingEnum.MOUSE_Y_INVERSE,localeService.getText(TanksLocale.TEXT_SETTINGS_MOUSE_INVERSION_CHECKBOX_LABEL),settingsService.mouseYInverse));
         _loc1_.addItem(createCheckBox(SettingEnum.MOUSE_Y_INVERSE_SHAFT_AIM,localeService.getText(TanksLocale.TEXT_SETTINGS_MOUSE_SHAFT_SCOPE_VERTICAL_INVERSION),settingsService.mouseYInverseShaftAim));
         return _loc1_;
      }
      
      private function createMouseSensitivityBlock() : DiscreteSprite
      {
         var _loc1_:DiscreteSprite = new DiscreteSprite();
         var _loc2_:LabelBase = new LabelBase();
         _loc2_.text = localeService.getText(TanksLocale.TEXT_SETTINGS_MOUSE_SENSITIVITY_CHECKBOX_LABEL) + ":";
         _loc1_.addChild(_loc2_);
         this.mouseSensitivity = new Slider();
         this.mouseSensitivity.maxValue = MAX_SENSITIVITY_MOUSE;
         this.mouseSensitivity.minValue = MIN_SENSITIVITY_MOUSE;
         this.mouseSensitivity.tickInterval = 1;
         this.mouseSensitivity.width = SettingsWindow.TAB_VIEW_MAX_WIDTH - MARGIN * 4 - _loc2_.width;
         this.mouseSensitivity.x = _loc2_.width + MARGIN;
         this.mouseSensitivity.value = settingsService.mouseSensitivity;
         this.mouseSensitivity.addEventListener(SliderEvent.CHANGE_VALUE,this.onChangeMouseSensitivity);
         _loc2_.y = Math.round((this.mouseSensitivity.height - _loc2_.textHeight) * 0.5) - 2;
         _loc1_.addChild(this.mouseSensitivity);
         return _loc1_;
      }
      
      private function onChangeMouseSensitivity(param1:SliderEvent) : void
      {
         settingsService.setClientSetting(SettingEnum.MOUSE_SENSITIVITY,this.mouseSensitivity.value);
      }
      
      override public function destroy() : void
      {
         if(!fullScreenService.isMouseLockDisabled())
         {
            this.mouseSensitivity.removeEventListener(SliderEvent.CHANGE_VALUE,this.onChangeMouseSensitivity);
         }
         super.destroy();
      }
   }
}

