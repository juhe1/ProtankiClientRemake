package projects.tanks.client.battlefield.models.coloradjust
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ColorAdjustModelBase extends Model
   {

      protected var server:ColorAdjustModelServer;

      public static const modelId:Long = Long.getLong(1389685079,-1009241415);

      public function ColorAdjustModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ColorAdjustModelServer(IModel(this));
      }

      protected function getInitParam() : ColorAdjustCC
      {
         return ColorAdjustCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
