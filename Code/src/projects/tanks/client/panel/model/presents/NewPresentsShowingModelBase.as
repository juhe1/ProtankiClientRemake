package projects.tanks.client.panel.model.presents
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class NewPresentsShowingModelBase extends Model
   {

      protected var server:NewPresentsShowingModelServer;

      public static const modelId:Long = Long.getLong(1012007416,-1351622809);

      public function NewPresentsShowingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new NewPresentsShowingModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
