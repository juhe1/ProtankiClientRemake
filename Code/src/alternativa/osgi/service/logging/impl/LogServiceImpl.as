package alternativa.osgi.service.logging.impl
{
   import alternativa.osgi.service.logging.LogLevel;
   import alternativa.osgi.service.logging.LogService;
   import alternativa.osgi.service.logging.LogTarget;
   import alternativa.osgi.service.logging.Logger;
   
   public class LogServiceImpl implements LogService, LogTarget
   {
       
      
      private var logTargets:Vector.<LogTarget>;
      
      public function LogServiceImpl()
      {
         this.logTargets = new Vector.<LogTarget>();
         super();
      }
      
      public function getLogger(object:Object) : Logger
      {
         return new LoggerImpl(object,this);
      }
      
      public function addLogTarget(logTarget:LogTarget) : void
      {
         if(this.logTargets.indexOf(logTarget) < 0)
         {
            this.logTargets.push(logTarget);
         }
      }
      
      public function removeLogTarget(logTarget:LogTarget) : void
      {
         var i:int = this.logTargets.indexOf(logTarget);
         if(i >= 0)
         {
            this.logTargets = this.logTargets.splice(i,1);
         }
      }
      
      public function log(object:Object, level:LogLevel, message:String, params:Array = null) : void
      {
         var logTarget:LogTarget = null;
         for each(logTarget in this.logTargets)
         {
            try
            {
               logTarget.log(object,level,message,params);
            }
            catch(e:Error)
            {
               trace(e.getStackTrace());
            }
         }
      }
   }
}
