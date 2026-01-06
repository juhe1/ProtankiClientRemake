package alternativa.tanks.models.battle.gui.statistics
{
   import alternativa.osgi.service.display.IDisplay;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.LayoutManager;
   import alternativa.tanks.models.battle.gui.gui.statistics.field.Widget;
   import alternativa.tanks.services.battlegui.BattleGUIService;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class DefaultLayout implements LayoutManager
   {
      
      [Inject]
      public static var display:IDisplay;
      
      [Inject]
      public static var battleGUIService:BattleGUIService;
      
      private var deferred:Vector.<Widget> = new Vector.<Widget>();
      
      private var widgets:Vector.<Widget> = new Vector.<Widget>();
      
      private var initialized:Boolean;
      
      public function DefaultLayout()
      {
         super();
         display.stage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      private function onResize(param1:Event) : void
      {
         this.layoutWidgets();
      }
      
      public function onWidgetChanged(param1:Widget) : void
      {
         this.layoutWidgets();
      }
      
      public function layoutWidgets() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc1_:int = int(display.stage.stageWidth);
         var _loc2_:int = 0;
         while(_loc2_ < this.widgets.length)
         {
            _loc3_ = DisplayObject(this.widgets[_loc2_]);
            _loc3_.x = _loc1_ - _loc3_.width - 10;
            _loc3_.y = display.stage.stageHeight - _loc3_.height - 10;
            _loc1_ = _loc3_.x;
            _loc2_++;
         }
         battleGUIService.setPositionXDefaultLayout(_loc1_);
      }
      
      public function addWidget(param1:Widget) : void
      {
         if(this.initialized)
         {
            this.widgets.push(param1);
         }
         else
         {
            this.deferred.push(param1);
         }
         param1.setLayoutManager(this);
         this.onWidgetChanged(param1);
      }
      
      public function addWidget2(param1:Widget) : void
      {
         this.widgets.push(param1);
         param1.setLayoutManager(this);
      }
      
      public function destroy() : void
      {
         display.stage.removeEventListener(Event.RESIZE,this.onResize);
         this.removeWidgets();
      }
      
      private function removeWidgets() : void
      {
         var _loc1_:Widget = null;
         var _loc2_:DisplayObject = null;
         for each(_loc1_ in this.widgets)
         {
            _loc2_ = DisplayObject(_loc1_);
            if(_loc2_.parent != null)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
      }
      
      public function init() : void
      {
         var _loc1_:Widget = null;
         if(!this.initialized)
         {
            this.initialized = true;
            for each(_loc1_ in this.deferred)
            {
               this.widgets.push(_loc1_);
            }
            this.deferred = null;
         }
         this.layoutWidgets();
      }
   }
}

