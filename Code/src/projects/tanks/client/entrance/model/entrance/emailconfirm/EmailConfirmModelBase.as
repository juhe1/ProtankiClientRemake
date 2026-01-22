package projects.tanks.client.entrance.model.entrance.emailconfirm
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class EmailConfirmModelBase extends Model
   {

      protected var server:EmailConfirmModelServer;

      public static const modelId:Long = Long.getLong(284901932,-278416008);

      public function EmailConfirmModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EmailConfirmModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
