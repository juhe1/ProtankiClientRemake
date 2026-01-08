package platform.client.core.general.socialnetwork.models.socialnetworkparameters
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.impl.Model;

   public class SocialNetworkParametersModelBase extends Model
   {

      static public var modelId:Long = Long.getLong(1480731399,760833293);

      public function SocialNetworkParametersModelBase()
      {
         super();
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
