package projects.tanks.client.partners.impl.steam
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SteamLoginModelBase extends Model
   {

      protected var server:SteamLoginModelServer;

      public static const modelId:Long = Long.getLong(194944991,-714985429);

      public function SteamLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SteamLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
