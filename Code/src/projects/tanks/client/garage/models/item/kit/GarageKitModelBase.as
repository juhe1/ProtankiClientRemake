package projects.tanks.client.garage.models.item.kit
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.kit.GarageKitCC;

   public class GarageKitModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1215266592,-1320571870);

      protected var server:GarageKitModelServer;

      public function GarageKitModelBase()
      {
         super();
         this.server = new GarageKitModelServer(IModel(this));
      }

      protected function getInitParam() : GarageKitCC
      {
         return GarageKitCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
