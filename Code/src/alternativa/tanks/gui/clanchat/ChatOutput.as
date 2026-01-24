package alternativa.tanks.gui.clanchat
{
   import fl.containers.ScrollPane;
   import fl.controls.ScrollPolicy;
   import flash.display.Sprite;
   import flash.utils.setTimeout;
   import forms.userlabel.ChatUpdateEvent;
   import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;
   import projects.tanks.client.chat.types.MessageType;
   import projects.tanks.client.chat.types.UserStatus;
   
   public class ChatOutput extends ScrollPane
   {
      
      private static const MAX_MESSAGES:int = 80;
      
      public var wasScrolled:Boolean;
      
      public var deltaWidth:int = 9;
      
      public var selfUid:String;
      
      private var container:Sprite = new Sprite();
      
      private var lineWidth:Number;
      
      private var _showIPMode:Boolean = false;
      
      private var updateIntervalId:uint = 0;
      
      public function ChatOutput()
      {
         super();
         this.source = this.container;
         this.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.focusEnabled = false;
         this.container.addEventListener(ChatUpdateEvent.UPDATE,this.onUpdateEvent);
      }
      
      public function addLine(param1:UserStatus, param2:UserStatus, param3:ChatAddressMode, param4:String, param5:Date, param6:MessageType = null, param7:Boolean = false, param8:Boolean = true) : void
      {
         var _loc9_:Boolean = false;
         if(param8)
         {
            _loc9_ = verticalScrollPosition + 5 > maxVerticalScrollPosition || !this.wasScrolled;
         }
         if(this.container.numChildren > MAX_MESSAGES)
         {
            this.shiftMessages();
         }
         var _loc10_:ChatOutputLine = new ChatOutputLine(this.lineWidth,param1,param2,param3,param4,param5,param6,param7,this.selfUid);
         _loc10_.showIP = this._showIPMode;
         _loc10_.self = _loc10_.userNameTo == this.selfUid;
         _loc10_.y = int(this.container.height + 0.5);
         this.container.addChild(_loc10_);
         update();
         if(_loc9_)
         {
            this.scrollDown();
         }
      }
      
      public function scrollDown() : void
      {
         verticalScrollPosition = maxVerticalScrollPosition;
      }
      
      public function highlightUids(param1:String) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.container.numChildren)
         {
            this.highlightLine(this.container.getChildAt(_loc2_) as ChatOutputLine,param1);
            _loc2_++;
         }
      }
      
      public function highlightUidsInLastMessage(param1:String) : void
      {
         if(this.container.numChildren > 0)
         {
            this.highlightLine(this.container.getChildAt(this.container.numChildren - 1) as ChatOutputLine,param1);
         }
      }
      
      private function highlightLine(param1:ChatOutputLine, param2:String) : void
      {
         param1.light = param1.userName == param2 || param1.addressMode == ChatAddressMode.PUBLIC_ADDRESSED && param1.userNameTo == this.selfUid;
         param1.self = param1.userNameTo == this.selfUid && param1.addressMode == ChatAddressMode.PRIVATE;
      }
      
      private function shiftMessages() : void
      {
         var _loc1_:ChatOutputLine = this.container.getChildAt(0) as ChatOutputLine;
         var _loc2_:Number = _loc1_.height + _loc1_.y;
         this.container.removeChild(_loc1_);
         var _loc3_:int = 0;
         while(_loc3_ < this.container.numChildren)
         {
            this.container.getChildAt(_loc3_).y = this.container.getChildAt(_loc3_).y - _loc2_;
            _loc3_++;
         }
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         this.lineWidth = param1 - this.deltaWidth;
         this.updateLines();
      }
      
      private function onUpdateEvent(param1:ChatUpdateEvent) : void
      {
         if(this.updateIntervalId == 0)
         {
            this.updateIntervalId = setTimeout(this.updateLines,500);
         }
      }
      
      private function updateLines() : void
      {
         var _loc2_:ChatOutputLine = null;
         var _loc3_:ChatOutputLine = null;
         this.updateIntervalId = 0;
         if(this.container.numChildren == 0)
         {
            return;
         }
         var _loc1_:Vector.<ChatOutputLine> = new Vector.<ChatOutputLine>();
         while(this.container.numChildren > 0)
         {
            _loc3_ = this.container.getChildAt(0) as ChatOutputLine;
            _loc3_.showIP = this._showIPMode;
            _loc3_.width = this.lineWidth;
            _loc1_.push(_loc3_);
            this.container.removeChildAt(0);
         }
         for each(_loc2_ in _loc1_)
         {
            _loc2_.y = int(this.container.height + 0.5);
            this.container.addChild(_loc2_);
         }
         update();
      }
      
      public function cleanOutUsersMessages(param1:String) : void
      {
         var _loc4_:ChatOutputLine = null;
         var _loc2_:Vector.<ChatOutputLine> = new Vector.<ChatOutputLine>();
         var _loc3_:int = 0;
         while(_loc3_ < this.container.numChildren)
         {
            _loc4_ = this.container.getChildAt(_loc3_) as ChatOutputLine;
            if(_loc4_.userName == param1)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            this.container.removeChild(_loc2_[_loc3_]);
            _loc3_++;
         }
         this.updateLines();
      }
      
      public function set showIPMode(param1:Boolean) : void
      {
         this._showIPMode = param1;
         this.updateLines();
      }
   }
}

