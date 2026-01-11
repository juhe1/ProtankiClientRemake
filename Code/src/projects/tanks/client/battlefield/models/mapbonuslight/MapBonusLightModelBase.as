package projects.tanks.client.battlefield.models.mapbonuslight
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MapBonusLightModelBase extends Model
   {

      protected var server:MapBonusLightModelServer;

      public static const modelId:Long = Long.getLong(393217538,1110646825);

      public function MapBonusLightModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MapBonusLightModelServer(IModel(this));
      }

      protected function getInitParam() : MapBonusLightCC
      {
         return MapBonusLightCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
