package projects.tanks.client.commons.models.gpu
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class GPUDetectorModelBase extends Model
   {

      protected var server:GPUDetectorModelServer;

      public static const modelId:Long = Long.getLong(1158058266,-421680869);

      public function GPUDetectorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new GPUDetectorModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
