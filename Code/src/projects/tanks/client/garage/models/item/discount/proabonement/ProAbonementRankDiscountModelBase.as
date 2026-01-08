package projects.tanks.client.garage.models.item.discount.proabonement
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.discount.proabonement.ProAbonementRankDiscountCC;

   public class ProAbonementRankDiscountModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1092583570,-2129915601);

      protected var server:ProAbonementRankDiscountModelServer;

      public function ProAbonementRankDiscountModelBase()
      {
         super();
         this.server = new ProAbonementRankDiscountModelServer(IModel(this));
      }

      protected function getInitParam() : ProAbonementRankDiscountCC
      {
         return ProAbonementRankDiscountCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
