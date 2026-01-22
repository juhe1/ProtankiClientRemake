package projects.tanks.client.commons.models.layout
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class LobbyLayoutModelBase extends Model
   {

      protected var server:LobbyLayoutModelServer;

      public static const modelId:Long = Long.getLong(1223707112,492148927);

      public function LobbyLayoutModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new LobbyLayoutModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
