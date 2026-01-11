package projects.tanks.client.battlefield.models.tankparts.weapon.healing
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class IsisModelBase extends Model
   {

      protected var server:IsisModelServer;

      public static const modelId:Long = Long.getLong(1645686167,1474428435);

      public function IsisModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new IsisModelServer(IModel(this));
      }

      protected function getInitParam() : IsisCC
      {
         return IsisCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
