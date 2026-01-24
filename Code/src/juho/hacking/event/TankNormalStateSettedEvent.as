package juho.hacking.event {
   
   import flash.events.Event;
   import alternativa.tanks.battle.objects.tank.Tank;
   
	/**
    * ...
    * @author juhe
    */
   
   public class TankNormalStateSettedEvent extends Event {
      
      public static const TANK_NORMAL_STATE_SETTED_EVENT:String = "TankNormalStateSettedEvent";
      public var tank:Tank;
      
      public function TankNormalStateSettedEvent(_tank:Tank, bubbles:Boolean = false, cancelable:Boolean = false) {
         super(TANK_NORMAL_STATE_SETTED_EVENT, bubbles, cancelable);
         this.tank = _tank;
      }
      
      override public function clone():Event {
        return new TankNormalStateSettedEvent(this.tank, this.bubbles, this.cancelable);
      }
      
   }

}