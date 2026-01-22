package projects.tanks.client.entrance.model.entrance.redirect
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class WarRedirectModelBase extends Model
   {

      protected var server:WarRedirectModelServer;

      public static const modelId:Long = Long.getLong(1401901648,1562179062);

      public function WarRedirectModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new WarRedirectModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
