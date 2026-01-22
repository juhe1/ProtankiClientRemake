package projects.tanks.client.partners.impl.china.partner360platform
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class Partner360PlatformModelBase extends Model
   {

      protected var server:Partner360PlatformModelServer;

      public static const modelId:Long = Long.getLong(601165383,1506017039);

      public function Partner360PlatformModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new Partner360PlatformModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
