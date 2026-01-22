package alternativa.tanks.gui.settings.tabs.account
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.gui.icons.SocialNetworkIcon;
   import alternativa.tanks.gui.settings.SettingsWindow;
   import alternativa.tanks.gui.settings.tabs.SettingsTabView;
   import alternativa.tanks.gui.shop.components.window.ShopWindowCountrySelector;
   import alternativa.tanks.service.socialnetwork.ISocialNetworkPanelService;
   import alternativa.tanks.service.socialnetwork.SocialNetworkServiceEvent;
   import assets.icons.InputCheckIcon;
   import controls.DefaultIconButton;
   import controls.FBButton;
   import controls.TankWindowInner;
   import controls.VKButton;
   import controls.base.DefaultButtonBase;
   import controls.base.LabelBase;
   import controls.base.TankInput;
   import controls.containers.HorizontalStackPanel;
   import controls.containers.VerticalStackPanel;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.Capabilities;
   import flash.text.AntiAliasType;
   import forms.events.LoginFormEvent;
   import forms.registration.CallsignIconStates;
   import forms.registration.bubbles.EmailInvalidBubble;
   import forms.registration.bubbles.PasswordIsTooEasyBubble;
   import forms.registration.bubbles.PasswordsDoNotMatchBubble;
   import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
   import projects.tanks.clients.flash.commons.models.captcha.CaptchaSection;
   import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;
   import projects.tanks.clients.flash.commons.services.validate.IValidateService;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.LocaleServiceLangValues;
   
   public class AccountSettingsTab extends SettingsTabView
   {
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var partnersService:IPartnerService;
      
      [Inject]
      public static var socialNetworkService:ISocialNetworkPanelService;
      
      [Inject]
      public static var validateService:IValidateService;
      
      [Inject]
      public static var helperService:IHelpService;
      
      private static const HELPER_GROUP_KEY:String = "ChangeHelpers";
      
      private static const PASSWORD_IS_TOO_EASY:int = 3;
      
      private static const PASSWORDS_DO_NOT_MATCH:int = 4;
      
      private static const ERROR_EMAIL_INVALID:int = 5;
      
      private static const CHECK_ICON_OFFSET:int = 7;
      
      private static const INPUT_HEIGHT:int = 30;
      
      private static const forbiddenPasswords:Array = ["1234567890","123456789","12345678","1234567","123456","12345","1234","0123","01234","012345","0123456","01234567","012345678","0123456789","9876","98765","987654","9876543","98765432","987654321","9876543210","8765","87654","876543","8765432","87654321","876543210","7654","76543","765432","7654321","76543210","6543","65432","654321","6543210","5432","54321","543210","4321","43210","3210","1111","2222","3333","4444","5555","6666","7777","8888","9999","0000","11111","22222","33333","44444","55555","66666","77777","88888","99999","00000","111111","222222","333333","444444","555555","666666","777777","888888","999999","000000","1111111","2222222","3333333","4444444","5555555","6666666","7777777","8888888","9999999","0000000","11111111","22222222","33333333","44444444","55555555","66666666","77777777","88888888","99999999","00000000","111111111","222222222","333333333","444444444","555555555","666666666","777777777","888888888","999999999","000000000"
      ,"abcd","Jack","1234","snoopy","suzy","spike","1012","1234","pepper ","shelby","12345 ","54321 ","pass ","wolf","john","qqqq","aaaa","ZZZz","asdf","zxcv","asdf","zxcv","asdfgh","zxcvbn","1111","!!!!","4321","$#@!","1234","!@#$","12345","!@#$%","123456","!@#$%^","abcd","ABCD","qwerty1","QWERTY!","1q2w3e4r","1q2w3e","q1w2e3","q1w2e3r4","qweasd","QWEASD","asdzxc","ASDZXC","qweqwe","QWEQWE","asdasd","ASDASD","zxczxc","qwaszx","elite","ELITE","1qwerty","!QWERTY","black","blue","green","grey","yellow","orange","brown","support","Support","Topgun","topgun","help","Lame","hack","hunter","ranger","lamer","Lamer","hacker","Hacker","hack","summer","spring","autumn","winter","sunday","monday","tuesday","wednesda","thursday","friday","saturday","january","february","march","april","june","july","august","september","october","november","december","cool","lucky","korn ","fuck","Honda","mustang","pentium","mouse","stan","soccer","password","diablo","zoom","joker","nofear","unix","home","apache","holly"
      ,"q3rulez","pass123","magnum","mother","father","lisa","janet","helen","chocolate","Matrix","Gold","dollar","pussy","eminem","personal","zippo","jennifer","pepsi","clock","time","good","super","friend","angel","qwer","qwert","qwerty","homer","angle","johan","love","test","1q2w3e4r5t6y","31337","loll","gggg"];
      
      private static const VKONTAKTE:String = "vkontakte";
      
      private static const FACEBOOK:String = "facebook";
      
      private var pass1:TankInput;
      
      private var pass2:TankInput;
      
      private var emailInput:TankInput;
      
      private var realNameInput:TankInput;
      
      private var idNumberInput:TankInput;
      
      private var setEmailButton:DefaultButtonBase;
      
      private var pass1CheckIcon:InputCheckIcon;
      
      private var pass2CheckIcon:InputCheckIcon;
      
      private var emailCheckIcon:InputCheckIcon;
      
      private var passwordIsTooEasyBubble:PasswordIsTooEasyBubble;
      
      private var passwordsDoNotMatchBubble:PasswordsDoNotMatchBubble;
      
      private var errorEmailInvalodBubble:EmailInvalidBubble;
      
      private var changePasswordOnEmailButton:DefaultButtonBase;
      
      private var multiSNMode:Boolean;
      
      private var snButton:DefaultIconButton;
      
      private var snHasLinkLabel:LabelBase;
      
      private var vkButton:DefaultButtonBase;
      
      private var fbButton:DefaultButtonBase;
      
      public var emailConfirmed:Boolean = false;
      
      public var initialRealName:String;
      
      public var initialIDNumber:String;
      
      private var saveAntiAddictionInfoButton:DefaultButtonBase;
      
      private var currentSN:String;
      
      private var oldPassword:TankInput;
      
      private var oldPasswordCheckIcon:InputCheckIcon;
      
      private var changePasswordButton:DefaultButtonBase;
      
      private var captchaSection:CaptchaSection;
      
      public function AccountSettingsTab(param1:String, param2:Boolean, param3:Boolean, param4:String, param5:String)
      {
         super();
         this.initialRealName = param4;
         this.initialIDNumber = param5;
         this.emailConfirmed = param2;
         var _loc6_:VerticalStackPanel = new VerticalStackPanel();
         _loc6_.setMargin(MARGIN);
         addChild(this.createCountrySelector());
         _loc6_.y = 3 * MARGIN + INPUT_HEIGHT;
         if(!partnersService.isRunningInsidePartnerEnvironment())
         {
            if(param2)
            {
               _loc6_.addItem(this.createPanelChangePasswordOnEmail());
            }
            else
            {
               _loc6_.addItem(this.createPasswordAndEmailPanel(param1));
               this.initEvents();
               this.createBubbles();
            }
         }
         if(Boolean(socialNetworkService.snEnabledInCurrentLocale(FACEBOOK)) || Boolean(socialNetworkService.snEnabledInCurrentLocale(VKONTAKTE)))
         {
            _loc6_.addItem(this.createSNPanel());
         }
         if(param3)
         {
            _loc6_.addItem(this.createAntiAddictionPanel(param1,param5,param4));
         }
         addChildAt(_loc6_,0);
      }
      
      private static function restoreInput(param1:Event) : void
      {
         var _loc2_:TankInput = param1.currentTarget as TankInput;
         _loc2_.validValue = true;
      }
      
      private static function isPasswordValid(param1:String) : Boolean
      {
         return param1 == "" || param1.length >= 4 && forbiddenPasswords.indexOf(param1.toLowerCase()) == -1;
      }
      
      private static function trimString(param1:String) : String
      {
         if(Boolean(param1))
         {
            return param1.replace(/^\s+|\s+$/g,"");
         }
         return param1;
      }
      
      private function createAntiAddictionPanel(param1:String, param2:String, param3:String) : DisplayObject
      {
         var _loc4_:VerticalStackPanel = new VerticalStackPanel();
         _loc4_.setMargin(MARGIN_AFTER_PARTITION_LABEL);
         var _loc5_:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,0,TankWindowInner.TRANSPARENT);
         var _loc6_:LabelBase = new LabelBase();
         _loc6_.antiAliasType = AntiAliasType.ADVANCED;
         _loc6_.sharpness = -100;
         _loc6_.thickness = 100;
         _loc6_.text = "防沉迷验证登记";
         _loc5_.addChild(_loc6_);
         _loc4_.addItem(_loc6_);
         var _loc7_:LabelBase = new LabelBase();
         _loc5_.addChild(_loc7_);
         _loc7_.text = "您的真实姓名:";
         _loc7_.x = MARGIN;
         this.realNameInput = new TankInput();
         _loc5_.addChild(this.realNameInput);
         this.realNameInput.width = _loc5_.width - MARGIN * 3 - _loc7_.textWidth - 4;
         this.realNameInput.x = _loc7_.x + _loc7_.width + MARGIN;
         this.realNameInput.y = _loc5_.y + MARGIN;
         _loc7_.y = this.realNameInput.y + Math.round((this.realNameInput.height - _loc7_.textHeight) * 0.5) - 2;
         var _loc8_:LabelBase = new LabelBase();
         _loc5_.addChild(_loc8_);
         _loc8_.text = "身份证号码:";
         _loc8_.x = MARGIN;
         _loc8_.y = this.realNameInput.y + this.realNameInput.height + MARGIN + 6;
         this.idNumberInput = new TankInput();
         _loc5_.addChild(this.idNumberInput);
         this.idNumberInput.textField.text = param1;
         this.idNumberInput.x = this.realNameInput.x;
         this.idNumberInput.y = this.realNameInput.y + this.realNameInput.height + MARGIN;
         this.idNumberInput.width = this.realNameInput.width;
         this.idNumberInput.textField.text = param2 != null && param2 != "null" ? param2 : "";
         this.realNameInput.textField.text = param3 != null && param3 != "null" ? param3 : "";
         this.idNumberInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.validateAddictionID);
         this.realNameInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.validateRealName);
         this.saveAntiAddictionInfoButton = new DefaultButtonBase();
         this.saveAntiAddictionInfoButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_BUTTON_SAVE_TEXT);
         this.saveAntiAddictionInfoButton.addEventListener(MouseEvent.CLICK,this.onClickSaveAntiAddictionInfo);
         _loc5_.height = MARGIN * 4 + 2 * this.realNameInput.height + this.saveAntiAddictionInfoButton.height;
         this.saveAntiAddictionInfoButton.x = SettingsWindow.TAB_VIEW_MAX_WIDTH - MARGIN - this.saveAntiAddictionInfoButton.width;
         this.saveAntiAddictionInfoButton.y = 3 * MARGIN + 2 * this.realNameInput.height;
         _loc5_.addChild(this.saveAntiAddictionInfoButton);
         _loc4_.addItem(_loc5_);
         return _loc4_;
      }
      
      private function createPanelChangePasswordOnEmail() : TankWindowInner
      {
         var _loc1_:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,2 * MARGIN + INPUT_HEIGHT,TankWindowInner.TRANSPARENT);
         this.changePasswordOnEmailButton = new DefaultButtonBase();
         this.changePasswordOnEmailButton.width = 210;
         this.changePasswordOnEmailButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_BUTTON_CHANGE_PASSWORD_TEXT);
         this.changePasswordOnEmailButton.x = (SettingsWindow.TAB_VIEW_MAX_WIDTH - this.changePasswordOnEmailButton.width) / 2;
         this.changePasswordOnEmailButton.y = MARGIN;
         this.changePasswordOnEmailButton.addEventListener(MouseEvent.CLICK,this.onClickChangePasswordOnEmail);
         _loc1_.addChild(this.changePasswordOnEmailButton);
         this.createCaptcha(_loc1_);
         return _loc1_;
      }
      
      private function createPasswordAndEmailPanel(param1:String) : TankWindowInner
      {
         var _loc2_:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,INPUT_HEIGHT * 3 + 4 * MARGIN,TankWindowInner.TRANSPARENT);
         var _loc3_:LabelBase = this.createLabel(localeService.getText(TanksLocale.TEXT_CURRENT_PASSWORD));
         var _loc4_:LabelBase = this.createLabel(localeService.getText(TanksLocale.TEXT_SETTINGS_NEW_PASSWORD_LABEL_TEXT));
         var _loc5_:LabelBase = this.createLabel(localeService.getText(TanksLocale.TEXT_SETTINGS_REENTER_PASSWORD_LABEL_TEXT));
         var _loc6_:int = (SettingsWindow.TAB_VIEW_MAX_WIDTH - _loc3_.width - _loc4_.width - _loc5_.width - 7 * MARGIN) / 3 + 1;
         this.oldPassword = new TankInput();
         this.oldPassword.hidden = true;
         this.oldPassword.width = _loc6_;
         this.oldPassword.maxChars = 20;
         this.oldPassword.validValue = true;
         this.pass1 = new TankInput();
         this.pass1.hidden = true;
         this.pass1.width = _loc6_;
         this.pass1.maxChars = 20;
         this.pass1.validValue = true;
         this.oldPassword.height = this.pass1.height;
         this.pass2 = new TankInput();
         this.pass2.hidden = true;
         this.pass2.width = _loc6_;
         this.pass2.maxChars = 20;
         this.pass2.validValue = true;
         _loc3_.x = MARGIN;
         _loc3_.y = MARGIN + (INPUT_HEIGHT - _loc3_.height) / 2;
         this.oldPassword.x = _loc3_.x + _loc3_.width + MARGIN;
         this.oldPassword.y = MARGIN;
         _loc4_.x = this.oldPassword.x + this.oldPassword.width + MARGIN;
         _loc4_.y = _loc3_.y;
         this.pass1.x = _loc4_.x + _loc4_.width + MARGIN;
         this.pass1.y = MARGIN;
         _loc5_.x = this.pass1.x + this.pass1.width + MARGIN;
         _loc5_.y = _loc3_.y;
         this.pass2.x = _loc5_.x + _loc5_.width + MARGIN;
         this.pass2.y = MARGIN;
         _loc2_.addChild(_loc3_);
         _loc2_.addChild(this.oldPassword);
         _loc2_.addChild(_loc4_);
         _loc2_.addChild(this.pass1);
         _loc2_.addChild(_loc5_);
         _loc2_.addChild(this.pass2);
         this.changePasswordButton = new DefaultButtonBase();
         this.changePasswordButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_CHANGE_PASSWORD_BUTTON);
         this.changePasswordButton.addEventListener(MouseEvent.CLICK,this.onClickChangePassword);
         this.changePasswordButton.x = SettingsWindow.TAB_VIEW_MAX_WIDTH - MARGIN - this.changePasswordButton.width;
         this.changePasswordButton.y = 2 * MARGIN + INPUT_HEIGHT;
         _loc2_.addChild(this.changePasswordButton);
         this.oldPasswordCheckIcon = new InputCheckIcon();
         this.oldPasswordCheckIcon.x = this.oldPassword.x + _loc6_ - this.oldPasswordCheckIcon.width / 2 - CHECK_ICON_OFFSET;
         this.oldPasswordCheckIcon.y = this.oldPassword.y + MARGIN + CHECK_ICON_OFFSET;
         this.oldPasswordCheckIcon.visible = false;
         this.oldPasswordCheckIcon.gotoAndStop(CallsignIconStates.CALLSIGN_ICON_STATE_INVALID);
         this.pass1CheckIcon = new InputCheckIcon();
         this.pass2CheckIcon = new InputCheckIcon();
         this.pass1CheckIcon.x = this.pass1.x + _loc6_ - this.pass1CheckIcon.width / 2 - CHECK_ICON_OFFSET;
         this.pass1CheckIcon.y = this.pass1.y + MARGIN + CHECK_ICON_OFFSET;
         this.pass1State = CallsignIconStates.CALLSIGN_ICON_STATE_OFF;
         this.pass2CheckIcon.x = this.pass2.x + _loc6_ - this.pass2CheckIcon.width / 2 - CHECK_ICON_OFFSET;
         this.pass2CheckIcon.y = this.pass2.y + MARGIN + CHECK_ICON_OFFSET;
         this.pass2State = CallsignIconStates.CALLSIGN_ICON_STATE_OFF;
         _loc2_.addChild(this.oldPasswordCheckIcon);
         _loc2_.addChild(this.pass1CheckIcon);
         _loc2_.addChild(this.pass2CheckIcon);
         var _loc7_:DisplayObject = this.createSetEmailPanel(param1);
         _loc7_.height = INPUT_HEIGHT;
         _loc7_.x = MARGIN;
         _loc7_.y = INPUT_HEIGHT + this.changePasswordButton.height + 3 * MARGIN;
         _loc2_.addChild(_loc7_);
         this.emailCheckIcon = new InputCheckIcon();
         this.emailCheckIcon.x = this.emailInput.x + this.emailInput.width - this.emailCheckIcon.width / 2 - CHECK_ICON_OFFSET;
         this.emailCheckIcon.y = _loc7_.y + CHECK_ICON_OFFSET;
         this.emailState = CallsignIconStates.CALLSIGN_ICON_STATE_OFF;
         _loc2_.addChild(this.emailCheckIcon);
         this.createCaptcha(_loc2_);
         return _loc2_;
      }
      
      private function createCaptcha(param1:TankWindowInner) : void
      {
         var container:TankWindowInner = param1;
         this.captchaSection = new CaptchaSection();
         this.captchaSection.manualInitialize();
         this.captchaSection.refreshButton.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            dispatchEvent(new RefreshCaptchaClickedEvent());
         });
         this.captchaSection.x = (container.width - this.captchaSection.width) / 2;
         this.captchaSection.y = MARGIN + container.height;
         this.captchaSection.visible = true;
         container.height += this.captchaSection.height + 2 * MARGIN;
         container.addChild(this.captchaSection);
         dispatchEvent(new RefreshCaptchaClickedEvent());
      }
      
      public function setCaptchaImage(param1:Bitmap) : void
      {
         if(Boolean(this.captchaSection))
         {
            this.captchaSection.captcha = param1;
         }
      }
      
      public function getCaptchaAnswer() : String
      {
         if(Boolean(this.captchaSection))
         {
            return this.captchaSection.captchaAnswer.value;
         }
         return "";
      }
      
      private function createCountrySelector() : TankWindowInner
      {
         var _loc1_:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,INPUT_HEIGHT + 2 * MARGIN,TankWindowInner.TRANSPARENT);
         var _loc2_:LabelBase = this.createLabel(localeService.getText(TanksLocale.TEXT_CHECK_YOU_LOCATION_TEXT));
         var _loc3_:ShopWindowCountrySelector = new ShopWindowCountrySelector(false);
         var _loc4_:int = _loc2_.width + MARGIN + _loc3_.width;
         _loc2_.x = int(SettingsWindow.TAB_VIEW_MAX_WIDTH / 2 - _loc4_ / 2);
         _loc2_.y += MARGIN;
         _loc3_.y = MARGIN;
         _loc3_.x = _loc2_.x + _loc2_.width + MARGIN;
         _loc1_.addChild(_loc2_);
         _loc1_.addChild(_loc3_);
         _loc1_.height = INPUT_HEIGHT + 2 * MARGIN;
         return _loc1_;
      }
      
      private function needAdditionalCorrection() : Boolean
      {
         var _loc1_:String = Capabilities.os;
         return _loc1_.indexOf("Windows") >= 0 || _loc1_.indexOf("Mac") >= 0;
      }
      
      private function createSetEmailPanel(param1:String) : DisplayObject
      {
         var _loc2_:HorizontalStackPanel = new HorizontalStackPanel();
         _loc2_.setMargin(MARGIN);
         var _loc3_:LabelBase = this.createLabel(localeService.getText(TanksLocale.TEXT_SETTINGS_EMAIL_LABEL_TEXT));
         this.setEmailButton = new DefaultButtonBase();
         this.setEmailButton.label = localeService.getText(TanksLocale.TEXT_SETTINGS_LINK_EMAIL_BUTTON);
         this.setEmailButton.addEventListener(MouseEvent.CLICK,this.onClickSetEmailButton);
         this.emailInput = new TankInput();
         this.emailInput.value = param1;
         this.emailInput.validValue = true;
         this.emailInput.width = SettingsWindow.TAB_VIEW_MAX_WIDTH - 4 * MARGIN - _loc3_.width - this.setEmailButton.width;
         if(localeService.language == LocaleServiceLangValues.CN)
         {
            this.emailInput.width += 3;
            if(this.needAdditionalCorrection())
            {
               this.emailInput.width -= 4;
            }
         }
         _loc2_.addItem(_loc3_);
         _loc2_.addItem(this.emailInput);
         _loc2_.addItem(this.setEmailButton);
         return _loc2_;
      }
      
      private function createLabel(param1:String) : LabelBase
      {
         var _loc2_:LabelBase = new LabelBase();
         _loc2_.text = param1;
         _loc2_.y = Math.round((INPUT_HEIGHT - _loc2_.textHeight) * 0.5) - 2;
         return _loc2_;
      }
      
      private function onClickSaveAntiAddictionInfo(param1:MouseEvent) : void
      {
         if(this.realName != "" && this.idNumber != "")
         {
            dispatchEvent(new AccountSettingsEvent(AccountSettingsEvent.SET_ANTI_ADDICTION));
         }
      }
      
      private function onClickSetEmailButton(param1:MouseEvent) : void
      {
         if(!this.emailConfirmed && this.email != null)
         {
            dispatchEvent(new AccountSettingsEvent(AccountSettingsEvent.SET_EMAIL));
         }
      }
      
      private function onClickChangePassword(param1:MouseEvent = null) : void
      {
         if(this.emailConfirmed || !this.oldPassword.visible || this.getOldPassword() == "" && this.password == "")
         {
            dispatchEvent(new AccountSettingsEvent(AccountSettingsEvent.CHANGE_PASSWORD));
         }
         else
         {
            dispatchEvent(new AccountSettingsEvent(AccountSettingsEvent.CHECK_PASSWORD));
         }
      }
      
      override public function show() : void
      {
         display.stage.addEventListener(Event.RESIZE,this.onResizeStage);
         this.onResizeStage();
         this.showHelpers();
      }
      
      override public function hide() : void
      {
         this.hideHelpers();
         display.stage.removeEventListener(Event.RESIZE,this.onResizeStage);
      }
      
      private function hideHelpers() : void
      {
         helperService.hideHelper(HELPER_GROUP_KEY,PASSWORD_IS_TOO_EASY);
         helperService.hideHelper(HELPER_GROUP_KEY,PASSWORDS_DO_NOT_MATCH);
         helperService.hideHelper(HELPER_GROUP_KEY,ERROR_EMAIL_INVALID);
      }
      
      private function showHelpers() : void
      {
         if(this.emailInput != null)
         {
            this.updateEmailInput();
         }
         if(!this.emailConfirmed && this.pass1 != null)
         {
            this.updatePasswordBlock();
         }
      }
      
      private function updateEmailInput(param1:Event = null) : void
      {
         if(Boolean(partnersService.isRunningInsidePartnerEnvironment()) || this.emailConfirmed)
         {
            return;
         }
         var _loc2_:Boolean = true;
         if(this.emailInput.value.length > 0)
         {
            _loc2_ = Boolean(validateService.isEmailValid(this.emailInput.value));
         }
         if(!_loc2_)
         {
            helperService.showHelper(HELPER_GROUP_KEY,ERROR_EMAIL_INVALID,true);
         }
         else
         {
            helperService.hideHelper(HELPER_GROUP_KEY,ERROR_EMAIL_INVALID);
         }
         if(_loc2_)
         {
            this.emailInput.validValue = true;
            this.emailState = this.emailInput.value == "" ? CallsignIconStates.CALLSIGN_ICON_STATE_OFF : CallsignIconStates.CALLSIGN_ICON_STATE_VALID;
         }
         else
         {
            this.emailInput.validValue = false;
            this.emailState = CallsignIconStates.CALLSIGN_ICON_STATE_INVALID;
         }
         this.setEmailButton.enable = _loc2_;
      }
      
      private function updatePasswordBlock(param1:Event = null) : void
      {
         if(Boolean(partnersService.isRunningInsidePartnerEnvironment()) || this.emailConfirmed)
         {
            return;
         }
         this.pass1.validValue = isPasswordValid(this.pass1.value);
         this.pass1State = CallsignIconStates.CALLSIGN_ICON_STATE_INVALID;
         var _loc2_:Boolean = true;
         this.pass2.validValue = this.pass2.value == "" || this.pass1.value == this.pass2.value;
         this.pass2State = CallsignIconStates.CALLSIGN_ICON_STATE_INVALID;
         if(this.pass1.value == "")
         {
            this.pass1State = CallsignIconStates.CALLSIGN_ICON_STATE_OFF;
            _loc2_ = false;
         }
         else if(this.pass1.validValue)
         {
            this.pass1State = CallsignIconStates.CALLSIGN_ICON_STATE_VALID;
            _loc2_ = false;
         }
         if(this.pass2.value == "")
         {
            this.pass2State = CallsignIconStates.CALLSIGN_ICON_STATE_OFF;
         }
         else if(this.pass2.validValue)
         {
            this.pass2State = CallsignIconStates.CALLSIGN_ICON_STATE_VALID;
         }
         var _loc3_:Boolean = !(_loc2_ || this.pass2.validValue);
         if(_loc2_)
         {
            helperService.showHelper(HELPER_GROUP_KEY,PASSWORD_IS_TOO_EASY,true);
         }
         else
         {
            helperService.hideHelper(HELPER_GROUP_KEY,PASSWORD_IS_TOO_EASY);
         }
         if(_loc3_)
         {
            helperService.showHelper(HELPER_GROUP_KEY,PASSWORDS_DO_NOT_MATCH,true);
         }
         else
         {
            helperService.hideHelper(HELPER_GROUP_KEY,PASSWORDS_DO_NOT_MATCH);
         }
         this.changePasswordButton.enable = this.pass1.value == this.pass2.value && this.pass1.validValue && this.pass2.validValue;
      }
      
      private function createSNPanel() : TankWindowInner
      {
         var _loc3_:LabelBase = null;
         var _loc4_:Bitmap = null;
         var _loc5_:Bitmap = null;
         var _loc6_:Boolean = false;
         var _loc1_:TankWindowInner = new TankWindowInner(SettingsWindow.TAB_VIEW_MAX_WIDTH,0,TankWindowInner.TRANSPARENT);
         this.multiSNMode = Boolean(socialNetworkService.snEnabledInCurrentLocale(VKONTAKTE)) && Boolean(socialNetworkService.snEnabledInCurrentLocale(FACEBOOK));
         var _loc2_:Sprite = new Sprite();
         if(this.multiSNMode)
         {
            _loc3_ = new LabelBase();
            _loc3_.text = localeService.getText(TanksLocale.TEXT_SETTINGS_ACCOUNT_ACCESS);
            _loc3_.y = 5;
            _loc2_.addChild(_loc3_);
            _loc4_ = SocialNetworkIcon.createVk();
            _loc5_ = SocialNetworkIcon.createFb();
            this.vkButton = new DefaultButtonBase();
            this.fbButton = new DefaultButtonBase();
            _loc4_.y = _loc3_.y + _loc3_.height + MARGIN;
            _loc2_.addChild(_loc4_);
            this.vkButton.label = socialNetworkService.snLinkExists(VKONTAKTE) ? localeService.getText(TanksLocale.TEXT_SETTINGS_UNLINK) : localeService.getText(TanksLocale.TEXT_SETTINGS_LINK);
            this.vkButton.y = _loc3_.y + _loc3_.height + MARGIN;
            this.vkButton.x = _loc4_.x + _loc4_.width + MARGIN;
            _loc2_.addChild(this.vkButton);
            _loc5_.x = this.vkButton.x + this.vkButton.width + 5 * MARGIN;
            _loc5_.y = _loc3_.y + _loc3_.height + MARGIN;
            _loc2_.addChild(_loc5_);
            this.fbButton.label = socialNetworkService.snLinkExists(FACEBOOK) ? localeService.getText(TanksLocale.TEXT_SETTINGS_UNLINK) : localeService.getText(TanksLocale.TEXT_SETTINGS_LINK);
            this.fbButton.y = _loc3_.y + _loc3_.height + MARGIN;
            this.fbButton.x = _loc5_.x + _loc5_.width + MARGIN;
            _loc2_.addChild(this.fbButton);
            _loc3_.x = (_loc2_.width - _loc3_.width) / 2;
            this.vkButton.addEventListener(MouseEvent.CLICK,this.onVkChangeStateClick);
            this.fbButton.addEventListener(MouseEvent.CLICK,this.onFbChangeStateClick);
         }
         else
         {
            this.currentSN = socialNetworkService.snEnabledInCurrentLocale(VKONTAKTE) ? VKONTAKTE : FACEBOOK;
            _loc6_ = Boolean(socialNetworkService.snLinkExists(this.currentSN));
            this.snHasLinkLabel = new LabelBase();
            this.snHasLinkLabel.text = _loc6_ ? localeService.getText(TanksLocale.TEXT_SETTINGS_UNLINK_ACCOUNT) : localeService.getText(TanksLocale.TEXT_SETTINGS_LINK_ACCOUNT);
            _loc2_.addChild(this.snHasLinkLabel);
            this.snButton = this.currentSN == VKONTAKTE ? new VKButton() : new FBButton();
            this.snButton.width = 102;
            this.snButton.x = this.snHasLinkLabel.x + this.snHasLinkLabel.width + 5;
            this.snHasLinkLabel.y = this.snButton.y + 7;
            _loc2_.addChild(this.snButton);
            _loc2_.y = MARGIN;
            this.snButton.addEventListener(MouseEvent.CLICK,this.onChangeLinkStateClick);
         }
         _loc2_.x = (SettingsWindow.TAB_VIEW_MAX_WIDTH - _loc2_.width) / 2;
         _loc1_.height = _loc2_.height + 2 * MARGIN;
         _loc1_.addChild(_loc2_);
         socialNetworkService.addEventListener(SocialNetworkServiceEvent.UNLINK_SUCCESS,this.onUnlinkSuccess);
         socialNetworkService.addEventListener(SocialNetworkServiceEvent.LINK_SUCCESS,this.onLinkSuccess);
         return _loc1_;
      }
      
      private function onLinkSuccess(param1:SocialNetworkServiceEvent) : void
      {
         if(this.multiSNMode)
         {
            this.changeButtonText(param1.socialNetworkId,true);
         }
         else
         {
            this.snHasLinkLabel.text = localeService.getText(TanksLocale.TEXT_SETTINGS_UNLINK_ACCOUNT);
            this.snButton.x = this.snHasLinkLabel.x + this.snHasLinkLabel.width + 5;
         }
      }
      
      private function onUnlinkSuccess(param1:SocialNetworkServiceEvent) : void
      {
         if(this.multiSNMode)
         {
            this.changeButtonText(param1.socialNetworkId,false);
         }
         else
         {
            this.snHasLinkLabel.text = localeService.getText(TanksLocale.TEXT_SETTINGS_LINK_ACCOUNT);
            this.snButton.x = this.snHasLinkLabel.x + this.snHasLinkLabel.width + 5;
         }
      }
      
      private function changeButtonText(param1:String, param2:Boolean) : void
      {
         if(param1 == VKONTAKTE)
         {
            this.vkButton.label = localeService.getText(param2 ? TanksLocale.TEXT_SETTINGS_UNLINK : TanksLocale.TEXT_SETTINGS_LINK);
         }
         else
         {
            this.fbButton.label = localeService.getText(param2 ? TanksLocale.TEXT_SETTINGS_UNLINK : TanksLocale.TEXT_SETTINGS_LINK);
         }
      }
      
      private function onChangeLinkStateClick(param1:MouseEvent) : void
      {
         this.changeSNState(this.currentSN);
      }
      
      private function onVkChangeStateClick(param1:MouseEvent) : void
      {
         this.changeSNState(VKONTAKTE);
      }
      
      private function onFbChangeStateClick(param1:MouseEvent) : void
      {
         this.changeSNState(FACEBOOK);
      }
      
      private function changeSNState(param1:String) : void
      {
         if(socialNetworkService.snLinkExists(param1))
         {
            socialNetworkService.unlink(param1);
         }
         else
         {
            socialNetworkService.createLink(param1);
         }
      }
      
      private function initEvents() : void
      {
         this.pass1.addEventListener(FocusEvent.FOCUS_IN,restoreInput);
         this.pass2.addEventListener(FocusEvent.FOCUS_IN,restoreInput);
         this.emailInput.addEventListener(FocusEvent.FOCUS_IN,restoreInput);
         this.pass1.addEventListener(Event.CHANGE,this.updatePasswordBlock);
         this.pass1.addEventListener(FocusEvent.FOCUS_IN,this.updatePasswordBlock);
         this.pass2.addEventListener(Event.CHANGE,this.updatePasswordBlock);
         this.pass2.addEventListener(FocusEvent.FOCUS_IN,this.updatePasswordBlock);
         this.emailInput.addEventListener(FocusEvent.FOCUS_IN,this.updateEmailInput);
         this.emailInput.addEventListener(Event.CHANGE,this.updateEmailInput);
         this.oldPassword.addEventListener(FocusEvent.FOCUS_IN,this.restoreOldPasswordInput);
         this.oldPassword.addEventListener(Event.CHANGE,this.restoreOldPasswordInput);
      }
      
      private function validateRealName(param1:LoginFormEvent) : void
      {
         var _loc2_:String = null;
         if(this.realNameInput != null)
         {
            _loc2_ = trimString(this.realNameInput.textField.text);
            this.realNameInput.validValue = Boolean(validateService.isChinaNameValid(_loc2_)) || _loc2_.length == 0;
         }
      }
      
      private function validateAddictionID(param1:LoginFormEvent) : void
      {
         var _loc2_:String = null;
         if(this.idNumberInput != null)
         {
            _loc2_ = this.idNumberInput.textField.text;
            this.idNumberInput.validValue = Boolean(validateService.isChinaCardIdValid(_loc2_)) || _loc2_.length == 0;
         }
      }
      
      private function onClickChangePasswordOnEmail(param1:MouseEvent) : void
      {
         dispatchEvent(new AccountSettingsEvent(AccountSettingsEvent.CHANGE_PASSWORD_BY_EMAIL));
      }
      
      public function disableChangePasswordPanel() : void
      {
         this.changePasswordOnEmailButton.enable = false;
         if(Boolean(this.captchaSection))
         {
            this.captchaSection.setEnabled(false);
         }
      }
      
      private function restoreOldPasswordInput(param1:Event) : void
      {
         this.oldPasswordCheckIcon.visible = false;
         this.oldPassword.validValue = true;
      }
      
      public function highlightIncorrectOldPassword() : void
      {
         this.oldPassword.validValue = false;
         this.oldPasswordCheckIcon.visible = true;
      }
      
      public function hideOldPasswordField() : void
      {
         this.oldPassword.visible = false;
      }
      
      public function set pass1State(param1:int) : void
      {
         if(param1 == CallsignIconStates.CALLSIGN_ICON_STATE_OFF)
         {
            this.pass1CheckIcon.visible = false;
         }
         else
         {
            this.pass1CheckIcon.visible = true;
            this.pass1CheckIcon.gotoAndStop(param1);
         }
      }
      
      public function set pass2State(param1:int) : void
      {
         if(param1 == CallsignIconStates.CALLSIGN_ICON_STATE_OFF)
         {
            this.pass2CheckIcon.visible = false;
         }
         else
         {
            this.pass2CheckIcon.visible = true;
            this.pass2CheckIcon.gotoAndStop(param1);
         }
      }
      
      public function set emailState(param1:int) : void
      {
         if(param1 == CallsignIconStates.CALLSIGN_ICON_STATE_OFF)
         {
            this.emailCheckIcon.visible = false;
         }
         else
         {
            this.emailCheckIcon.visible = true;
            this.emailCheckIcon.gotoAndStop(param1);
         }
      }
      
      private function createBubbles() : void
      {
         this.passwordIsTooEasyBubble = new PasswordIsTooEasyBubble();
         this.passwordsDoNotMatchBubble = new PasswordsDoNotMatchBubble();
         this.errorEmailInvalodBubble = new EmailInvalidBubble();
         helperService.registerHelper(HELPER_GROUP_KEY,PASSWORD_IS_TOO_EASY,this.passwordIsTooEasyBubble,false);
         helperService.registerHelper(HELPER_GROUP_KEY,PASSWORDS_DO_NOT_MATCH,this.passwordsDoNotMatchBubble,false);
         helperService.registerHelper(HELPER_GROUP_KEY,ERROR_EMAIL_INVALID,this.errorEmailInvalodBubble,false);
      }
      
      private function onResizeStage(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         if(parent != null)
         {
            _loc2_ = INPUT_HEIGHT + 3 * MARGIN;
            if(this.passwordIsTooEasyBubble != null)
            {
               this.passwordIsTooEasyBubble.targetPoint = new Point(this.pass1CheckIcon.x + this.pass1CheckIcon.width / 2 + this.x + parent.x,_loc2_ + this.pass1CheckIcon.y + this.pass1CheckIcon.height / 2 + this.y + parent.y);
            }
            if(this.passwordsDoNotMatchBubble != null)
            {
               this.passwordsDoNotMatchBubble.targetPoint = new Point(this.pass2CheckIcon.x + this.pass2CheckIcon.width / 2 + this.x + parent.x,_loc2_ + this.pass2CheckIcon.y + this.pass2CheckIcon.height / 2 + this.y + parent.y);
            }
            if(this.errorEmailInvalodBubble != null)
            {
               this.errorEmailInvalodBubble.targetPoint = new Point(this.emailCheckIcon.x + this.emailCheckIcon.width / 2 + this.x + parent.x,_loc2_ + this.emailCheckIcon.y + this.emailCheckIcon.height / 2 + this.y + parent.y);
            }
         }
      }
      
      public function get password() : String
      {
         var _loc1_:String = "";
         if(!this.emailConfirmed)
         {
            if(Boolean(this.pass1.textField.text))
            {
               if(this.pass1.textField.text == this.pass2.textField.text)
               {
                  _loc1_ = this.pass1.textField.text;
               }
            }
         }
         return _loc1_;
      }
      
      public function get email() : String
      {
         if(this.emailConfirmed)
         {
            return "";
         }
         if(this.emailInput.textField.text.indexOf("*") != -1)
         {
            return null;
         }
         return this.emailInput.textField.text;
      }
      
      public function get realName() : String
      {
         if(this.realNameInput != null && this.realNameInput.textField.text != null && trimString(this.realNameInput.textField.text).length > 0)
         {
            return this.realNameInput.textField.text;
         }
         return "";
      }
      
      public function get idNumber() : String
      {
         if(this.idNumberInput != null && this.idNumberInput.textField.text != null && trimString(this.idNumberInput.textField.text).length > 0)
         {
            return this.idNumberInput.textField.text;
         }
         return "";
      }
      
      public function getOldPassword() : String
      {
         return this.oldPassword != null ? this.oldPassword.value : "";
      }
      
      override public function destroy() : void
      {
         if(!this.emailConfirmed)
         {
            this.changePasswordButton.removeEventListener(MouseEvent.CLICK,this.onClickChangePassword);
            this.setEmailButton.removeEventListener(MouseEvent.CLICK,this.onClickSetEmailButton);
            this.pass1.removeEventListener(FocusEvent.FOCUS_IN,restoreInput);
            this.pass2.removeEventListener(FocusEvent.FOCUS_IN,restoreInput);
            this.emailInput.removeEventListener(FocusEvent.FOCUS_IN,restoreInput);
            this.pass1.removeEventListener(Event.CHANGE,this.updatePasswordBlock);
            this.pass1.removeEventListener(FocusEvent.FOCUS_IN,this.updatePasswordBlock);
            this.pass2.removeEventListener(Event.CHANGE,this.updatePasswordBlock);
            this.pass2.removeEventListener(FocusEvent.FOCUS_IN,this.updatePasswordBlock);
            this.emailInput.removeEventListener(FocusEvent.FOCUS_IN,this.updateEmailInput);
            this.emailInput.removeEventListener(Event.CHANGE,this.updateEmailInput);
            this.oldPassword.removeEventListener(FocusEvent.FOCUS_IN,this.restoreOldPasswordInput);
            this.oldPassword.removeEventListener(Event.CHANGE,this.restoreOldPasswordInput);
         }
         if(Boolean(this.saveAntiAddictionInfoButton))
         {
            this.saveAntiAddictionInfoButton.removeEventListener(MouseEvent.CLICK,this.onClickSaveAntiAddictionInfo);
         }
         helperService.unregisterHelper(HELPER_GROUP_KEY,PASSWORD_IS_TOO_EASY);
         helperService.unregisterHelper(HELPER_GROUP_KEY,PASSWORDS_DO_NOT_MATCH);
         helperService.unregisterHelper(HELPER_GROUP_KEY,ERROR_EMAIL_INVALID);
         if(!this.emailConfirmed)
         {
            this.oldPassword.removeEventListener(FocusEvent.FOCUS_IN,this.restoreOldPasswordInput);
            this.oldPassword.removeEventListener(Event.CHANGE,this.restoreOldPasswordInput);
         }
         super.destroy();
      }
   }
}

