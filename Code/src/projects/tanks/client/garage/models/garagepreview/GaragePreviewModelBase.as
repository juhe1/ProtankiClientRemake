package projects.tanks.client.garage.models.garagepreview
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.garagepreview.GaragePreviewModelCC;

   public class GaragePreviewModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(868501559,1837500388);

      protected var server:GaragePreviewModelServer;

      public function GaragePreviewModelBase()
      {
         super();
         this.server = new GaragePreviewModelServer(IModel(this));
      }

      protected function getInitParam() : GaragePreviewModelCC
      {
         return GaragePreviewModelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
