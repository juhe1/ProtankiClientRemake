package projects.tanks.client.partners.impl.vkontakte
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class VkontakteInternalLoginModelBase extends Model
   {

      protected var server:VkontakteInternalLoginModelServer;

      public static const modelId:Long = Long.getLong(1975556474,1605360392);

      public function VkontakteInternalLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new VkontakteInternalLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
