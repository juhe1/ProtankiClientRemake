package alternativa.osgi.service.logging.impl
{
   import alternativa.osgi.service.logging.LogLevel;
   import alternativa.osgi.service.logging.LogTarget;
   import alternativa.osgi.service.logging.Logger;
   
   public class LoggerImpl implements Logger
   {
       
      
      private var logTarget:LogTarget;
      
      private var object:Object;
      
      public function LoggerImpl(object:Object, logTarget:LogTarget)
      {
         super();
         this.object = object;
         this.logTarget = logTarget;
      }
      
      public function trace(message:String, params:Array = null) : void
      {
         this.logTarget.log(this.object,LogLevel.TRACE,message,params);
      }
      
      public function debug(message:String, params:Array = null) : void
      {
         this.logTarget.log(this.object,LogLevel.DEBUG,message,params);
      }
      
      public function info(message:String, params:Array = null) : void
      {
         this.logTarget.log(this.object,LogLevel.INFO,message,params);
      }
      
      public function warning(message:String, params:Array = null) : void
      {
         this.logTarget.log(this.object,LogLevel.WARNING,message,params);
      }
      
      public function error(message:String, params:Array = null) : void
      {
         this.logTarget.log(this.object,LogLevel.ERROR,message,params);
      }
   }
}
