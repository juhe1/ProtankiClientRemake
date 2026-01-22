package projects.tanks.client.panel.model.profile.useremailpassword
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UserEmailAndPasswordModelBase extends Model
   {

      protected var server:UserEmailAndPasswordModelServer;

      public static const modelId:Long = Long.getLong(740369199,944909632);

      public function UserEmailAndPasswordModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
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
