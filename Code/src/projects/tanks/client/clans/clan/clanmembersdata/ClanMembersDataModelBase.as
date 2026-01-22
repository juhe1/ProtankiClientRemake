package projects.tanks.client.clans.clan.clanmembersdata
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanMembersDataModelBase extends Model
   {

      protected var server:ClanMembersDataModelServer;

      public static const modelId:Long = Long.getLong(1647741962,-1293471250);

      public function ClanMembersDataModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanMembersDataModelServer(IModel(this));
      }

      protected function getInitParam() : ClanMembersCC
      {
         return ClanMembersCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
