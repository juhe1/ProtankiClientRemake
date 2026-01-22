package projects.tanks.client.clans.clan.block
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanBlockModelBase extends Model
   {

      protected var server:ClanBlockModelServer;

      public static const modelId:Long = Long.getLong(525873271,1744909560);

      public function ClanBlockModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanBlockModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
