package platform.client.core.general.spaces.loading.dispatcher
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DispatcherModelBase extends Model
   {  
      protected var server:DispatcherModelServer = new DispatcherModelServer(IModel(this));

      static public var modelId:Long = Long.getLong(191355032,163351191);

      public function DispatcherModelBase()
      {
         super();
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
