package projects.tanks.client.garage.models.garage
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.garage.GarageModelCC;

   public class GarageModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1718746868,-1910730614);

      protected var server:GarageModelServer;

      public function GarageModelBase()
      {
         super();
         this.server = new GarageModelServer(IModel(this));
      }

      protected function getInitParam() : GarageModelCC
      {
         return GarageModelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
