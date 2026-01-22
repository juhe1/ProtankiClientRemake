package projects.tanks.client.panel.model.profile.usersettings
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class SettingsModelBase extends Model
   {
      public static var modelId:Long = Long.getLong(1428989873,1951780812);
      
      protected var server:SettingsModelServer;
      
      public function SettingsModelBase()
      {
         super();
         this.server = new SettingsModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

