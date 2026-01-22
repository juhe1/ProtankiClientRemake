package projects.tanks.client.panel.model.socialnetwork
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SocialNetworkPanelModelBase extends Model
   {

      protected var server:SocialNetworkPanelModelServer;

      public static const modelId:Long = Long.getLong(439695750,646961384);

      public function SocialNetworkPanelModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SocialNetworkPanelModelServer(IModel(this));
      }

      protected function getInitParam() : SocialNetworkPanelCC
      {
         return SocialNetworkPanelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
