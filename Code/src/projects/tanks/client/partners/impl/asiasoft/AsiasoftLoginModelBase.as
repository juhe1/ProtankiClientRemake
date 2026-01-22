package projects.tanks.client.partners.impl.asiasoft
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AsiasoftLoginModelBase extends Model
   {

      protected var server:AsiasoftLoginModelServer;

      public static const modelId:Long = Long.getLong(207007060,1485489233);

      public function AsiasoftLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AsiasoftLoginModelServer(IModel(this));
      }

      protected function getInitParam() : AsiasoftLoginCC
      {
         return AsiasoftLoginCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
