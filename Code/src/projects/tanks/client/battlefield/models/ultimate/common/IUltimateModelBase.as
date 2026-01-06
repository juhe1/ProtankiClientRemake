package projects.tanks.client.battlefield.models.ultimate.common
{
   import platform.client.fp10.core.type.IGameObject;
   
   public interface IUltimateModelBase
   {
      
      function showUltimateCharged() : void;
      
      function ultimateUsed(param1:IGameObject) : void;
      
      function updateCharge(param1:int) : void;
      
      function updateChargeRate(param1:Number) : void;
   }
}

