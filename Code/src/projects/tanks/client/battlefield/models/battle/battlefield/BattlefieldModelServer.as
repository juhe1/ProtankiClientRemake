package projects.tanks.client.battlefield.models.battle.battlefield
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.battle.battlefield.fps.FpsStatisticType;

   public class BattlefieldModelServer
   {

      private var model:IModel;

      public function BattlefieldModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function dg(param1:Vector.<int>) : void
      {
      }

      public function kd(param1:int) : void
      {
      }

      public function sendTimeStatisticsCommand(param1:FpsStatisticType, param2:Number) : void
      {
      }

      public function xc() : void
      {
      }
   }
}
