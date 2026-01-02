package projects.tanks.client.garage.models.item.resistance
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.resistance.MountedResistancesCC;
   import projects.tanks.client.garage.models.item.resistance.MountedResistancesModelServer;
   
   public class MountedResistancesModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1332792132,1488384798);
      
      protected var server:MountedResistancesModelServer;
      
      public function MountedResistancesModelBase()
      {
         super();
         this.server = new MountedResistancesModelServer(IModel(this));
      }
      
      protected function getInitParam() : MountedResistancesCC
      {
         return MountedResistancesCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

