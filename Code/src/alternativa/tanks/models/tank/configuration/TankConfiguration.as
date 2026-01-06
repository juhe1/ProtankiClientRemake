package alternativa.tanks.models.tank.configuration
{
   import platform.client.fp10.core.type.IGameObject;
   
   [ModelInterface]
   public interface TankConfiguration
   {
      
      function getHullObject() : IGameObject;
      
      function getTurretObject() : IGameObject;
      
      function getColoringObject() : IGameObject;
      
      function hasDrone() : Boolean;
      
      function getDrone() : IGameObject;
   }
}

