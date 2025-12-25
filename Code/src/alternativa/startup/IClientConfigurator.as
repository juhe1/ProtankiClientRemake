package alternativa.startup
{
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   
   public interface IClientConfigurator
   {
      function start(param1:DisplayObjectContainer, param2:ILauncherParams, param3:ConnectionParameters, param4:LoaderInfo) : void;
   }
}
