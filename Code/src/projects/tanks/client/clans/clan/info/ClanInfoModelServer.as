package projects.tanks.client.clans.clan.info
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ClanInfoModelServer
   {

      private var model:IModel;

      public function ClanInfoModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function changeFlag(param1:Long) : void
      {
      }

      public function changeMinRankForAddClan(param1:int) : void
      {
      }

      public function incomingRequestEnable(param1:Boolean) : void
      {
      }

      public function updateDescription(param1:String) : void
      {
      }
   }
}
