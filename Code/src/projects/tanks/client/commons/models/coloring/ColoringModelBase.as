package projects.tanks.client.commons.models.coloring
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ColoringModelBase extends Model
   {

      protected var server:ColoringModelServer;

      public static const modelId:Long = Long.getLong(947299051,-358915161);

      public function ColoringModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ColoringModelServer(IModel(this));
      }

      protected function getInitParam() : ColoringCC
      {
         return ColoringCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
