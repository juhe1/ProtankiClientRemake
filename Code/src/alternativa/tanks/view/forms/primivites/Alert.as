package alternativa.tanks.view.forms.primivites
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.locale.ILocaleService;
   import controls.TankWindow;
   import controls.base.DefaultButtonBase;
   import controls.base.LabelBase;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import flash.ui.Keyboard;
   import forms.events.AlertEvent;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import services.alertservice.AlertAnswer;
   
   public class Alert extends Sprite
   {
      
      public static var localeService:ILocaleService = OSGi.getInstance().getService(ILocaleService) as ILocaleService;
      
      public static const ALERT_QUIT:int = 0;
      
      public static const ALERT_CONFIRM_EMAIL:int = 1;
      
      public static const ERROR_CALLSIGN_FIRST_SYMBOL:int = 2;
      
      public static const ERROR_CALLSIGN_DEVIDE:int = 3;
      
      public static const ERROR_CALLSIGN_LAST_SYMBOL:int = 4;
      
      public static const ERROR_CALLSIGN_LENGTH:int = 5;
      
      public static const ERROR_CALLSIGN_UNIQUE:int = 6;
      
      public static const ERROR_PASSWORD_LENGTH:int = 7;
      
      public static const ERROR_PASSWORD_INCORRECT:int = 8;
      
      public static const ERROR_PASSWORD_CHANGE:int = 9;
      
      public static const ERROR_EMAIL_UNIQUE:int = 10;
      
      public static const ERROR_EMAIL_INVALID:int = 11;
      
      public static const ERROR_EMAIL_NOTFOUND:int = 12;
      
      public static const ERROR_EMAIL_NOTSENDED:int = 13;
      
      public static const ERROR_FATAL:int = 14;
      
      public static const ERROR_FATAL_DEBUG:int = 15;
      
      public static const GARAGE_AVAILABLE:int = 16;
      
      public static const ALERT_RECOVERY_LINK_SENDED:int = 17;
      
      public static const ALERT_CHAT_PROCEED:int = 18;
      
      public static const CAPTCHA_INCORRECT:int = 19;
      
      public static const ERROR_CONFIRM_EMAIL:int = 20;
      
      protected var bgWindow:TankWindow = new TankWindow();
      
      private var output:LabelBase;
      
      private var message:String;
      
      private var labels:Vector.<String>;
      
      protected var alertWindow:Sprite = new Sprite();
      
      public var closeButton:MainPanelCloseButton = new MainPanelCloseButton();
      
      private var closable:Boolean = false;
      
      private const alerts:Array = new Array();
      
      private var id:int;
      
      public function Alert(param1:int = -1, param2:Boolean = false)
      {
         super();
         this.closable = param2;
         this.id = param1;
         this.init();
      }
      
      private static function isConfirmationKey(param1:KeyboardEvent) : Boolean
      {
         return [Keyboard.SPACE,Keyboard.ENTER].indexOf(param1.keyCode) >= 0;
      }
      
      private static function isCancelKey(param1:KeyboardEvent) : Boolean
      {
         return [Keyboard.ESCAPE,Keyboard.BACKSPACE].indexOf(param1.keyCode) >= 0;
      }
      
      public function init() : void
      {
         this.bgWindow.headerLang = localeService.getText(TanksLocale.TEXT_GUI_LANG);
         if(AlertAnswer.YES == null)
         {
            this.fillButtonLabels();
         }
         this.initStandardAlerts(localeService);
         if(this.id > -1)
         {
            this.showAlert(this.alerts[this.id][0],this.alerts[this.id][1]);
         }
         this.createOutput();
      }
      
      private function initStandardAlerts(param1:ILocaleService) : void
      {
         this.alerts[ALERT_QUIT] = [param1.getText(TanksLocale.TEXT_ALERT_QUIT_TEXT),Vector.<String>([AlertAnswer.YES,AlertAnswer.NO])];
         this.alerts[ALERT_CONFIRM_EMAIL] = [param1.getText(TanksLocale.TEXT_ALERT_EMAIL_CONFIRMED),Vector.<String>([AlertAnswer.YES])];
         this.alerts[ERROR_FATAL] = [param1.getText(TanksLocale.TEXT_ERROR_FATAL),Vector.<String>([AlertAnswer.RETURN])];
         this.alerts[ERROR_FATAL_DEBUG] = [param1.getText(TanksLocale.TEXT_ERROR_FATAL_DEBUG),Vector.<String>([AlertAnswer.SEND])];
         this.alerts[ERROR_CALLSIGN_FIRST_SYMBOL] = [param1.getText(TanksLocale.TEXT_ERROR_CALLSIGN_WRONG_FIRST_SYMBOL),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_CALLSIGN_DEVIDE] = [param1.getText(TanksLocale.TEXT_ERROR_CALLSIGN_NOT_SINGLE_DEVIDERS),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_CALLSIGN_LAST_SYMBOL] = [param1.getText(TanksLocale.TEXT_ERROR_CALLSIGN_WRONG_LAST_SYMBOL),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_CALLSIGN_LENGTH] = [param1.getText(TanksLocale.TEXT_ERROR_CALLSIGN_LENGTH),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_CALLSIGN_UNIQUE] = [param1.getText(TanksLocale.TEXT_ERROR_CALLSIGN_NOT_UNIQUE),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_EMAIL_UNIQUE] = [param1.getText(TanksLocale.TEXT_ERROR_EMAIL_NOT_UNIQUE),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_EMAIL_INVALID] = [param1.getText(TanksLocale.TEXT_ERROR_EMAIL_INVALID),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_EMAIL_NOTFOUND] = [param1.getText(TanksLocale.TEXT_ERROR_EMAIL_NOT_FOUND),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_EMAIL_NOTSENDED] = [param1.getText(TanksLocale.TEXT_ERROR_EMAIL_NOT_SENDED),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_PASSWORD_INCORRECT] = [param1.getText(TanksLocale.TEXT_ERROR_PASSWORD_INCORRECT),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_PASSWORD_LENGTH] = [param1.getText(TanksLocale.TEXT_ERROR_PASSWORD_LENGTH),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_PASSWORD_CHANGE] = [param1.getText(TanksLocale.TEXT_ERROR_PASSWORD_CHANGE),Vector.<String>([AlertAnswer.OK])];
         this.alerts[GARAGE_AVAILABLE] = [param1.getText(TanksLocale.TEXT_ALERT_GARAGE_AVAILABLE),Vector.<String>([AlertAnswer.GARAGE,AlertAnswer.CANCEL])];
         this.alerts[ALERT_RECOVERY_LINK_SENDED] = [param1.getText(TanksLocale.TEXT_SETTINGS_CHANGE_PASSWORD_CONFIRMATION_SENT_TEXT),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ALERT_CHAT_PROCEED] = [param1.getText(TanksLocale.TEXT_ALERT_CHAT_PROCEED_EXTERNAL_LINK),Vector.<String>([AlertAnswer.CANCEL])];
         this.alerts[CAPTCHA_INCORRECT] = [param1.getText(TanksLocale.TEXT_CAPTCHA_INCORRECT),Vector.<String>([AlertAnswer.OK])];
         this.alerts[ERROR_CONFIRM_EMAIL] = [param1.getText(TanksLocale.TEXT_ALERT_EMAIL_CONFIRMED_WRONG_LINK),Vector.<String>([AlertAnswer.OK])];
      }
      
      private function fillButtonLabels() : void
      {
         AlertAnswer.YES = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES);
         AlertAnswer.NO = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_NO);
         AlertAnswer.OK = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK);
         AlertAnswer.CANCEL = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_CANCEL);
         AlertAnswer.SEND = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_SEND_BUG_REPORT);
         AlertAnswer.RETURN = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_RETURN_TO_BATTLE);
         AlertAnswer.GARAGE = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_GO_TO_GARAGE);
         AlertAnswer.PROCEED = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_PROCEED);
      }
      
      private function createOutput() : void
      {
         this.output = new LabelBase();
         this.output.autoSize = TextFieldAutoSize.CENTER;
         this.output.align = TextFormatAlign.CENTER;
         this.output.size = 13;
         this.output.width = 10;
         this.output.height = 10;
         this.output.x = -5;
         this.output.y = 30;
         this.output.multiline = true;
      }
      
      public function showAlert(param1:String, param2:Vector.<String>) : void
      {
         this.message = param1;
         this.labels = param2;
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.drawBackground();
         this.doLayout(param1);
      }
      
      protected function doLayout(param1:Event) : void
      {
         var _loc4_:DefaultButtonBase = null;
         var _loc5_:int = 0;
         var _loc2_:int = this.calculateButtonsWidth();
         var _loc3_:int = _loc2_ * this.labels.length / 2;
         addChild(this.alertWindow);
         this.alertWindow.addChild(this.bgWindow);
         this.alertWindow.addChild(this.output);
         this.output.htmlText = this.message;
         if(this.labels.length != 0)
         {
            _loc5_ = 0;
            while(_loc5_ < this.labels.length)
            {
               _loc4_ = new DefaultButtonBase();
               _loc4_.label = this.labels[_loc5_];
               _loc4_.x = _loc2_ * _loc5_ - _loc3_;
               _loc4_.y = this.output.y + this.output.height + 15;
               _loc4_.width = _loc2_ - 6;
               _loc4_.addEventListener(MouseEvent.CLICK,this.close);
               this.alertWindow.addChild(_loc4_);
               _loc5_++;
            }
            this.bgWindow.height = _loc4_.y + 60;
         }
         else
         {
            this.bgWindow.height = this.output.y + this.output.height + 30;
         }
         this.bgWindow.width = Math.max(int(this.output.width + 50),_loc3_ * 2 + 50);
         this.bgWindow.x = -int(this.bgWindow.width / 2) - 3;
         stage.addEventListener(Event.RESIZE,this.onStageResize);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         stage.focus = this;
         if(this.closable)
         {
            this.alertWindow.addChild(this.closeButton);
            this.closeButton.x = this.bgWindow.x + this.bgWindow.width - this.closeButton.width - 10;
            this.closeButton.y = 10;
            this.closeButton.addEventListener(MouseEvent.CLICK,this.close);
         }
         this.onStageResize(null);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:String = null;
         if(this.labels.length == 2)
         {
            if(isConfirmationKey(param1))
            {
               _loc2_ = this.getFirstExistingLabel([AlertAnswer.OK,AlertAnswer.YES,AlertAnswer.GARAGE,AlertAnswer.PROCEED,AlertAnswer.SEND]);
            }
            else if(isCancelKey(param1))
            {
               _loc2_ = this.getFirstExistingLabel([AlertAnswer.NO,AlertAnswer.CANCEL,AlertAnswer.RETURN]);
            }
         }
         else
         {
            _loc2_ = this.getFirstExistingLabel([AlertAnswer.YES,AlertAnswer.SEND,AlertAnswer.RETURN,AlertAnswer.OK,AlertAnswer.CANCEL]);
         }
         this.dispatchClickEventForButtonWithLabel(_loc2_);
      }
      
      private function getFirstExistingLabel(param1:Array) : String
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.labels.length)
         {
            _loc3_ = int(param1.indexOf(this.labels[_loc2_]));
            if(_loc3_ > -1)
            {
               return param1[_loc3_];
            }
            _loc2_++;
         }
         return "";
      }
      
      private function dispatchClickEventForButtonWithLabel(param1:String) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.alertWindow.numChildren)
         {
            _loc3_ = this.alertWindow.getChildAt(_loc2_);
            if(_loc3_ is DefaultButtonBase && DefaultButtonBase(_loc3_).label == param1)
            {
               _loc3_.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               return;
            }
            _loc2_++;
         }
      }
      
      private function calculateButtonsWidth() : int
      {
         var _loc1_:int = 80;
         var _loc2_:LabelBase = new LabelBase();
         var _loc3_:int = 0;
         while(_loc3_ < this.labels.length)
         {
            _loc2_.text = this.labels[_loc3_];
            if(_loc2_.width > _loc1_)
            {
               _loc1_ = _loc2_.width;
            }
            _loc3_++;
         }
         return _loc1_ + 18;
      }
      
      private function onStageResize(param1:Event) : void
      {
         this.alertWindow.x = int(stage.stageWidth / 2);
         this.alertWindow.y = int(stage.stageHeight / 2 - this.alertWindow.height / 2);
         this.drawBackground();
      }
      
      private function drawBackground() : void
      {
         graphics.clear();
         graphics.beginFill(0,0.5);
         graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
         graphics.endFill();
      }
      
      private function close(param1:MouseEvent) : void
      {
         stage.removeEventListener(Event.RESIZE,this.onStageResize);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.removeMouseListenerFromButtons();
         var _loc2_:DefaultButtonBase = param1.currentTarget as DefaultButtonBase;
         if(_loc2_ != null)
         {
            dispatchEvent(new AlertEvent(_loc2_.label));
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      private function removeMouseListenerFromButtons() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.alertWindow.numChildren)
         {
            _loc2_ = this.alertWindow.getChildAt(_loc1_);
            if(_loc2_ is DefaultButtonBase || _loc2_ == this.closeButton)
            {
               _loc2_.removeEventListener(MouseEvent.CLICK,this.close);
            }
            _loc1_++;
         }
      }
   }
}

