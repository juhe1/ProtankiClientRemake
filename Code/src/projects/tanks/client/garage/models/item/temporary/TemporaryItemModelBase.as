package projects.tanks.client.garage.models.item.temporary
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.temporary.TemporaryItemCC;
   import projects.tanks.client.garage.models.item.temporary.TemporaryItemModelServer;
   
   public class TemporaryItemModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(906608998,-1418680370);
      
      protected var server:TemporaryItemModelServer;
      
      public function TemporaryItemModelBase()
      {
         super();
         this.server = new TemporaryItemModelServer(IModel(this));
      }
      
      protected function getInitParam() : TemporaryItemCC
      {
         return TemporaryItemCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

