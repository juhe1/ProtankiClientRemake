package projects.tanks.client.battlefield.models.battle.gui.chat
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BattleChatModelBase extends Model
   {

      protected var server:BattleChatModelServer;

      public static const modelId:Long = Long.getLong(1254001332,-1596966842);

      public function BattleChatModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BattleChatModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
