package alternativa.tanks.battle.objects.tank
{
   public class ClientTankState
   {
      
      public static const DEAD:ClientTankState = new ClientTankState();
      
      public static const SEMI_ACTIVE:ClientTankState = new ClientTankState();
      
      public static const ACTIVE:ClientTankState = new ClientTankState();
      
      public function ClientTankState()
      {
         super();
      }
   }
}

