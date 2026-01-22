package projects.tanks.client.clans.panel.clanpanel
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanPanelModelBase extends Model
   {

      protected var server:ClanPanelModelServer;

      public static const modelId:Long = Long.getLong(813924329,-50132824);

      public function ClanPanelModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanPanelModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
