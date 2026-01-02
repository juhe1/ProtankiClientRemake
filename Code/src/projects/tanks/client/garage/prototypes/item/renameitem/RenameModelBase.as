package projects.tanks.client.garage.prototypes.item.renameitem
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class RenameModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(841189855,-1268110049);
      
      protected var server:RenameModelServer;
      
      public function RenameModelBase()
      {
         super();
         this.server = new RenameModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

