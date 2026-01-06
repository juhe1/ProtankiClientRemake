package alternativa.tanks.models.tank
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.tanks.battle.objects.tank.Tank;
   import platform.client.fp10.core.type.IGameObject;
   
   public interface LocalTankInfoService
   {
      
      function isLocalTankLoaded() : Boolean;
      
      function getTurret3D() : Object3D;
      
      function getLocalTankObject() : IGameObject;
      
      function getLocalTank() : Tank;
   }
}

