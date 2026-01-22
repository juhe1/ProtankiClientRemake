package projects.tanks.client.entrance.model.entrance.blockvalidator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BlockValidatorModelBase extends Model
   {

      protected var server:BlockValidatorModelServer;

      public static const modelId:Long = Long.getLong(928862932,-197944152);

      public function BlockValidatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BlockValidatorModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
