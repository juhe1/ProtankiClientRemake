package projects.tanks.client.clans.clan.acceptednotificator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.clans.container.ContainerCC;

   public class ClanAcceptedNotificatorModelBase extends Model
   {

      protected var server:ClanAcceptedNotificatorModelServer;

      public static const modelId:Long = Long.getLong(1575927935,-367368112);

      public function ClanAcceptedNotificatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanAcceptedNotificatorModelServer(IModel(this));
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
