package projects.tanks.client.tanksservices.model.uidcheck
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class UidCheckModelBase extends Model
   {

      protected var server:UidCheckModelServer;

      public static const modelId:Long = Long.getLong(1543089237,611543143);

      public function UidCheckModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new UidCheckModelServer(IModel(this));
      }

      protected function getInitParam() : UidCheckCC
      {
         return UidCheckCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
