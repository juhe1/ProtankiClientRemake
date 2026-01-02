package projects.tanks.client.garage.models.garage.upgrade
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.garage.upgrade.UpgradeGarageItemModelServer;
   
   public class UpgradeGarageItemModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(293210276,-627719811);
      
      protected var server:UpgradeGarageItemModelServer;
      
      public function UpgradeGarageItemModelBase()
      {
         super();
         this.server = new UpgradeGarageItemModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

