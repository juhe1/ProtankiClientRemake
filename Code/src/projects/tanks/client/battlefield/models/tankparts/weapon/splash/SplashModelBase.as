package projects.tanks.client.battlefield.models.tankparts.weapon.splash
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SplashModelBase extends Model
   {

      protected var server:SplashModelServer;

      public static const modelId:Long = Long.getLong(520601216,-983741199);

      public function SplashModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SplashModelServer(IModel(this));
      }

      protected function getInitParam() : SplashCC
      {
         return SplashCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
