package projects.tanks.client.garage.models.item.premium
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.premium.PremiumItemCC;

   public class PremiumItemModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(265351749,620223358);

      protected var server:PremiumItemModelServer;

      public function PremiumItemModelBase()
      {
         super();
         this.server = new PremiumItemModelServer(IModel(this));
      }

      protected function getInitParam() : PremiumItemCC
      {
         return PremiumItemCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
