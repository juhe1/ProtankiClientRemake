package projects.tanks.client.clans.user.incomingnotificator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.clans.container.ContainerCC;

   public class ClanUserIncomingNotificatorModelBase extends Model
   {

      protected var server:ClanUserIncomingNotificatorModelServer;

      public static const modelId:Long = Long.getLong(151267905,-1393229156);

      public function ClanUserIncomingNotificatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanUserIncomingNotificatorModelServer(IModel(this));
      }

      protected function getInitParam() : ContainerCC
      {
         return ContainerCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
