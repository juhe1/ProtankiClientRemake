package alternativa.tanks.models.battle.gui.gui.statistics.messages
{
   import alternativa.tanks.models.battle.battlefield.common.MessageContainer;
   import alternativa.tanks.models.battle.battlefield.common.MessageLine;
   import alternativa.tanks.models.battle.battlefield.event.ChatOutputLineEvent;
   
   public class BattleMessagesOutput extends MessageContainer
   {
      
      public var maxMessages:int = 10;
      
      public function BattleMessagesOutput()
      {
         super();
         messageSpacing = 6;
      }
      
      public function addLine(param1:MessageLine) : void
      {
         var _loc3_:MessageLine = null;
         pushBack(param1);
         if(container.numChildren > this.maxMessages)
         {
            _loc3_ = removeFirstMessage();
            if(_loc3_ != null)
            {
               _loc3_.removeEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
               _loc3_.removeEventListener(ChatOutputLineEvent.UPDATE_UID,this.updateUid);
            }
         }
         param1.addEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
         param1.addEventListener(ChatOutputLineEvent.UPDATE_UID,this.updateUid);
         var _loc2_:int = param1 is KillMessageOutputLine ? 6 : 10;
         param1.x = -param1.width - _loc2_;
      }
      
      private function killLine(param1:ChatOutputLineEvent) : void
      {
         if(container.contains(param1.line))
         {
            removeFirstMessage();
         }
         param1.line.removeEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
      }
      
      private function updateUid(param1:ChatOutputLineEvent) : void
      {
         var _loc2_:MessageLine = param1.line;
         var _loc3_:int = _loc2_ is KillMessageOutputLine ? 6 : 10;
         _loc2_.x = -_loc2_.width - _loc3_;
         _loc2_.removeEventListener(ChatOutputLineEvent.UPDATE_UID,this.killLine);
      }
   }
}

