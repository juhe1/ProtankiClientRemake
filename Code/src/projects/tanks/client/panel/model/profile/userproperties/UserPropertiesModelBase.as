package projects.tanks.client.panel.model.profile.userproperties
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.panel.model.profile.userproperties.UserPropertiesCC;

   public class UserPropertiesModelBase extends Model
   {

      static public var modelId:Long = Long.getLong(440843623,678812097);

      public function UserPropertiesModelBase()
      {
         super();
      }

      protected function getInitParam() : UserPropertiesCC
      {
         return UserPropertiesCC(initParams[platform.client.fp10.core.model.impl.Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
