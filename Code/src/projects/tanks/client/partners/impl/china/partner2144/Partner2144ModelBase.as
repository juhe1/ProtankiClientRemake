package projects.tanks.client.partners.impl.china.partner2144
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class Partner2144ModelBase extends Model
   {

      protected var server:Partner2144ModelServer;

      public static const modelId:Long = Long.getLong(1460794337,-1064876227);

      public function Partner2144ModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new Partner2144ModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
