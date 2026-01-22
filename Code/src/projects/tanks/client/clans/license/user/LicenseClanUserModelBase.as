package projects.tanks.client.clans.license.user
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class LicenseClanUserModelBase extends Model
   {

      protected var server:LicenseClanUserModelServer;

      public static const modelId:Long = Long.getLong(1978103354,1644120870);

      public function LicenseClanUserModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new LicenseClanUserModelServer(IModel(this));
      }

      protected function getInitParam() : LicenseClanUserCC
      {
         return LicenseClanUserCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
