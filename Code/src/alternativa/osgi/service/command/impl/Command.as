package alternativa.osgi.service.command.impl
{
   import alternativa.osgi.service.command.FormattedOutput;
   
   public class Command
   {
      
      public var cmd:String;
      
      public var handler:Function;
      
      public var argsType:Array;
      
      public var scope:String;
      
      private var _help:String;
      
      public function Command(param1:String, param2:String, param3:String, param4:Array, param5:Function)
      {
         super();
         this._help = param3;
         this.scope = param1;
         this.argsType = param4;
         this.handler = param5;
         this.cmd = param2;
      }
      
      public function excute(param1:Array, param2:FormattedOutput) : void
      {
         var _loc3_:Array = new Array();
         _loc3_[0] = param2;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_[_loc4_ + 1] = param1[_loc4_];
            _loc4_++;
         }
         this.handler.apply(null,_loc3_);
      }
      
      public function help() : String
      {
         return this.argsType + " " + this._help;
      }
   }
}

