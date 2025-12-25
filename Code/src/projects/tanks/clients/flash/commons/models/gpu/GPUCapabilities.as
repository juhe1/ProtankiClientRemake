package projects.tanks.clients.flash.commons.models.gpu
{
   import flash.display.Stage;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.setTimeout;
   
   public class GPUCapabilities extends EventDispatcher
   {
      
      private static var _gpuEnabled:Boolean;
      
      private static var _constrained:Boolean;

      private var newname_3307__END:Boolean;
      
      private var stage:Stage;
      
      public function GPUCapabilities(param1:Stage, param2:String = null, param3:String = null)
      {
         super();
         this.stage = param1;
         if(param2 != null)
         {
            _gpuEnabled = param2 == "true";
            _constrained = param3 == "true";
            newname_3307__END = true;
         }
      }
      
      public static function get gpuEnabled() : Boolean
      {
         return _gpuEnabled;
      }
      
      public static function get constrained() : Boolean
      {
         return _constrained;
      }
      
      public function detect() : void
      {
         if(this.stage3DExists() && !newname_3307__END)
         {
            this.getContext3D();
         }
         else
         {
            this.dispatchCompleteEventWithDelay();
         }
      }
      
      private function stage3DExists() : Boolean
      {
         return this.stage.hasOwnProperty("stage3Ds");
      }
      
      private function getContext3D() : void
      {
         var _loc1_:Object = this.getStage3D();
         _loc1_.addEventListener("context3DCreate",this.onContext3DCreate);
         _loc1_.addEventListener(ErrorEvent.ERROR,this.onContext3DCreateError);
         _loc1_.requestContext3D("auto");
      }
      
      private function onContext3DCreate(param1:Event) : void
      {
         this.removeListeners();
         this.detectGPUAcceleration();
         if(!_gpuEnabled && this.isConstrainedAvaible())
         {
            this.getContext3DConstrained();
         }
         else
         {
            this.dispatchCompleteEvent();
         }
      }
      
      private function isConstrainedAvaible() : Boolean
      {
         var _loc1_:Object = this.getStage3D();
         return _loc1_.requestContext3D.length > 1;
      }
      
      private function getContext3DConstrained() : void
      {
         _constrained = true;
         var _loc1_:Object = this.getStage3D();
         _loc1_.addEventListener("context3DCreate",this.onContext3DCreateConstrained);
         _loc1_.addEventListener(ErrorEvent.ERROR,this.onContext3DCreateError);
         _loc1_.requestContext3D("auto","baselineConstrained");
      }
      
      private function onContext3DCreateConstrained(param1:Event) : void
      {
         this.removeListeners();
         this.detectGPUAcceleration();
         this.dispatchCompleteEvent();
      }
      
      private function detectGPUAcceleration() : void
      {
         var _loc1_:Object = this.getStage3D();
         var _loc2_:Object = _loc1_.context3D;
         var _loc3_:String = _loc2_.driverInfo;
         _gpuEnabled = _loc3_.toLowerCase().indexOf("software") == -1;
         _loc2_.dispose();
      }
      
      private function onContext3DCreateError(param1:ErrorEvent) : void
      {
         this.removeListeners();
         this.dispatchCompleteEvent();
      }
      
      private function getStage3D() : Object
      {
         return this.stage["stage3Ds"][0];
      }
      
      private function removeListeners() : void
      {
         var _loc1_:Object = this.getStage3D();
         _loc1_.removeEventListener("context3DCreate",this.onContext3DCreate);
         _loc1_.removeEventListener("context3DCreate",this.onContext3DCreateConstrained);
         _loc1_.removeEventListener(ErrorEvent.ERROR,this.onContext3DCreateError);
      }
      
      private function dispatchCompleteEventWithDelay() : void
      {
         setTimeout(this.dispatchCompleteEvent,0);
      }
      
      private function dispatchCompleteEvent() : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

