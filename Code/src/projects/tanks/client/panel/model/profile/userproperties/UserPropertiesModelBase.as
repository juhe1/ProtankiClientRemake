package projects.tanks.client.panel.model.profile.userproperties
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UserPropertiesModelBase extends Model
   {

      protected var server:UserPropertiesModelServer;

      public static const modelId:Long = Long.getLong(440843623,678812097);

      public function UserPropertiesModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new UserPropertiesModelServer(IModel(this));
      }

      protected function getInitParam() : UserPropertiesCC
      {
         return UserPropertiesCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
