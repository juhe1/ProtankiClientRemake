package alternativa.tanks.gui.chat
{
   import alternativa.tanks.gui.communication.tabs.chat.HiddenMessageKeeper;
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
      
      public var wasScrolled:Boolean = false;
      
      public var deltaWidth:int = 9;
      
      public var selfUid:String;
      
      private var container:Sprite = new Sprite();
      
      private var lineWidth:Number;
      
      private var showIPMode:Boolean;
      
      private var privateMessagesEnabled:Boolean;
      
      private var updateIntervalId:uint = 0;
      
      private var currentChannel:String;
      
      private var messageKeeper:HiddenMessageKeeper = new HiddenMessageKeeper();
      
      public function ChatOutput(param1:Boolean)
      {
         super();
         this.privateMessagesEnabled = param1;
         this.source = this.container;
         this.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.focusEnabled = false;
         this.container.addEventListener(ChatUpdateEvent.UPDATE,this.onUpdateEvent);
      }
      
      public function addMessage(param1:UserStatus, param2:UserStatus, param3:ChatAddressMode, param4:String, param5:String, param6:MessageType = null, param7:Boolean = false, param8:Boolean = true) : void
      {
         var _loc9_:ChatOutputData = new ChatOutputData(param1,param2,param3,param5,param6,param7);
         if(param4 == this.currentChannel)
         {
            this.addLine(_loc9_,param8);
         }
         else
         {
            this.messageKeeper.pushMessage(param4,_loc9_);
         }
      }
      
      private function addLine(param1:ChatOutputData, param2:Boolean) : void
      {
         if(this.container.numChildren > MAX_MESSAGES)
         {
            this.shiftMessages();
         }
         var _loc3_:Boolean = false;
         if(param2)
         {
            _loc3_ = verticalScrollPosition + 5 > maxVerticalScrollPosition || !this.wasScrolled;
         }
         var _loc4_:ChatOutputLine = new ChatOutputLine(param1,this.lineWidth,this.privateMessagesEnabled,this.showIPMode,this.selfUid);
         _loc4_.y = int(this.container.height + 0.5);
         this.container.addChild(_loc4_);
         update();
         if(_loc3_)
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
            _loc3_.showIP = this.showIPMode;
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
         this.messageKeeper.cleanOutUsersMessages(param1);
      }
      
      public function setShowIPMode(param1:Boolean) : void
      {
         this.showIPMode = param1;
         this.updateLines();
      }
      
      public function switchToChannel(param1:Boolean, param2:String) : void
      {
         var _loc3_:Vector.<ChatOutputLine> = null;
         var _loc4_:int = 0;
         var _loc5_:Vector.<ChatOutputData> = null;
         var _loc6_:ChatOutputLine = null;
         var _loc7_:ChatOutputData = null;
         if(param2 != this.currentChannel)
         {
            _loc3_ = new Vector.<ChatOutputLine>();
            _loc4_ = 0;
            while(_loc4_ < this.container.numChildren)
            {
               _loc6_ = this.container.getChildAt(_loc4_) as ChatOutputLine;
               _loc7_ = _loc6_.getData();
               this.messageKeeper.pushMessage(this.currentChannel,_loc7_);
               _loc3_.push(_loc6_);
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               this.container.removeChild(_loc3_[_loc4_]);
               _loc4_++;
            }
            this.updateLines();
            this.currentChannel = param2;
            dispatchEvent(new ChangeChatChannelEvent(this.currentChannel));
            _loc5_ = this.messageKeeper.popMessages(param2);
            _loc4_ = 0;
            while(_loc4_ < _loc5_.length)
            {
               _loc7_ = _loc5_[_loc4_];
               this.addLine(_loc7_,param1);
               _loc4_++;
            }
            update();
         }
      }
   }
}

