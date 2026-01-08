package projects.tanks.client.tanksservices.model.uidcheck
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.tanksservices.model.uidcheck.UidCheckCC;

   public class UidCheckModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1543089237,611543143);

      protected var server:UidCheckModelServer;

      public function UidCheckModelBase()
      {
         super();
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
