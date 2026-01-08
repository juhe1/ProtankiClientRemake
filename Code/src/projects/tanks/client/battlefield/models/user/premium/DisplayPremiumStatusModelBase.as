package projects.tanks.client.battlefield.models.user.premium
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DisplayPremiumStatusModelBase extends Model
   {

      protected var server:DisplayPremiumStatusModelServer;

      private static const modelId:Long = Long.getLong(1601138461,-1906543250);

      public function DisplayPremiumStatusModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DisplayPremiumStatusModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
