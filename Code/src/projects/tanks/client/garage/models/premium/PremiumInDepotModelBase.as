package projects.tanks.client.garage.models.premium
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PremiumInDepotModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(486679052,361206197);

      protected var server:PremiumInDepotModelServer;

      public function PremiumInDepotModelBase()
      {
         super();
         this.server = new PremiumInDepotModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
