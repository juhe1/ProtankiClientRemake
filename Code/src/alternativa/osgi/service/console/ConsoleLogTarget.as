package alternativa.osgi.service.console
{
   import alternativa.osgi.service.command.CommandService;
   import alternativa.osgi.service.command.FormattedOutput;
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import alternativa.osgi.service.logging.LogLevel;
   import alternativa.osgi.service.logging.LogTarget;
   
   public class ConsoleLogTarget implements LogTarget
   {
      
      private static const ANY_CHANNEL:* = "ANY_CHANNEL";
      
      private static const ANY_LOGLEVEL:LogLevel = null;
      
      private const EMPTY_VECTOR:Vector.<LogEntry> = new Vector.<LogEntry>(0);
      
      private const channels:Object = {};
      
      private var logEntrySequence:int;
      
      private var commandService:CommandService;
      
      private var bufferSize:int;
      
      private var connectedChannel:Object = {};
      
      private var connectToAllChannel:Boolean;
      
      private var console:IConsole;
      
      public function ConsoleLogTarget(param1:CommandService, param2:IConsole, param3:ILauncherParams)
      {
         super();
         this.console = param2;
         this.commandService = param1;
         this.bufferSize = int(param3.getParameter("log_channel_buffer_size","1000"));
         this.setupAutoConnectedChannel(param3);
         param1.registerCommand("log","channels","Список каналов",[],this.cmdChannelsList);
         param1.registerCommand("log","channel","Показать сообщения из канала",[String],this.cmdShowChannel);
         param1.registerCommand("log","connect","Показывать новые сообщения из канала",[String],this.cmdConnectChannel);
         param1.registerCommand("log","disconnect","Показывать новые сообщения из канала",[String],this.cmdDisconnectChannel);
         param1.registerCommand("log","trace","Посмотреть trace сообщения",[],this.cmdShow(LogLevel.TRACE));
         param1.registerCommand("log","info","Посмотреть info сообщения",[],this.cmdShow(LogLevel.INFO));
         param1.registerCommand("log","warning","Посмотреть warning сообщения",[],this.cmdShow(LogLevel.WARNING));
         param1.registerCommand("log","debug","Посмотреть debug сообщения",[],this.cmdShow(LogLevel.DEBUG));
         param1.registerCommand("log","error","Посмотреть error сообщения",[],this.cmdShow(LogLevel.ERROR));
      }
      
      public function log(param1:Object, param2:LogLevel, param3:String, param4:Array = null) : void
      {
         var _loc5_:LogEntry = new LogEntry(this.logEntrySequence++,param1,param2,param3,param4);
         var _loc6_:Vector.<LogEntry> = this.getOrCreateBufferForChannel(param1);
         _loc6_.push(_loc5_);
         if(Boolean(this.connectedChannel[param1]) || this.connectToAllChannel)
         {
            this.print(this.console,_loc5_);
         }
         if(_loc6_.length > this.bufferSize)
         {
            _loc6_.splice(1,100);
         }
      }
      
      private function setupAutoConnectedChannel(param1:ILauncherParams) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = param1.getParameter("showlog");
         if(Boolean(_loc2_))
         {
            if(_loc2_ == "*")
            {
               this.connectToAllChannel = true;
            }
            else
            {
               for each(_loc3_ in _loc2_.split(","))
               {
                  this.connectedChannel[_loc3_] = true;
               }
            }
         }
      }
      
      private function cmdDisconnectChannel(param1:FormattedOutput, param2:String) : void
      {
         delete this.connectedChannel[param2];
      }
      
      private function cmdConnectChannel(param1:FormattedOutput, param2:String) : void
      {
         this.connectedChannel[param2] = param2;
      }
      
      private function cmdShow(param1:LogLevel) : Function
      {
         var logLevel:LogLevel = param1;
         return function(param1:FormattedOutput):void
         {
            var _loc3_:* = undefined;
            var _loc2_:* = getLogEntriesForLevel(logLevel);
            for each(_loc3_ in _loc2_)
            {
               print(param1,_loc3_);
            }
         };
      }
      
      private function getLogEntriesForLevel(param1:LogLevel) : Vector.<LogEntry>
      {
         var channelName:String = null;
         var channelEntries:Vector.<LogEntry> = null;
         var logEntry:LogEntry = null;
         var logLevel:LogLevel = param1;
         var result:Vector.<LogEntry> = new Vector.<LogEntry>();
         for(channelName in this.channels)
         {
            channelEntries = this.channels[channelName];
            for each(logEntry in channelEntries)
            {
               if(logEntry.level == logLevel)
               {
                  result.push(logEntry);
               }
            }
         }
         result.sort(function(param1:LogEntry, param2:LogEntry):Number
         {
            return param1.ordinal - param2.ordinal;
         });
         return result;
      }
      
      private function cmdShowChannel(param1:FormattedOutput, param2:String) : void
      {
         var _loc5_:LogEntry = null;
         var _loc3_:Vector.<LogEntry> = this.getBufferForChannel(param2);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            if(this.filtered(_loc5_,param2,ANY_LOGLEVEL))
            {
               this.print(param1,_loc5_);
            }
            _loc4_++;
         }
      }
      
      private function cmdChannelsList(param1:FormattedOutput) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in this.channels)
         {
            param1.addText(_loc2_);
         }
      }
      
      private function filtered(param1:LogEntry, param2:*, param3:LogLevel) : Boolean
      {
         if(param1.level != param3 && param3 != ANY_LOGLEVEL)
         {
            return false;
         }
         if(param1.object != param2 && param2 != ANY_CHANNEL)
         {
            return false;
         }
         return true;
      }
      
      private function insertVars(param1:String, param2:Array) : String
      {
         var _loc3_:int = 0;
         if(param2 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               param1 = param1.replace("%" + (_loc3_ + 1),param2[_loc3_]);
               _loc3_++;
            }
         }
         return param1;
      }
      
      private function print(param1:FormattedOutput, param2:LogEntry) : void
      {
         param1.addText(param2.level.getName() + " [" + param2.object + "] " + this.insertVars(param2.message,param2.params));
      }
      
      private function getOrCreateBufferForChannel(param1:Object) : Vector.<LogEntry>
      {
         var _loc2_:Vector.<LogEntry> = this.getBufferForChannel(param1);
         if(_loc2_ == this.EMPTY_VECTOR)
         {
            _loc2_ = new Vector.<LogEntry>();
            this.channels[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private function getBufferForChannel(param1:Object) : Vector.<LogEntry>
      {
         return Boolean(this.channels[param1]) ? this.channels[param1] : this.EMPTY_VECTOR;
      }
   }
}

