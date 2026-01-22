package projects.tanks.client.clans.user.outgoing
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.clans.container.ContainerCC;

   public class ClanUserOutgoingModelBase extends Model
   {

      protected var server:ClanUserOutgoingModelServer;

      public static const modelId:Long = Long.getLong(205268203,-139952058);

      public function ClanUserOutgoingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanUserOutgoingModelServer(IModel(this));
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
