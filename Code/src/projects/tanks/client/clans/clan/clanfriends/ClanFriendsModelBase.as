package projects.tanks.client.clans.clan.clanfriends
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanFriendsModelBase extends Model
   {

      protected var server:ClanFriendsModelServer;

      public static const modelId:Long = Long.getLong(1889621503,1893984398);

      public function ClanFriendsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanFriendsModelServer(IModel(this));
      }

      protected function getInitParam() : ClanFriendsCC
      {
         return ClanFriendsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
