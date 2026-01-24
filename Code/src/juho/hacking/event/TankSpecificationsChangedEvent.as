package juho.hacking.event {
   
   import flash.events.Event;
   import alternativa.tanks.battle.objects.tank.Tank;
   
	/**
    * ...
    * @author juhe
    */
   
   public class TankSpecificationsChangedEvent extends Event {
      
      public static const TANK_SPECIFICATIONS_CHANGED_EVENT:String = "TankSpecificationsChangedEvent";
      public var tank:Tank;
      
      public function TankSpecificationsChangedEvent(_tank:Tank, bubbles:Boolean = false, cancelable:Boolean = false) {
         super(TANK_SPECIFICATIONS_CHANGED_EVENT, bubbles, cancelable);
         this.tank = _tank;
      }
      
      override public function clone():Event {
        return new TankSpecificationsChangedEvent(this.tank, this.bubbles, this.cancelable);
      }
      
   }

}