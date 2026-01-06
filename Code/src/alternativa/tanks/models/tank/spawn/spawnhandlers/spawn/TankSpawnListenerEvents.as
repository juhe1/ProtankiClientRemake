package alternativa.tanks.models.tank.spawn.spawnhandlers.spawn
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class TankSpawnListenerEvents implements TankSpawnListener
   {
      
      private var object:IGameObject;
      
      private var impl:Vector.<Object>;
      
      public function TankSpawnListenerEvents(param1:IGameObject, param2:Vector.<Object>)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function onTankSpawn() : void
      {
         var i:int = 0;
         var m:TankSpawnListener = null;
         try
         {
            Model.object = this.object;
            i = 0;
            while(i < this.impl.length)
            {
               m = TankSpawnListener(this.impl[i]);
               m.onTankSpawn();
               i++;
            }
         }
         finally
         {
            Model.popObject();
         }
      }
   }
}

