package projects.tanks.client.battlefield.models.battle.ctf
{
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public interface ICaptureTheFlagModelBase
   {
      
      function dropFlag(param1:Vector3d, param2:BattleTeam) : void;
      
      function flagDelivered(param1:BattleTeam, param2:String) : void;
      
      function flagTaken(param1:String, param2:BattleTeam) : void;
      
      function returnFlagToBase(param1:BattleTeam, param2:IGameObject) : void;
   }
}

