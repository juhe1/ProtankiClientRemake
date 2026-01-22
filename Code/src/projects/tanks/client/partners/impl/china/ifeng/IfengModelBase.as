package projects.tanks.client.partners.impl.china.ifeng
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class IfengModelBase extends Model
   {

      protected var server:IfengModelServer;

      public static const modelId:Long = Long.getLong(1375064574,1426429751);

      public function IfengModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new IfengModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
