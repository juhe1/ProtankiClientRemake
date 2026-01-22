package projects.tanks.client.partners.impl.china.kuaiwan
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KuaiwanModelBase extends Model
   {

      protected var server:KuaiwanModelServer;

      public static const modelId:Long = Long.getLong(1470822165,2019480089);

      public function KuaiwanModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KuaiwanModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
