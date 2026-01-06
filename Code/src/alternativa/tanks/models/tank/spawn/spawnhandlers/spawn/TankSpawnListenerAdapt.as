package alternativa.tanks.models.tank.spawn.spawnhandlers.spawn
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class TankSpawnListenerAdapt implements TankSpawnListener
   {
      
      private var object:IGameObject;
      
      private var impl:TankSpawnListener;
      
      public function TankSpawnListenerAdapt(param1:IGameObject, param2:TankSpawnListener)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function onTankSpawn() : void
      {
         try
         {
            Model.object = this.object;
            this.impl.onTankSpawn();
         }
         finally
         {
            Model.popObject();
         }
      }
   }
}

