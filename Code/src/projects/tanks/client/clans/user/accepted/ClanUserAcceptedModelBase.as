package projects.tanks.client.clans.user.accepted
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.clans.container.ContainerCC;

   public class ClanUserAcceptedModelBase extends Model
   {

      protected var server:ClanUserAcceptedModelServer;

      public static const modelId:Long = Long.getLong(471234096,-1683897946);

      public function ClanUserAcceptedModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanUserAcceptedModelServer(IModel(this));
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
