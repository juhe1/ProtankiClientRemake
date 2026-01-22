package projects.tanks.client.entrance.model.entrance.google
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class GoogleEntranceModelBase extends Model
   {

      protected var server:GoogleEntranceModelServer;

      public static const modelId:Long = Long.getLong(1267467218,-492548110);

      public function GoogleEntranceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new GoogleEntranceModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
