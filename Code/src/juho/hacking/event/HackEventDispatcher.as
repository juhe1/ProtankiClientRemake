package juho.hacking.event {
   import flash.events.EventDispatcher;
	/**
    * ...
    * @author juhe
    * 
    * These are some events that you can listen by adding event listenner to the singleton
    */
   public class HackEventDispatcher extends EventDispatcher {
      
      public static var singleton:HackEventDispatcher = new HackEventDispatcher();
      
      public function HackEventDispatcher() {
         super();
      }
      
   }

}