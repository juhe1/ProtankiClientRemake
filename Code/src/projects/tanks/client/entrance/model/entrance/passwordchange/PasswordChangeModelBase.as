package projects.tanks.client.entrance.model.entrance.passwordchange
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PasswordChangeModelBase extends Model
   {

      protected var server:PasswordChangeModelServer;

      public static const modelId:Long = Long.getLong(2144135680,-1866277160);

      public function PasswordChangeModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PasswordChangeModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
