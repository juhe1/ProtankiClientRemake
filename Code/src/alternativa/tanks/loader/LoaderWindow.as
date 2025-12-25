package alternativa.tanks.loader
{
   import alternativa.init.TanksServicesActivator;
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.loader.dishonestprogressbar.DishonestProgressBar;
   import alternativa.tanks.utils.TransparentJPG;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class LoaderWindow extends Sprite implements ILoaderWindowService
   {
      
      private static const WindowRGB:Class = LoaderWindow_WindowRGB;
      
      private static const WindowRGBChina:Class = LoaderWindow_WindowRGBChina;
      
      private static const WindowAlpha:Class = LoaderWindow_WindowAlpha;
      
      private static const NEXT_TIP_DELAY:int = 9000;
      
      private static const SHOW_LOADER_WINDOW_DELAY_IN_MS:int = 600;
      
      private var _stage:Stage;
      
      private var _timeOutShowDelay:uint;
      
      private var layer:DisplayObjectContainer;
      
      private var windowBmp:Bitmap;
      
      private var tipBlock:TipBlock;
      
      private var nextTipTimer:Timer;
      
      private var tips:Array = [];
      
      private var dishonestProgressBar:DishonestProgressBar;
      
      public function LoaderWindow()
      {
         super();
         var _loc1_:IDisplay = IDisplay(TanksServicesActivator.osgi.getService(IDisplay));
         this.layer = _loc1_.loaderLayer;
         this._stage = _loc1_.stage;
         var _loc2_:BitmapData = getLoaderBackgroundBitmap(TanksServicesActivator.osgi.getService(ILocaleService) as ILocaleService);
         this.windowBmp = TransparentJPG.createImageFromRGBAndAlpha(_loc2_,new WindowAlpha().bitmapData);
         addChild(this.windowBmp);
         this.tipBlock = new TipBlock();
         addChild(this.tipBlock);
         this.dishonestProgressBar = new DishonestProgressBar(this.progressBarFinished);
         addChild(this.dishonestProgressBar);
         this.dishonestProgressBar.x = 10;
         this.dishonestProgressBar.y = 239;
         this.nextTipTimer = new Timer(NEXT_TIP_DELAY,1);
         this.nextTipTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onNextTipTimerComplete);
      }
      
      private static function getLoaderBackgroundBitmap(param1:ILocaleService) : BitmapData
      {
         if(param1.language == "cn")
         {
            return new WindowRGBChina().bitmapData;
         }
         return new WindowRGB().bitmapData;
      }
      
      private function progressBarFinished() : void
      {
         if(this.layer.contains(this))
         {
            this.layer.removeChild(this);
         }
      }
      
      private function onNextTipTimerComplete(param1:TimerEvent = null) : void
      {
         if(this.tips[0] is DisplayObject)
         {
            this.tipBlock.showTip(this.tips.shift());
         }
         var _loc2_:ILoaderTipsService = OSGi.getInstance().getService(ILoaderTipsService) as ILoaderTipsService;
         if(_loc2_ != null)
         {
            _loc2_.getTip();
         }
         this.nextTipTimer.stop();
         this.nextTipTimer.reset();
         this.nextTipTimer.start();
      }
      
      public function addTip(param1:DisplayObject) : void
      {
         this.tips.push(param1);
      }
      
      public function show() : void
      {
         clearTimeout(this._timeOutShowDelay);
         this._timeOutShowDelay = setTimeout(this.showImmediately,SHOW_LOADER_WINDOW_DELAY_IN_MS);
      }
      
      public function showImmediately() : void
      {
         clearTimeout(this._timeOutShowDelay);
         if(!this.layer.contains(this))
         {
            this.dishonestProgressBar.start();
            this.layer.addChild(this);
            this._stage.addEventListener(Event.RESIZE,this.align);
            this.align();
            this.nextTipTimer.start();
            this.onNextTipTimerComplete();
         }
      }
      
      private function align(param1:Event = null) : void
      {
         this.x = this._stage.stageWidth - this.windowBmp.width >>> 1;
         this.y = this._stage.stageHeight - this.windowBmp.height >>> 1;
      }
      
      public function hide() : void
      {
         clearTimeout(this._timeOutShowDelay);
         if(this.layer.contains(this))
         {
            this.nextTipTimer.stop();
            this.dishonestProgressBar.forciblyFinish();
            this._stage.removeEventListener(Event.RESIZE,this.align);
         }
         dispatchEvent(new TipsLoadingCompletedEvent(TipsLoadingCompletedEvent.TIPS_LOADING_COMPLETED_EVENT));
      }
      
      public function hideForcibly() : void
      {
         clearTimeout(this._timeOutShowDelay);
         if(this.layer.contains(this))
         {
            this.nextTipTimer.stop();
            this.dishonestProgressBar.forciblyStop();
            this._stage.removeEventListener(Event.RESIZE,this.align);
            this.layer.removeChild(this);
         }
      }
      
      public function isInProgress() : Boolean
      {
         return this.nextTipTimer.running;
      }
   }
}

