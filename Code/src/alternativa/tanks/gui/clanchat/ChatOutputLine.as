package alternativa.tanks.gui.clanchat
{
   import alternativa.tanks.gui.chat.ChatLineHighlightNormal;
   import controls.TankWindowInner;
   import controls.base.LabelBase;
   import controls.statassets.StatLineBase;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.text.TextFormatAlign;
   import forms.ColorConstants;
   import forms.userlabel.ChatUserLabel;
   import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;
   import projects.tanks.client.chat.types.MessageType;
   import projects.tanks.client.chat.types.UserStatus;
   import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
   
   public class ChatOutputLine extends Sprite
   {
      
      private static const SYSTEM_MESSAGE_COLOR:uint = 8454016;
      
      private static const WARNING_MESSAGE_COLOR:uint = 16776960;
      
      private static const DEFAULT_MESSAGE_COLOR:uint = ColorConstants.WHITE;
      
      private static const UID_COLOR_WITHOUT_LIGHT:uint = 1244928;
      
      private static const UID_COLOR_WITH_LIGHT:uint = 5898034;
      
      private static const PRIVATE_MESSAGE_MARK:String = "→";
      
      private static const PUBLIC_MESSAGE_MARK:String = "—";
      
      private var _output:LabelBase;
      
      private var _timePassed:LabelBase;
      
      private var _userName:String;
      
      private var _userNameTo:String;
      
      private var _sourceUserLabel:ChatUserLabel;
      
      private var _targetUserLabel:ChatUserLabel;
      
      private var _arrowLabel:LabelBase;
      
      private var _light:Boolean = false;
      
      private var _self:Boolean = false;
      
      private var _namesWidth:int = 0;
      
      private var _messageType:MessageType;
      
      private var _showIP:Boolean;
      
      private var _width:int;
      
      private var _background:Bitmap;
      
      public var addressMode:ChatAddressMode;
      
      public function ChatOutputLine(param1:int, param2:UserStatus, param3:UserStatus, param4:ChatAddressMode, param5:String, param6:Date, param7:MessageType, param8:Boolean, param9:String)
      {
         super();
         this._width = param1;
         this._messageType = param7;
         this.addressMode = param4;
         mouseEnabled = false;
         this._background = new Bitmap();
         addChild(this._background);
         if(param7 == MessageType.USER)
         {
            this._timePassed = new LabelBase();
            this._timePassed.text = DateFormatter.formatTimeForChatToLocalized(param6);
            addChild(this._timePassed);
         }
         if(param2.userId != null)
         {
            this._userName = param2.uid;
            this._sourceUserLabel = new ClanChatUserLabel(param2,param9);
            addChild(this._sourceUserLabel);
            this._sourceUserLabel.setUidColor(UID_COLOR_WITHOUT_LIGHT);
            this.updateSourceUserLabel(param3.userId == null);
         }
         if(param3.userId != null)
         {
            this._userNameTo = param3.uid;
            this._targetUserLabel = new ClanChatUserLabel(param3,param9);
            addChild(this._targetUserLabel);
            this._targetUserLabel.setUidColor(UID_COLOR_WITHOUT_LIGHT);
            this._arrowLabel = new LabelBase();
            addChild(this._arrowLabel);
            this._arrowLabel.text = param4 == ChatAddressMode.PRIVATE ? PRIVATE_MESSAGE_MARK : PUBLIC_MESSAGE_MARK;
            this._arrowLabel.color = param4 == ChatAddressMode.PRIVATE ? DEFAULT_MESSAGE_COLOR : UID_COLOR_WITHOUT_LIGHT;
            this.updateTargetUserLabel();
         }
         this._output = new LabelBase();
         this._output.color = this.getMessageColor(this._messageType);
         this._output.multiline = true;
         this._output.wordWrap = true;
         this._output.correctCursorBehaviour = false;
         this._output.selectable = true;
         if(this._messageType != MessageType.USER)
         {
            this._output.align = TextFormatAlign.CENTER;
         }
         addChild(this._output);
         if(this._namesWidth > this._width / 2)
         {
            this._output.y = 15;
            this._output.x = 0;
            this._output.width = this._timePassed == null ? this._width - 5 : this._width - this._timePassed.width - 15;
         }
         else
         {
            this._output.x = this._namesWidth + 3;
            this._output.y = 0;
            this._output.width = this._timePassed == null ? this._namesWidth - 8 : this._namesWidth - this._timePassed.width - 18;
         }
         if(param8)
         {
            this._output.htmlText = param5;
         }
         else
         {
            this._output.text = param5;
         }
      }
      
      private function updateSourceUserLabel(param1:Boolean) : void
      {
         var _loc2_:String = "";
         if(param1)
         {
            _loc2_ += ":";
         }
         if(_loc2_.length != 0)
         {
            this._sourceUserLabel.setAdditionalText(_loc2_);
         }
         if(param1)
         {
            this._namesWidth = this._sourceUserLabel.width + 2;
         }
         else
         {
            this._namesWidth = this._sourceUserLabel.width + 6;
         }
      }
      
      private function updateTargetUserLabel() : void
      {
         this._targetUserLabel.setAdditionalText(":");
         this._targetUserLabel.x = this._sourceUserLabel.x + this._sourceUserLabel.width + 14;
         this._namesWidth += this._targetUserLabel.width + 11;
         this._arrowLabel.x = this._sourceUserLabel.x + this._sourceUserLabel.width - 1;
      }
      
      override public function set width(param1:Number) : void
      {
         var _loc2_:BitmapData = null;
         var _loc4_:StatLineBase = null;
         var _loc3_:int = 0;
         this._width = int(param1);
         if(this._sourceUserLabel != null)
         {
            this._sourceUserLabel.x = this._timePassed == null ? 0 : this._timePassed.width + 5;
         }
         if(this._targetUserLabel != null)
         {
            this._targetUserLabel.x = this._sourceUserLabel.x + this._sourceUserLabel.width + 14;
            this._arrowLabel.x = this._sourceUserLabel.x + this._sourceUserLabel.width - 1;
         }
         if(this._namesWidth > this._width / 2 && this._output.text.length * 8 > this._width - this._namesWidth)
         {
            this._output.y = 19;
            this._output.x = this._timePassed == null ? 0 : this._timePassed.width;
            this._output.width = this._timePassed == null ? this._width - 5 : this._width - this._timePassed.width - 5;
            _loc3_ = 21;
         }
         else
         {
            this._output.x = this._timePassed == null ? this._namesWidth : this._timePassed.width + this._namesWidth + 5;
            this._output.y = 0;
            this._output.width = this._timePassed == null ? this._width - this._namesWidth - 5 : this._width - this._timePassed.width - this._namesWidth - 5;
            this._output.height = 20;
         }
         this._background.bitmapData = new BitmapData(1,Math.max(int(this._output.textHeight + 7.5 + _loc3_),19),true,0);
         if(this._light || this._self)
         {
            _loc4_ = new ChatLineHighlightNormal();
            _loc4_.width = this._width;
            _loc4_.height = Math.max(int(this._output.textHeight + 5.5 + _loc3_),19);
            _loc4_.y = 2;
            _loc4_.graphics.beginFill(0,0);
            _loc4_.graphics.drawRect(0,0,2,2);
            _loc4_.graphics.endFill();
            _loc2_ = new BitmapData(_loc4_.width,_loc4_.height + 2,true,0);
            _loc2_.draw(_loc4_);
            this._background.bitmapData = _loc2_;
         }
      }
      
      public function set light(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         if(this._messageType != MessageType.USER)
         {
            return;
         }
         this._light = param1;
         if(this._light)
         {
            _loc2_ = UID_COLOR_WITH_LIGHT;
         }
         else
         {
            _loc2_ = UID_COLOR_WITHOUT_LIGHT;
         }
         if(this._sourceUserLabel != null)
         {
            this._sourceUserLabel.setUidColor(_loc2_);
         }
         if(this._targetUserLabel != null)
         {
            this._targetUserLabel.setUidColor(_loc2_);
         }
         this.width = this._width;
      }
      
      public function set self(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this._messageType != MessageType.USER)
         {
            return;
         }
         this._self = param1;
         if(this._self)
         {
            _loc3_ = TankWindowInner.GREEN;
            _loc2_ = TankWindowInner.GREEN;
         }
         else
         {
            _loc2_ = UID_COLOR_WITHOUT_LIGHT;
            _loc3_ = DEFAULT_MESSAGE_COLOR;
         }
         if(this._sourceUserLabel != null)
         {
            this._sourceUserLabel.setUidColor(_loc2_,this._self);
         }
         if(this._targetUserLabel != null)
         {
            this._targetUserLabel.setUidColor(_loc2_);
         }
         this._output.color = _loc3_;
         this.width = this._width;
      }
      
      public function set showIP(param1:Boolean) : void
      {
         this._showIP = param1;
         if(this._sourceUserLabel != null)
         {
            this.updateSourceUserLabel(this._targetUserLabel == null);
         }
         if(this._targetUserLabel != null)
         {
            this.updateTargetUserLabel();
         }
         this.width = this._width;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function get userNameTo() : String
      {
         return this._userNameTo;
      }
      
      private function getMessageColor(param1:MessageType) : uint
      {
         switch(param1)
         {
            case MessageType.SYSTEM:
               return SYSTEM_MESSAGE_COLOR;
            case MessageType.WARNING:
               return WARNING_MESSAGE_COLOR;
            default:
               return DEFAULT_MESSAGE_COLOR;
         }
      }
   }
}

