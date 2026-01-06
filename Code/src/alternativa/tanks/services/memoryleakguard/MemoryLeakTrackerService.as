package alternativa.tanks.services.memoryleakguard
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.command.CommandService;
   import alternativa.osgi.service.command.FormattedOutput;
   import flash.utils.Dictionary;
   
   public class MemoryLeakTrackerService
   {
      
      private static const classCounters:Dictionary = new Dictionary();
      
      private const objects:Dictionary = new Dictionary(true);
      
      public function MemoryLeakTrackerService(param1:OSGi)
      {
         super();
         this.registerCommands(param1);
      }
      
      private function registerCommands(param1:OSGi) : void
      {
         var _loc2_:CommandService = CommandService(param1.getService(CommandService));
         _loc2_.registerCommand("ml","tr","Traces tracked objects",[],this._trace);
      }
      
      private function _trace(param1:FormattedOutput) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.objects)
         {
            param1.addText(Object(_loc2_).toString() + " -> " + this.objects[_loc2_]);
         }
      }
      
      public function track(param1:Object, param2:String) : void
      {
      }
      
      public function getObjectsCount() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for(_loc2_ in this.objects)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function traceObjects() : void
      {
      }
      
      public function traceStaticstics() : void
      {
      }
   }
}

