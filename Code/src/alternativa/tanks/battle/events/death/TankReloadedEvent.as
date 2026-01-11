package alternativa.tanks.battle.events.death
{
   import alternativa.types.Long;
   
   public class TankReloadedEvent
   {
      
      public var userId:String;
      
      public function TankReloadedEvent(param1:String)
      {
         super();
         this.userId = param1;
      }
   }
}

