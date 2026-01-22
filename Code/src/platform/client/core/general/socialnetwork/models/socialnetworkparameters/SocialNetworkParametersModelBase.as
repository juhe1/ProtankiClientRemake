package platform.client.core.general.socialnetwork.models.socialnetworkparameters
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SocialNetworkParametersModelBase extends Model
   {

      protected var server:SocialNetworkParametersModelServer;

      public static const modelId:Long = Long.getLong(1480731399,760833293);

      public function SocialNetworkParametersModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SocialNetworkParametersModelServer(IModel(this));
      }

      protected function getInitParam() : SocialNetworkParametersCC
      {
         return SocialNetworkParametersCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
