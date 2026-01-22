package projects.tanks.client.panel.model.newbiesabonement
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class NewbiesAbonementShowInfoModelBase extends Model
   {

      protected var server:NewbiesAbonementShowInfoModelServer;

      public static const modelId:Long = Long.getLong(1118509469,-35521391);

      public function NewbiesAbonementShowInfoModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new NewbiesAbonementShowInfoModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
