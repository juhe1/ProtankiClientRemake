package alternativa.tanks.loader
{
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   
   public interface ILoaderWindowService extends IEventDispatcher
   {
      
      function addTip(param1:DisplayObject) : void;
      
      function show() : void;
      
      function showImmediately() : void;
      
      function hide() : void;
      
      function hideForcibly() : void;
      
      function isInProgress() : Boolean;
   }
}

