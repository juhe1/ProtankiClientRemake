package projects.tanks.client.garage.skins
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MountSkinItemModelBase extends Model
   {
      protected var server:MountSkinItemModelServer;

      public static var modelId:Long = Long.getLong(194373973,-369589677);

      public function MountSkinItemModelBase()
      {
         super();
         this.server = new MountSkinItemModelServer(IModel(this));
      }

      protected function getInitParam() : MountedSkinCC
      {
         return MountedSkinCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
