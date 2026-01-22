package projects.tanks.client.commons.models.linkactivator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class LinkActivatorModelBase extends Model
   {

      protected var server:LinkActivatorModelServer;

      public static const modelId:Long = Long.getLong(650947056,1487530419);

      public function LinkActivatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new LinkActivatorModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
