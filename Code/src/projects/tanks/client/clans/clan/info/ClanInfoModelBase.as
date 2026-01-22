package projects.tanks.client.clans.clan.info
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanInfoModelBase extends Model
   {

      protected var server:ClanInfoModelServer;

      public static const modelId:Long = Long.getLong(2040178503,1134391066);

      public function ClanInfoModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanInfoModelServer(IModel(this));
      }

      protected function getInitParam() : ClanInfoCC
      {
         return ClanInfoCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
