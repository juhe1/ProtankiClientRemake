package alternativa.tanks.gui.settings.tabs
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.gui.settings.controls.CheckBoxSetting;
   import alternativa.tanks.gui.settings.controls.SettingControl;
   import alternativa.tanks.service.settings.ISettingsService;
   import alternativa.tanks.service.settings.SettingEnum;
   import base.DiscreteSprite;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class SettingsTabView extends DiscreteSprite
   {
      
      [Inject] // added
      public static var settingsService:ISettingsService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      public static const MARGIN:int = 8;
      
      public static const MARGIN_BEFORE_PARTITION_LABEL:int = 10;
      
      public static const MARGIN_AFTER_PARTITION_LABEL:int = 3;
      
      protected var settingsWithEvent:Vector.<DisplayObject> = new Vector.<DisplayObject>();
      
      public function SettingsTabView()
      {
         super();
      }
      
      public function show() : void
      {
      }
      
      public function hide() : void
      {
      }
      
      protected function createCheckBox(param1:SettingEnum, param2:String, param3:Boolean, param4:int = 0, param5:int = 0) : CheckBoxSetting
      {
         var _loc6_:CheckBoxSetting = new CheckBoxSetting(param1,param2);
         _loc6_.checked = param3;
         _loc6_.addEventListener(MouseEvent.CLICK,this.onControlClick);
         _loc6_.x = param4;
         _loc6_.y = param5;
         this.settingsWithEvent.push(_loc6_);
         _loc6_.label = param2;
         return _loc6_;
      }
      
      protected function onControlClick(param1:MouseEvent) : void
      {
         var _loc2_:SettingControl = null;
         if(param1.currentTarget is SettingControl)
         {
            _loc2_ = SettingControl(param1.currentTarget);
            settingsService.setClientSetting(_loc2_.getSetting(),_loc2_.getSettingValue());
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:DisplayObject = null;
         for each(_loc1_ in this.settingsWithEvent)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onControlClick);
         }
      }
   }
}

