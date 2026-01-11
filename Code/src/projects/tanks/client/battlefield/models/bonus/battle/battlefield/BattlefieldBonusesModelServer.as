package projects.tanks.client.battlefield.models.bonus.battle.battlefield
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;
   import alternativa.types.Long;

   public class BattlefieldBonusesModelServer
   {

      private var model:IModel;

      public function BattlefieldBonusesModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function attemptToTakeBonus(param1:String) : void
      {
      }
   }
}
