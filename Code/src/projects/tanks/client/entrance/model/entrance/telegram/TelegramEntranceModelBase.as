package projects.tanks.client.entrance.model.entrance.telegram
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TelegramEntranceModelBase extends Model
   {

      protected var server:TelegramEntranceModelServer;

      public static const modelId:Long = Long.getLong(1128540715,1798214066);

      public function TelegramEntranceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TelegramEntranceModelServer(IModel(this));
      }

      protected function getInitParam() : TelegramEntranceModelCC
      {
         return TelegramEntranceModelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
