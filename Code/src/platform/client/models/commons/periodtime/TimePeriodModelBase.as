package platform.client.models.commons.periodtime
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.models.commons.periodtime.TimePeriodModelCC;
   import platform.client.models.commons.periodtime.TimePeriodModelServer;
   
   public class TimePeriodModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1870140649,1080360405);
      
      protected var server:TimePeriodModelServer;
      
      public function TimePeriodModelBase()
      {
         super();
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

