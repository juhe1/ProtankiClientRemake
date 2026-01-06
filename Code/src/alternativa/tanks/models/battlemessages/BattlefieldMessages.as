package alternativa.tanks.models.battlemessages
{
   import controls.Label;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   
   public class BattlefieldMessages extends Sprite
   {
      
      private const MAX_MESSAGES:int = 3;
      
      private const VERTICAL_INTERVAL:int = 18;
      
      private var numMessages:int;
      
      private var messages:Vector.<Message> = new Vector.<Message>();
      
      private var numPooledMessages:int;
      
      private var messagePool:Vector.<Message> = new Vector.<Message>();
      
      public function BattlefieldMessages()
      {
         super();
         filters = [new GlowFilter(0,0.75,5,5)];
      }
      
      public function addMessage(param1:uint, param2:String) : void
      {
         this.removeFirstMessageIfFull();
         var _loc3_:Message = this.messages[this.numMessages] = this.createMessage();
         _loc3_.init();
         this.addLabel(_loc3_,param1,param2);
      }
      
      public function addMessageWithDuration(param1:uint, param2:String, param3:int) : void
      {
         this.removeFirstMessageIfFull();
         var _loc4_:Message = this.messages[this.numMessages] = this.createMessage();
         _loc4_.initWithDuration(param3);
         this.addLabel(_loc4_,param1,param2);
      }
      
      private function removeFirstMessageIfFull() : void
      {
         if(this.numMessages == this.MAX_MESSAGES)
         {
            this.removeMessage(0);
         }
      }
      
      private function addLabel(param1:Message, param2:uint, param3:String) : void
      {
         var _loc4_:Label = param1.getLabel();
         addChild(_loc4_);
         _loc4_.color = param2;
         _loc4_.text = param3;
         _loc4_.x = -0.5 * _loc4_.width;
         _loc4_.y = this.VERTICAL_INTERVAL * this.numMessages;
         ++this.numMessages;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Message = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.numMessages)
         {
            _loc3_ = this.messages[_loc2_];
            if(_loc3_.isDead)
            {
               this.removeMessage(_loc2_);
               _loc2_--;
            }
            else
            {
               _loc3_.update(param1);
            }
            _loc2_++;
         }
      }
      
      public function removeFromParent() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      private function removeMessage(param1:int) : void
      {
         var _loc4_:Label = null;
         var _loc2_:Message = this.messages[param1];
         this.destroyMessage(_loc2_);
         var _loc3_:int = param1 + 1;
         while(_loc3_ < this.numMessages)
         {
            _loc2_ = this.messages[int(_loc3_ - 1)] = this.messages[_loc3_];
            _loc4_ = _loc2_.getLabel();
            _loc4_.y -= this.VERTICAL_INTERVAL;
            _loc3_++;
         }
         --this.numMessages;
      }
      
      private function destroyMessage(param1:Message) : void
      {
         removeChild(param1.getLabel());
         this.messagePool[this.numPooledMessages++] = param1;
      }
      
      private function createMessage() : Message
      {
         var _loc1_:Message = null;
         if(this.numPooledMessages == 0)
         {
            _loc1_ = new Message();
         }
         else
         {
            _loc1_ = this.messagePool[--this.numPooledMessages];
            this.messagePool[this.numPooledMessages] = null;
         }
         return _loc1_;
      }
   }
}

