package projects.tanks.client.clans.user.incoming
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.clans.container.ContainerCC;

   public class ClanUserIncomingModelBase extends Model
   {

      protected var server:ClanUserIncomingModelServer;

      public static const modelId:Long = Long.getLong(1120804751,-1974844538);

      public function ClanUserIncomingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanUserIncomingModelServer(IModel(this));
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
