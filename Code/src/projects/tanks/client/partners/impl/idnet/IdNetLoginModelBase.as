package projects.tanks.client.partners.impl.idnet
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class IdNetLoginModelBase extends Model
   {

      protected var server:IdNetLoginModelServer;

      public static const modelId:Long = Long.getLong(1880203183,683409447);

      public function IdNetLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new IdNetLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
