package projects.tanks.client.clans.user.acceptednotificator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.clans.container.ContainerCC;

   public class ClanUserAcceptedNotificatorModelBase extends Model
   {

      protected var server:ClanUserAcceptedNotificatorModelServer;

      public static const modelId:Long = Long.getLong(1233534043,-1972982554);

      public function ClanUserAcceptedNotificatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanUserAcceptedNotificatorModelServer(IModel(this));
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
