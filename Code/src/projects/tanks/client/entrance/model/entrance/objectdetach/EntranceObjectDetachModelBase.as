package projects.tanks.client.entrance.model.entrance.objectdetach
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class EntranceObjectDetachModelBase extends Model
   {

      protected var server:EntranceObjectDetachModelServer;

      public static const modelId:Long = Long.getLong(1377053011,190397042);

      public function EntranceObjectDetachModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EntranceObjectDetachModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
