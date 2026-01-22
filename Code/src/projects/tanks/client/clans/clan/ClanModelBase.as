package projects.tanks.client.clans.clan
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanModelBase extends Model
   {

      protected var server:ClanModelServer;

      public static const modelId:Long = Long.getLong(454139398,-2069165154);

      public function ClanModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
