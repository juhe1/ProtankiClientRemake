package projects.tanks.client.battlefield.models.tankparts.sfx.colortransform
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ColorTransformModelBase extends Model
   {

      protected var server:ColorTransformModelServer;

      public static const modelId:Long = Long.getLong(1855402535,537941602);

      public function ColorTransformModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ColorTransformModelServer(IModel(this));
      }

      protected function getInitParam() : ColorTransformCC
      {
         return ColorTransformCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
