package projects.tanks.client.clans.user
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanUserModelBase extends Model
   {

      protected var server:ClanUserModelServer;

      public static const modelId:Long = Long.getLong(259670316,1522052296);

      public function ClanUserModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanUserModelServer(IModel(this));
      }

      protected function getInitParam() : ClanUserCC
      {
         return ClanUserCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
