package projects.tanks.client.tanksservices.model.formatbattle
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class EquipmentConstraintsNamingModelBase extends Model
   {
      protected var server:EquipmentConstraintsNamingModelServer;
      
      public static var modelId:Long = Long.getLong(1124951823,1347902856);
      
      public function EquipmentConstraintsNamingModelBase()
      {
         super();
         this.server = new EquipmentConstraintsNamingModelServer(IModel(this));
      }
      
      protected function getInitParam() : EquipmentConstraintsCC
      {
         return EquipmentConstraintsCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return EquipmentConstraintsNamingModelBase.modelId;
      }
   }
}

