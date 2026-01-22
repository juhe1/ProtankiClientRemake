package projects.tanks.client.panel.model.usercountry
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UserCountryModelBase extends Model
   {

      protected var server:UserCountryModelServer;

      public static const modelId:Long = Long.getLong(484417400,-1976122270);

      public function UserCountryModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new UserCountryModelServer(IModel(this));
      }

      protected function getInitParam() : UserCountryCC
      {
         return UserCountryCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
