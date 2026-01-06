package alternativa.tanks.models.battle.gui.gui.statistics.field.wink
{
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class WinkManager
   {
      
      private static var _instance:WinkManager;
      
      private var timer:Timer;
      
      private var fields:Dictionary;
      
      private var numFields:int;
      
      private var visible:Boolean;
      
      public function WinkManager(param1:int)
      {
         super();
         this.fields = new Dictionary();
         this.timer = new Timer(param1);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      public static function init(param1:int) : void
      {
         if(_instance == null)
         {
            _instance = new WinkManager(param1);
         }
      }
      
      public static function get instance() : WinkManager
      {
         return _instance;
      }
      
      public function addField(param1:IWinkingField) : void
      {
         if(this.fields[param1] == null)
         {
            this.fields[param1] = param1;
            ++this.numFields;
            if(this.numFields == 1)
            {
               this.timer.start();
            }
         }
      }
      
      public function removeField(param1:IWinkingField) : void
      {
         if(this.fields[param1] != null)
         {
            param1.setVisible(true);
            delete this.fields[param1];
            --this.numFields;
            if(this.numFields == 0)
            {
               this.timer.stop();
               this.visible = true;
            }
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:IWinkingField = null;
         if(this.numFields > 0)
         {
            this.visible = !this.visible;
            for each(_loc2_ in this.fields)
            {
               _loc2_.setVisible(this.visible);
            }
         }
      }
   }
}

