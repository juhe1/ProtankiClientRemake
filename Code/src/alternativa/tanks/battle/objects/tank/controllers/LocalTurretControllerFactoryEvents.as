package alternativa.tanks.battle.objects.tank.controllers
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class LocalTurretControllerFactoryEvents implements LocalTurretControllerFactory
   {
      
      private var object:IGameObject;
      
      private var impl:Vector.<Object>;
      
      public function LocalTurretControllerFactoryEvents(param1:IGameObject, param2:Vector.<Object>)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function createLocalTurretController(param1:TurretController) : LocalTurretController
      {
         var result:LocalTurretController = null;
         var i:int = 0;
         var m:LocalTurretControllerFactory = null;
         var turretController:TurretController = param1;
         try
         {
            Model.object = this.object;
            i = 0;
            while(i < this.impl.length)
            {
               m = LocalTurretControllerFactory(this.impl[i]);
               result = m.createLocalTurretController(turretController);
               i++;
            }
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
   }
}

