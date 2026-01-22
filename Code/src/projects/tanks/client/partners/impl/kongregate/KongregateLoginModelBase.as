package projects.tanks.client.partners.impl.kongregate
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class KongregateLoginModelBase extends Model
   {

      protected var server:KongregateLoginModelServer;

      public static const modelId:Long = Long.getLong(1174174331,-1656823281);

      public function KongregateLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new KongregateLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
