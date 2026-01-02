package projects.tanks.client.panel.model.profile.useremailpassword
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.panel.model.profile.useremailpassword.UserEmailAndPasswordModelServer;
   import projects.tanks.client.panel.model.profile.useremailpassword.UserEmailCC;
   
   public class UserEmailAndPasswordModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(740369199,944909632);
      
      protected var server:UserEmailAndPasswordModelServer;
      
      public function UserEmailAndPasswordModelBase()
      {
         super();
         this.server = new UserEmailAndPasswordModelServer(IModel(this));
      }
      
      protected function getInitParam() : UserEmailCC
      {
         return UserEmailCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

