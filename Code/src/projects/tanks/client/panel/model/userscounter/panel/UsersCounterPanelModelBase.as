package projects.tanks.client.panel.model.userscounter.panel
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UsersCounterPanelModelBase extends Model
   {

      protected var server:UsersCounterPanelModelServer;

      public static const modelId:Long = Long.getLong(1626818804,-815772060);

      public function UsersCounterPanelModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new UsersCounterPanelModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
