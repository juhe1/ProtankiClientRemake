package projects.tanks.client.partners.impl.china.tmall
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TmallModelBase extends Model
   {

      protected var server:TmallModelServer;

      public static const modelId:Long = Long.getLong(614793890,527947515);

      public function TmallModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TmallModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
