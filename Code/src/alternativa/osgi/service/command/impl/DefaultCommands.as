package alternativa.osgi.service.command.impl
{
   import alternativa.osgi.service.command.CommandService;
   import alternativa.osgi.service.command.FormattedOutput;
   import flash.system.System;
   
   public class DefaultCommands
   {
      
      private var commandService:CommandServiceImpl;
      
      public function DefaultCommands(param1:CommandService)
      {
         super();
         this.commandService = param1 as CommandServiceImpl;
         param1.registerCommand("cmd","help","Список всех команд",[],this.cmdList);
         param1.registerCommand("cmd","help","Помощь по конкретной команде",[String],this.cmdHelp);
         param1.registerCommand("cmd","grep","Поиск по строке",[String,Vector],this.cmdGrep);
         param1.registerCommand("cmd","clip","Копировать вывод конвеера в буфер обмена",[Vector],this.cmdClipboard);
      }
      
      private function cmdList(param1:FormattedOutput) : void
      {
         var command:Command = null;
         var output:FormattedOutput = param1;
         var sortedCommands:Vector.<Command> = this.commandService.commands.sort(function(param1:Command, param2:Command):Number
         {
            var _loc3_:* = param1.scope.localeCompare(param2.scope);
            if(_loc3_ != 0)
            {
               return _loc3_;
            }
            return param1.cmd.localeCompare(param2.cmd);
         });
         var i:int = 0;
         while(i < sortedCommands.length)
         {
            command = sortedCommands[i];
            output.addText(command.scope + "." + command.cmd);
            i++;
         }
      }
      
      private function cmdHelp(param1:FormattedOutput, param2:String) : void
      {
         var _loc5_:Command = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < this.commandService.commands.length)
         {
            _loc5_ = this.commandService.commands[_loc4_];
            if(_loc5_.scope + "." + _loc5_.cmd == param2 || _loc5_.scope + "." + _loc5_.cmd == "cmd." + param2)
            {
               param1.addText(_loc5_.scope + "." + _loc5_.cmd + " " + _loc5_.help());
               _loc3_ = true;
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            param1.addText("Команда не найдена " + param2);
         }
      }
      
      private function cmdGrep(param1:FormattedOutput, param2:String, param3:Vector.<String>) : void
      {
         var _loc4_:String = null;
         for each(_loc4_ in param3)
         {
            if(_loc4_.indexOf(param2) != -1)
            {
               param1.addText(_loc4_);
            }
         }
      }
      
      private function cmdClipboard(param1:FormattedOutput, param2:Vector.<String>) : void
      {
         var _loc3_:String = param2.join("\n");
         System.setClipboard(_loc3_);
         param1.addLines(param2);
      }
   }
}

