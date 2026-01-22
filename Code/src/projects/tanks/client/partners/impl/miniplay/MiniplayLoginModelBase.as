package projects.tanks.client.partners.impl.miniplay
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MiniplayLoginModelBase extends Model
   {

      protected var server:MiniplayLoginModelServer;

      public static const modelId:Long = Long.getLong(1395350347,-677112271);

      public function MiniplayLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MiniplayLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
