package projects.tanks.client.partners.impl.fakepartner
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FakePartnerLoginModelBase extends Model
   {

      protected var server:FakePartnerLoginModelServer;

      public static const modelId:Long = Long.getLong(788926934,-2079503035);

      public function FakePartnerLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FakePartnerLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
