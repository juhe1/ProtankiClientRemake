package projects.tanks.client.battlefield.models.tankparts.sfx.isis
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class IsisSFXModelBase extends Model
   {

      protected var server:IsisSFXModelServer;

      private static const modelId:Long = Long.getLong(1337638668,-1951387531);

      public function IsisSFXModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new IsisSFXModelServer(IModel(this));
      }

      protected function getInitParam() : IsisSFXCC
      {
         return IsisSFXCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
