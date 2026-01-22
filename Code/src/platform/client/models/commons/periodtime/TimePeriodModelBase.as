package platform.client.models.commons.periodtime
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TimePeriodModelBase extends Model
   {

      protected var server:TimePeriodModelServer;

      public static const modelId:Long = Long.getLong(1870140649,1080360405);

      public function TimePeriodModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TimePeriodModelServer(IModel(this));
      }

      protected function getInitParam() : TimePeriodModelCC
      {
         return TimePeriodModelCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
