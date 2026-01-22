package projects.tanks.client.panel.model.shop.emailrequired
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class EmailRequiredModelBase extends Model
   {

      protected var server:EmailRequiredModelServer;

      public static const modelId:Long = Long.getLong(1570409509,1727350312);

      public function EmailRequiredModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EmailRequiredModelServer(IModel(this));
      }

      protected function getInitParam() : EmailRequiredCC
      {
         return EmailRequiredCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
