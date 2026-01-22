package projects.tanks.client.entrance.model.entrance.newbie
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class NewbieRegistrationModelBase extends Model
   {

      protected var server:NewbieRegistrationModelServer;

      public static const modelId:Long = Long.getLong(1743693009,-1561207791);

      public function NewbieRegistrationModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new NewbieRegistrationModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
