package alternativa.osgi.service.command.impl
{
   import alternativa.osgi.service.command.CommandService;
   import alternativa.osgi.service.command.FormattedOutput;
   
   public class CommandServiceImpl implements CommandService
   {
      
      private static const TOKENIZER:RegExp = /(?:[^"\s]+)|(?:"[^"]*")/g;
      
      private const DEFAULT_SCOPE:String = "cmd";
      
      public var commands:Vector.<Command> = new Vector.<Command>();
      
      public function CommandServiceImpl()
      {
         super();
      }
      
      public function registerCommand(param1:String, param2:String, param3:String, param4:Array, param5:Function) : void
      {
         var _loc6_:Command = new Command(param1,param2,param3,param4,param5);
         this.commands.push(_loc6_);
      }
      
      public function removeCommand(param1:String, param2:String, param3:Array) : void
      {
         var _loc5_:Command = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.commands.length)
         {
            _loc5_ = this.commands[_loc4_];
            if(this.isEqualsFullCmd(_loc5_,param1,param2))
            {
               if(_loc5_.argsType.toString() == param3.toString())
               {
                  this.commands.splice(_loc4_,1);
                  return;
               }
            }
            _loc4_++;
         }
      }
      
      public function execute(param1:String, param2:FormattedOutput) : void
      {
         var _loc6_:String = null;
         var _loc7_:Vector.<String> = null;
         var _loc3_:Vector.<String> = this.parseCommands(param1);
         var _loc4_:FormattedOutputToString = new FormattedOutputToString();
         this.parseAndExecuteCommand(_loc3_[0],[],_loc4_);
         var _loc5_:int = 1;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_];
            _loc7_ = _loc4_.content;
            _loc4_ = new FormattedOutputToString();
            this.parseAndExecuteCommand(_loc6_,[_loc7_],_loc4_);
            _loc5_++;
         }
         param2.addLines(_loc4_.content);
      }
      
      private function parseCommands(param1:String) : Vector.<String>
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc2_:Vector.<String> = new Vector.<String>();
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc7_ = param1.charAt(_loc5_);
            if(_loc7_ == "\"")
            {
               _loc3_ = !_loc3_;
            }
            if(_loc7_ == "|" && _loc3_)
            {
               _loc8_ = param1.substr(_loc4_,_loc5_ - _loc4_);
               _loc2_.push(_loc8_);
               _loc4_ = _loc5_ + 1;
            }
            _loc5_++;
         }
         var _loc6_:String = param1.substr(_loc4_,param1.length - _loc4_);
         _loc2_.push(_loc6_);
         return _loc2_;
      }
      
      private function parseAndExecuteCommand(param1:String, param2:Array, param3:FormattedOutput) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc10_:Command = null;
         var _loc11_:Array = null;
         param1 = param1.replace(/^\s+|\s+$/g,"");
         var _loc4_:Array = param1.match(TOKENIZER);
         if(_loc4_.length == 0)
         {
            throw new CommandNotFoundError(param1,"");
         }
         var _loc5_:Array = (_loc4_[0] as String).split(".");
         if(_loc5_.length == 1)
         {
            _loc6_ = "cmd";
            _loc7_ = _loc5_[0];
         }
         else
         {
            if(_loc5_.length != 2)
            {
               throw new InvalidCommandFormatError(param1);
            }
            _loc6_ = _loc5_[0];
            _loc7_ = _loc5_[1];
         }
         _loc4_.shift();
         var _loc8_:int = 0;
         while(_loc8_ < this.commands.length)
         {
            _loc10_ = this.commands[_loc8_];
            if(this.isEqualsFullCmd(_loc10_,_loc6_,_loc7_))
            {
               if(_loc10_.argsType.length === _loc4_.length + param2.length)
               {
                  _loc11_ = this.convert(_loc10_.argsType,_loc4_);
                  _loc11_ = _loc11_.concat(param2);
                  _loc10_.excute(_loc11_,param3);
                  return;
               }
            }
            _loc8_++;
         }
         var _loc9_:String = "";
         _loc8_ = 0;
         while(_loc8_ < this.commands.length)
         {
            _loc10_ = this.commands[_loc8_];
            if(_loc10_.scope != this.DEFAULT_SCOPE)
            {
               if(_loc10_.cmd == _loc7_ || _loc10_.scope == _loc6_ || _loc10_.scope == _loc7_)
               {
                  _loc9_ += _loc10_.scope + "." + _loc10_.cmd + " " + _loc10_.help() + "\n";
               }
            }
            _loc8_++;
         }
         throw new CommandNotFoundError(param1,_loc9_);
      }
      
      private function isEqualsFullCmd(param1:Command, param2:String, param3:String) : Boolean
      {
         return param1.scope == param2 && param1.cmd == param3;
      }
      
      private function convert(param1:Array, param2:Array) : Array
      {
         var argsType:Array = param1;
         var stringParams:Array = param2;
         return stringParams.map(function(param1:*, param2:int, param3:Array):*
         {
            var _loc5_:* = undefined;
            var _loc4_:* = argsType[param2];
            switch(_loc4_)
            {
               case String:
                  _loc5_ = param1 as String;
                  if(_loc5_.charAt(0) == "\"")
                  {
                     _loc5_ = _loc5_.substr(1);
                  }
                  if(_loc5_.charAt(_loc5_.length - 1) == "\"")
                  {
                     _loc5_ = _loc5_.substr(0,_loc5_.length - 1);
                  }
                  return _loc5_;
               case int:
                  return int(param1);
               case uint:
                  return uint(param1);
               case Number:
                  return Number(param1);
               default:
                  return;
            }
         });
      }
   }
}

