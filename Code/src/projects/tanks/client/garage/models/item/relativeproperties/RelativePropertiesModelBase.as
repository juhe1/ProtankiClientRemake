package projects.tanks.client.garage.models.item.relativeproperties
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.relativeproperties.RelativePropertiesCC;
   import projects.tanks.client.garage.models.item.relativeproperties.RelativePropertiesModelServer;
   
   public class RelativePropertiesModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1898420153,238332071);
      
      protected var server:RelativePropertiesModelServer;
      
      public function RelativePropertiesModelBase()
      {
         super();
         this.server = new RelativePropertiesModelServer(IModel(this));
      }
      
      protected function getInitParam() : RelativePropertiesCC
      {
         return RelativePropertiesCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

