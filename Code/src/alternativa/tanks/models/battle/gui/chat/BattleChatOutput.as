package alternativa.tanks.models.battle.gui.chat
{
   import alternativa.tanks.models.battle.battlefield.common.MessageContainer;
   import alternativa.tanks.models.battle.battlefield.common.MessageLine;
   import alternativa.tanks.models.battle.battlefield.event.ChatOutputLineEvent;
   import alternativa.types.Long;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import forms.userlabel.ChatUpdateEvent;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class BattleChatOutput extends MessageContainer
   {
      
      private static const LINE_WIDTH:int = 300;
      
      private static const MAX_MESSAGES:int = 100;
      
      private static const MIN_MESSAGES:int = 5;
      
      private var buffer:Array = [];
      
      private var minimizedMode:Boolean = true;
      
      private var updateId:uint = 0;
      
      public function BattleChatOutput()
      {
         super();
      }
      
      public function addLine(param1:String, param2:BattleTeam, param3:String, param4:Boolean, param5:Boolean) : void
      {
         this.removeFirsLineIfNeeded();
         var _loc6_:BattleChatLine = new BattleChatLine(param1,param2,param3,param4,param5);
         _loc6_.addEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
         this.addToBuffer(_loc6_);
         pushBack(_loc6_);
         container.addEventListener(ChatUpdateEvent.UPDATE,this.onUpdateEvent);
      }
      
      private function onUpdateEvent(param1:ChatUpdateEvent) : void
      {
         if(this.updateId != 0)
         {
            clearTimeout(this.updateId);
         }
         this.updateId = setTimeout(this.updateLines,100);
      }
      
      private function updateLines() : void
      {
         var _loc1_:MessageLine = null;
         this.updateId = 0;
         for each(_loc1_ in this.buffer)
         {
            if(_loc1_ is BattleChatLine)
            {
               BattleChatLine(_loc1_).alignChatUserLabel();
            }
         }
      }
      
      public function addSystemMessage(param1:String) : void
      {
         this.removeFirsLineIfNeeded();
         var _loc2_:BattleChatSystemLine = new BattleChatSystemLine(LINE_WIDTH,param1);
         _loc2_.addEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
         this.addToBuffer(_loc2_);
         pushBack(_loc2_);
      }
      
      override public function removeFirstMessage(param1:Boolean = false) : MessageLine
      {
         var _loc2_:MessageLine = super.removeFirstMessage();
         this.y += shift;
         if(param1)
         {
            this.buffer.shift();
         }
         return _loc2_;
      }
      
      public function maximize() : void
      {
         var _loc1_:int = 0;
         var _loc3_:MessageLine = null;
         this.minimizedMode = false;
         var _loc2_:int = this.buffer.length - container.numChildren;
         _loc1_ = 0;
         while(_loc1_ < container.numChildren)
         {
            _loc3_ = MessageLine(container.getChildAt(_loc1_));
            _loc3_.killStop();
            _loc1_++;
         }
         _loc1_ = _loc2_ - 1;
         while(_loc1_ >= 0)
         {
            try
            {
               pushFront(MessageLine(this.buffer[_loc1_]));
            }
            catch(err:Error)
            {
            }
            _loc1_--;
         }
      }
      
      public function minimize() : void
      {
         var _loc1_:int = 0;
         var _loc3_:MessageLine = null;
         this.minimizedMode = true;
         var _loc2_:int = container.numChildren - MIN_MESSAGES;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.removeFirstMessage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < container.numChildren)
         {
            _loc3_ = MessageLine(container.getChildAt(_loc1_));
            if(!_loc3_.alive)
            {
               this.removeFirstMessage();
               _loc1_--;
            }
            else
            {
               _loc3_.killStart();
            }
            _loc1_++;
         }
      }
      
      public function clear() : void
      {
         this.buffer.length = 0;
         var _loc1_:int = container.numChildren - 1;
         while(_loc1_ >= 0)
         {
            container.removeChildAt(_loc1_);
            _loc1_--;
         }
      }
      
      private function killLine(param1:ChatOutputLineEvent) : void
      {
         if(this.minimizedMode && container.contains(param1.line))
         {
            this.removeFirstMessage();
         }
         param1.line.removeEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
      }
      
      private function removeFirsLineIfNeeded() : void
      {
         if(this.minimizedMode && container.numChildren > MIN_MESSAGES || !this.minimizedMode && container.numChildren >= MAX_MESSAGES)
         {
            this.removeFirstMessage();
         }
      }
      
      private function addToBuffer(param1:MessageLine) : void
      {
         this.buffer.push(param1);
         if(this.buffer.length > MAX_MESSAGES)
         {
            this.buffer.shift();
         }
      }
   }
}

