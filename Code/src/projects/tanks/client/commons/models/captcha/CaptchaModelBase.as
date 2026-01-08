package projects.tanks.client.commons.models.captcha
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.model.IModel;

   public class CaptchaModelBase extends Model
   {
      protected var server:CaptchaModelServer = new CaptchaModelServer(IModel(this));

      static public var modelId:Long = Long.getLong(490831193,1530810385);

      public function CaptchaModelBase()
      {
         super();
      }

      protected function getInitParam() : CaptchaCC
      {
         return CaptchaCC(initParams[platform.client.fp10.core.model.impl.Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
