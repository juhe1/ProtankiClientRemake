package alternativa.osgi.service.launcherparams
{
   import alternativa.startup.LibraryInfo;
   import alternativa.utils.Properties;
   import flash.display.LoaderInfo;
   
   public class LauncherParams implements ILauncherParams
   {
       
      
      private var strictUseHttp:Boolean;
      
      private var _urlLoader:String;
      
      private var urlParams:Properties;
      
      public function LauncherParams(loaderInfo:LoaderInfo = null, strictUseHttp:* = false)
      {
         super();
         if(Boolean(loaderInfo))
         {
            this._urlLoader = loaderInfo.loaderURL;
            this.urlParams = new Properties(loaderInfo.parameters);
         }
         else
         {
            this.urlParams = new Properties();
         }
         this.strictUseHttp = strictUseHttp;
      }
      
      public function getParameter(parameterName:String, defaultValue:String = null) : String
      {
         return this.urlParams.getProperty(parameterName) || defaultValue;
      }
      
      public function setParameter(parameterName:String, parameterValue:String) : void
      {
         this.urlParams.setProperty(parameterName,parameterValue);
      }
      
      public function removeParameter(parameterName:String) : void
      {
         this.urlParams.removeProperty(parameterName);
      }
      
      public function get parameterNames() : Vector.<String>
      {
         return this.urlParams.propertyNames;
      }
      
      public function get isDebug() : Boolean
      {
         return "true" == this.urlParams.getProperty("debug");
      }
      
      public function isDisableValidationResource() : Boolean
      {
         return "false" == this.urlParams.getProperty("validationResource");
      }
      
      public function get urlLoader() : String
      {
         return this._urlLoader;
      }
      
      public function isStrictUseHttp() : Boolean
      {
         return this.strictUseHttp;
      }
   }
}
