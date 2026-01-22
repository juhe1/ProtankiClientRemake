package projects.tanks.client.battleselect.model.map
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MapInfoModelBase extends Model
   {

      protected var server:MapInfoModelServer;

      public static const modelId:Long = Long.getLong(1260204725,-1362969538);

      public function MapInfoModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MapInfoModelServer(IModel(this));
      }

      protected function getInitParam() : MapInfoCC
      {
         return MapInfoCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
