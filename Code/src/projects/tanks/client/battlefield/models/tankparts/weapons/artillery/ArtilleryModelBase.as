package projects.tanks.client.battlefield.models.tankparts.weapons.artillery
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ArtilleryModelBase extends Model
   {

      protected var server:ArtilleryModelServer;

      public static const modelId:Long = Long.getLong(1546475564,-1431010080);

      public function ArtilleryModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ArtilleryModelServer(IModel(this));
      }

      protected function getInitParam() : ArtilleryCC
      {
         return ArtilleryCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
