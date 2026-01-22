package projects.tanks.client.clans.user
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanUserLoaderModelBase extends Model
   {

      protected var server:ClanUserLoaderModelServer;

      public static const modelId:Long = Long.getLong(1420566941,-260091189);

      public function ClanUserLoaderModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanUserLoaderModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
