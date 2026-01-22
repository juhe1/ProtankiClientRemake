package projects.tanks.client.entrance.model.entrance.entrance
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class EntranceModelBase extends Model
   {

      protected var server:EntranceModelServer;

      public static const modelId:Long = Long.getLong(687101726,-1582366168);

      public function EntranceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new EntranceModelServer(IModel(this));
      }

      protected function getInitParam() : EntranceModelCC
      {
         return EntranceModelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
