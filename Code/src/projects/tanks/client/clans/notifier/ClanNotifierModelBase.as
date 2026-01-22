package projects.tanks.client.clans.notifier
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanNotifierModelBase extends Model
   {

      protected var server:ClanNotifierModelServer;

      public static const modelId:Long = Long.getLong(1850785827,-2022019480);

      public function ClanNotifierModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanNotifierModelServer(IModel(this));
      }

      protected function getInitParam() : ClanNotifierData
      {
         return ClanNotifierData(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
