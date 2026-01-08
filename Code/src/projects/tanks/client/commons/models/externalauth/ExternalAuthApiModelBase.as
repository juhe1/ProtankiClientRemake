package projects.tanks.client.commons.models.externalauth
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ExternalAuthApiModelBase extends Model
   {
      protected var server:ExternalAuthApiModelServer;

      static public var modelId:Long = Long.getLong(1069448555,141534959);

      public function ExternalAuthApiModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ExternalAuthApiModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
