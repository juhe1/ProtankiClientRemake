package projects.tanks.client.commons.models.clienthalt
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ServerHaltModelBase extends Model
   {

      protected var server:ServerHaltModelServer;

      public static const modelId:Long = Long.getLong(1670604947,523994521);

      public function ServerHaltModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ServerHaltModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
