package projects.tanks.client.commons.models.captcha
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class CaptchaModelBase extends Model
   {

      protected var server:CaptchaModelServer;

      public static const modelId:Long = Long.getLong(490831193,1530810385);

      public function CaptchaModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new CaptchaModelServer(IModel(this));
      }

      protected function getInitParam() : CaptchaCC
      {
         return CaptchaCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
