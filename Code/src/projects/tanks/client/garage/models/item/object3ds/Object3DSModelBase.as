package projects.tanks.client.garage.models.item.object3ds
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.object3ds.Object3DSCC;
   import projects.tanks.client.garage.models.item.object3ds.Object3DSModelServer;
   
   public class Object3DSModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1497301838,-1092921347);
      
      protected var server:Object3DSModelServer;
      
      public function Object3DSModelBase()
      {
         super();
         this.server = new Object3DSModelServer(IModel(this));
      }
      
      protected function getInitParam() : Object3DSCC
      {
         return Object3DSCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

