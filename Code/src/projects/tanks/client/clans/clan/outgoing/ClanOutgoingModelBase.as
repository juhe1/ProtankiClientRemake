package projects.tanks.client.clans.clan.outgoing
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.clans.container.ContainerCC;

   public class ClanOutgoingModelBase extends Model
   {

      protected var server:ClanOutgoingModelServer;

      public static const modelId:Long = Long.getLong(1408324582,-1932105818);

      public function ClanOutgoingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanOutgoingModelServer(IModel(this));
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
