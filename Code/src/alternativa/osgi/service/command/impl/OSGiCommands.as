package alternativa.osgi.service.command.impl
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.bundle.IBundleDescriptor;
   import alternativa.osgi.catalogs.ServiceInfo;
   import alternativa.osgi.catalogs.ServiceParam;
   import alternativa.osgi.service.command.CommandService;
   import alternativa.osgi.service.command.FormattedOutput;
   
   public class OSGiCommands
   {
      
      private var commandService:CommandService;
      
      private var osgi:OSGi;
      
      public function OSGiCommands(param1:OSGi, param2:CommandService)
      {
         super();
         this.osgi = param1;
         this.commandService = param2;
         param2.registerCommand("osgi","ss","Список плагинов",[],this.cmdBundlesList);
         param2.registerCommand("osgi","services","Список сервисов",[],this.cmdServicesList);
      }
      
      public function cmdBundlesList(param1:FormattedOutput) : void
      {
         var _loc2_:Vector.<IBundleDescriptor> = this.osgi.bundleList;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            param1.addText(int(_loc3_ + 1).toString() + ". " + _loc2_[_loc3_].name);
            _loc3_++;
         }
      }
      
      public function cmdServicesList(param1:FormattedOutput) : void
      {
         var _loc4_:ServiceInfo = null;
         var _loc2_:Vector.<ServiceInfo> = this.osgi.getServicesInfo();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            param1.addText((_loc3_ + 1).toString() + ": " + _loc4_.service + this.getServicesParam(_loc4_.params));
            _loc3_++;
         }
      }
      
      private function getServicesParam(param1:Vector.<ServiceParam>) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ServiceParam = null;
         var _loc2_:String = " ";
         if(param1 != null)
         {
            _loc3_ = 0;
            _loc4_ = int(param1.length);
            while(_loc3_ < _loc4_)
            {
               _loc5_ = param1[_loc3_];
               _loc2_ += "(" + _loc5_.name + " = " + _loc5_.value + ")";
               _loc3_++;
            }
         }
         return _loc2_;
      }
   }
}

