package projects.tanks.client.panel.model.panel
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class PanelModelBase extends Model
   {

      protected var server:PanelModelServer;

      public static const modelId:Long = Long.getLong(469211470,2012932912);

      public function PanelModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new PanelModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
