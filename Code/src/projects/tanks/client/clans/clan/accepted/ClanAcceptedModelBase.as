package projects.tanks.client.clans.clan.accepted
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.clans.container.ContainerCC;

   public class ClanAcceptedModelBase extends Model
   {

      protected var server:ClanAcceptedModelServer;

      public static const modelId:Long = Long.getLong(202978443,152865914);

      public function ClanAcceptedModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanAcceptedModelServer(IModel(this));
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
