package projects.tanks.client.garage.skins
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class MountShotSkinModelBase extends Model
   {
      protected var server:MountShotSkinModelServer;
      
      public static var modelId:Long = Long.getLong(210937717,-790031526);
      
      public function MountShotSkinModelBase()
      {
         super();
         this.server = new MountShotSkinModelServer(IModel(this));
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

