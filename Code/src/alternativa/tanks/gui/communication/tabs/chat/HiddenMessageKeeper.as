package alternativa.tanks.gui.communication.tabs.chat
{
   import alternativa.tanks.gui.chat.ChatOutputData;
   import flash.utils.Dictionary;
   
   public class HiddenMessageKeeper
   {
      
      private var hiddenChannels:Dictionary = new Dictionary();
      
      public function HiddenMessageKeeper()
      {
         super();
      }
      
      public function pushMessage(param1:String, param2:ChatOutputData) : void
      {
         if(!(param1 in this.hiddenChannels))
         {
            this.hiddenChannels[param1] = new Vector.<ChatOutputData>();
         }
         this.hiddenChannels[param1].push(param2);
      }
      
      public function popMessages(param1:String) : Vector.<ChatOutputData>
      {
         var _loc2_:Vector.<ChatOutputData> = this.hiddenChannels[param1];
         delete this.hiddenChannels[param1];
         return _loc2_ != null ? _loc2_ : new Vector.<ChatOutputData>();
      }
      
      public function cleanOutUsersMessages(param1:String) : void
      {
         var _loc2_:Vector.<ChatOutputData> = null;
         var _loc3_:Vector.<int> = null;
         var _loc4_:int = 0;
         var _loc5_:ChatOutputData = null;
         for each(_loc2_ in this.hiddenChannels)
         {
            _loc3_ = new Vector.<int>();
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc5_ = _loc2_[_loc4_] as ChatOutputData;
               if(_loc5_.getSender().uid == param1)
               {
                  _loc3_.push(_loc4_);
               }
               _loc4_++;
            }
            _loc4_ = _loc3_.length - 1;
            while(_loc4_ >= 0)
            {
               _loc2_.splice(_loc3_[_loc4_],1);
               _loc4_--;
            }
         }
      }
   }
}

