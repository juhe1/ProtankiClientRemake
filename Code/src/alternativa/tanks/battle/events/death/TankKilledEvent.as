package alternativa.tanks.battle.events.death
{
   import alternativa.types.Long;
   import projects.tanks.client.battlefield.types.DamageType;
   
   public class TankKilledEvent
   {
      
      public var killerId:String;
      
      public var victimId:String;
      
      public var damageType:DamageType;
      
      public function TankKilledEvent(param1:String, param2:String, param3:DamageType)
      {
         super();
         this.killerId = param1;
         this.victimId = param2;
         this.damageType = param3;
      }
   }
}

