package projects.tanks.client.clans.panel.loadingclan
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanLoadingPanelModelBase extends Model
   {

      protected var server:ClanLoadingPanelModelServer;

      public static const modelId:Long = Long.getLong(1454635600,1588551742);

      public function ClanLoadingPanelModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanLoadingPanelModelServer(IModel(this));
      }

      protected function getInitParam() : ClanLoadingPanelCC
      {
         return ClanLoadingPanelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
