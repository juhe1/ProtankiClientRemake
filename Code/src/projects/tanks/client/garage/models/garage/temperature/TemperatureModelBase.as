package projects.tanks.client.garage.models.garage.temperature
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.garage.temperature.TemperatureCC;
   import projects.tanks.client.garage.models.garage.temperature.TemperatureModelServer;
   
   public class TemperatureModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(727121853,-769625095);
      
      protected var server:TemperatureModelServer;
      
      public function TemperatureModelBase()
      {
         super();
         this.server = new TemperatureModelServer(IModel(this));
      }
      
      protected function getInitParam() : TemperatureCC
      {
         return TemperatureCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

