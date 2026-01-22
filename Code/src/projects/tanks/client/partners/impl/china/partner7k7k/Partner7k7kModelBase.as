package projects.tanks.client.partners.impl.china.partner7k7k
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class Partner7k7kModelBase extends Model
   {

      protected var server:Partner7k7kModelServer;

      public static const modelId:Long = Long.getLong(1834043231,-1989349461);

      public function Partner7k7kModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new Partner7k7kModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
