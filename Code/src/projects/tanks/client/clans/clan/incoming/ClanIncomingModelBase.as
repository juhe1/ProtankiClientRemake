package projects.tanks.client.clans.clan.incoming
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.clans.container.ContainerCC;

   public class ClanIncomingModelBase extends Model
   {

      protected var server:ClanIncomingModelServer;

      public static const modelId:Long = Long.getLong(794660588,-483099162);

      public function ClanIncomingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanIncomingModelServer(IModel(this));
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
