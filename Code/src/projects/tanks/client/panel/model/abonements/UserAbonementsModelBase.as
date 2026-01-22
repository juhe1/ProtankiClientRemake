package projects.tanks.client.panel.model.abonements
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UserAbonementsModelBase extends Model
   {

      protected var server:UserAbonementsModelServer;

      public static const modelId:Long = Long.getLong(13210116,-2135305231);

      public function UserAbonementsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new UserAbonementsModelServer(IModel(this));
      }

      protected function getInitParam() : UserAbonementsCC
      {
         return UserAbonementsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
