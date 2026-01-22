package projects.tanks.client.clans.space.createclan
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanCreateModelBase extends Model
   {

      protected var server:ClanCreateModelServer;

      public static const modelId:Long = Long.getLong(1406824912,-478599334);

      public function ClanCreateModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanCreateModelServer(IModel(this));
      }

      protected function getInitParam() : ClanCreateCC
      {
         return ClanCreateCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
