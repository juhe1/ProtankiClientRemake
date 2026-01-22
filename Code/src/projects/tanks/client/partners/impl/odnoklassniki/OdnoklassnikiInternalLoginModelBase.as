package projects.tanks.client.partners.impl.odnoklassniki
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class OdnoklassnikiInternalLoginModelBase extends Model
   {

      protected var server:OdnoklassnikiInternalLoginModelServer;

      public static const modelId:Long = Long.getLong(1448441006,1809522840);

      public function OdnoklassnikiInternalLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new OdnoklassnikiInternalLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
