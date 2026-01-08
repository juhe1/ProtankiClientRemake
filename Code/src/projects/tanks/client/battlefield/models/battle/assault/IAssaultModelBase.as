package projects.tanks.client.battlefield.models.battle.assault
{
   import alternativa.types.Long;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public interface IAssaultModelBase
   {
      
      function dropFlag(param1:int, param2:Vector3d) : void;
      
      function flagDelivered(param1:int, param2:int, param3:Long) : void;
      
      function flagTaken(param1:int, param2:Long) : void;
      
      function returnFlagToBase(param1:int, param2:IGameObject) : void;
   }
}

