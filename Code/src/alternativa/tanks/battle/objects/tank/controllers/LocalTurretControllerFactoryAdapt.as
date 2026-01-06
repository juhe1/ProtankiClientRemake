package alternativa.tanks.battle.objects.tank.controllers
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   
   public class LocalTurretControllerFactoryAdapt implements LocalTurretControllerFactory
   {
      
      private var object:IGameObject;
      
      private var impl:LocalTurretControllerFactory;
      
      public function LocalTurretControllerFactoryAdapt(param1:IGameObject, param2:LocalTurretControllerFactory)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function createLocalTurretController(param1:TurretController) : LocalTurretController
      {
         var result:LocalTurretController = null;
         var turretController:TurretController = param1;
         try
         {
            Model.object = this.object;
            result = this.impl.createLocalTurretController(turretController);
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
   }
}

