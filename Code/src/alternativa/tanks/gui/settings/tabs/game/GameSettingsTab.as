package alternativa.tanks.gui.settings.tabs.game
{
   import alternativa.tanks.gui.settings.SettingsWindow;
   import alternativa.tanks.gui.settings.tabs.SettingsTabView;
   import alternativa.tanks.gui.settings.tabs.SoundSettingsTab;
   import alternativa.tanks.service.settings.SettingEnum;
   import controls.Label;
   import controls.TankWindowInner;
   import controls.checkbox.CheckBoxBase;
   import controls.containers.StackPanel;
   import controls.containers.VerticalStackPanel;
   import flash.events.MouseEvent;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
   
   public class GameSettingsTab extends SettingsTabView
   {
      
      [Inject]
      public static var battleInviteService:IBattleInviteService;
      
      private var cbReceivePersonalMessagesOnlyFromFriends:CheckBoxBase;
      
      private var cbReceiveBattleInvite:CheckBoxBase;
      
      private var soundTab:SoundSettingsTab;
      
      public function GameSettingsTab(param1:Boolean)
      {
         super();
         var _loc2_:VerticalStackPanel = new VerticalStackPanel();
         _loc2_.x = MARGIN;
         _loc2_.y = MARGIN;
         _loc2_.setMargin(MARGIN);
         _loc2_.addItem(createCheckBox(SettingEnum.SHOW_DAMAGE,localeService.getText(TanksLocale.TEXT_SHOW_DAMAGE),settingsService.showDamage));
         _loc2_.addItem(createCheckBox(SettingEnum.SHOW_DROP_ZONES,localeService.getText(TanksLocale.TEXT_SETTINGS_SHOW_DROP_ZONES_LABEL_TEXT),settingsService.showDropZones));
         _loc2_.addItem(createCheckBox(SettingEnum.ALTERNATE_CAMERA,localeService.getText(TanksLocale.TEXT_SETTINGS_ALTERNATE_CAMERA_LABEL_TEXT),settingsService.alternateCamera));
         _loc2_.addItem(createCheckBox(SettingEnum.SHOW_LOCAL_DRONE,localeService.getText(TanksLocale.TEXT_SETTINGS_SHOW_LOCAL_DRONE),settingsService.showLocalDrone));
         _loc2_.addItem(createCheckBox(SettingEnum.RECEIVE_PRESENTS,localeService.getText(TanksLocale.TEXT_SETTINGS_RECEIVE_PRESENTS),settingsService.receivePresents));
         var _loc3_:VerticalStackPanel = new VerticalStackPanel();
         _loc3_.setMargin(MARGIN);
         _loc3_.y = MARGIN;
         _loc3_.x = SettingsWindow.TAB_VIEW_MAX_WIDTH * 0.5;
         this.cbReceivePersonalMessagesOnlyFromFriends = this.createCheckBoxWithoutAutoSave(localeService.getText(TanksLocale.TEXT_SETTINGS_MESSAGE_ONLY_FROM_FRIENDS),param1);
         this.cbReceivePersonalMessagesOnlyFromFriends.addEventListener(MouseEvent.CLICK,this.onReceivePersonalMessagesOnlyFromFriendsClick);
         _loc3_.addItem(this.cbReceivePersonalMessagesOnlyFromFriends);
         _loc3_.addItem(createCheckBox(SettingEnum.SHOW_CHAT,localeService.getText(TanksLocale.TEXT_SETTINGS_SHOW_CHAT_CHECKBOX_LABEL_TEXT),settingsService.showChat));
         this.cbReceiveBattleInvite = this.createCheckBoxWithoutAutoSave(localeService.getText(TanksLocale.TEXT_SHOW_NOTIFICATIONS_LABEL),battleInviteService.receiveBattleInvite);
         this.cbReceiveBattleInvite.addEventListener(MouseEvent.CLICK,this.onReceiveBattleInviteClick);
         _loc3_.addItem(this.cbReceiveBattleInvite);
         _loc3_.addItem(createCheckBox(SettingEnum.SHOW_REMOTE_DRONES,localeService.getText(TanksLocale.TEXT_SETTINGS_SHOW_REMOTE_DRONES),settingsService.showRemoteDrones));
         var _loc4_:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,_loc2_.height + 2 * MARGIN,TankWindowInner.TRANSPARENT);
         _loc4_.addChild(_loc2_);
         _loc4_.addChild(_loc3_);
         addChild(_loc4_);
         var _loc5_:StackPanel = this.createSoundPanel();
         _loc5_.y = _loc4_.y + _loc4_.height + MARGIN_BEFORE_PARTITION_LABEL;
         addChild(_loc5_);
      }
      
      private function createSoundPanel() : StackPanel
      {
         var _loc1_:VerticalStackPanel = new VerticalStackPanel();
         _loc1_.setMargin(MARGIN_AFTER_PARTITION_LABEL);
         var _loc2_:Label = new Label();
         _loc2_.text = localeService.getText(TanksLocale.TEXT_SETTINGS_SOUND_VOLUME_LABEL_TEXT);
         _loc1_.addItem(_loc2_);
         this.soundTab = new SoundSettingsTab();
         _loc1_.addItem(this.soundTab);
         return _loc1_;
      }
      
      private function onReceiveBattleInviteClick(param1:MouseEvent) : void
      {
         battleInviteService.receiveBattleInvite = this.cbReceiveBattleInvite.checked;
      }
      
      private function onReceivePersonalMessagesOnlyFromFriendsClick(param1:MouseEvent) : void
      {
         dispatchEvent(new ReceivePersonalMessagesSettingEvent(ReceivePersonalMessagesSettingEvent.RECEIVE_PERSONAL_MESSAGES_CHANGE,this.cbReceivePersonalMessagesOnlyFromFriends.checked));
      }
      
      protected function createCheckBoxWithoutAutoSave(param1:String, param2:Boolean, param3:int = 0, param4:int = 0) : CheckBoxBase
      {
         var _loc5_:CheckBoxBase = new CheckBoxBase();
         _loc5_.checked = param2;
         _loc5_.x = param3;
         _loc5_.y = param4;
         _loc5_.label = param1;
         return _loc5_;
      }
      
      override public function destroy() : void
      {
         this.cbReceiveBattleInvite.removeEventListener(MouseEvent.CLICK,this.onReceiveBattleInviteClick);
         this.cbReceivePersonalMessagesOnlyFromFriends.removeEventListener(MouseEvent.CLICK,this.onReceivePersonalMessagesOnlyFromFriendsClick);
         this.soundTab.destroy();
         super.destroy();
      }
   }
}

