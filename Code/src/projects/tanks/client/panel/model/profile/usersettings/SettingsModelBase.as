package projects.tanks.client.panel.model.profile.usersettings
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SettingsModelBase extends Model
   {

      protected var server:SettingsModelServer;

      public static const modelId:Long = Long.getLong(1428989873,1951780812);

      public function SettingsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SettingsModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
