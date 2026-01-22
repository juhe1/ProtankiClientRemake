package projects.tanks.client.clans.clan.incomingnotificator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.clans.container.ContainerCC;

   public class ClanIncomingNotificatorModelBase extends Model
   {

      protected var server:ClanIncomingNotificatorModelServer;

      public static const modelId:Long = Long.getLong(1448266566,-1893699662);

      public function ClanIncomingNotificatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanIncomingNotificatorModelServer(IModel(this));
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
