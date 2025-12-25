package alternativa.osgi.service.command.impl
{
   import alternativa.osgi.service.command.FormattedOutput;
   
   public class FormattedOutputToString implements FormattedOutput
   {
      
      public var content:Vector.<String> = new Vector.<String>();
      
      public function FormattedOutputToString()
      {
         super();
      }
      
      public function addText(param1:String) : void
      {
         this.content.push(param1);
      }
      
      public function addPrefixedText(param1:String, param2:String) : void
      {
         this.addText(param1 + " " + param2);
      }
      
      public function addLines(param1:Vector.<String>) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.addText(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function addPrefixedLines(param1:String, param2:Vector.<String>) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            this.addPrefixedText(param1,param2[_loc3_]);
            _loc3_++;
         }
      }
   }
}

