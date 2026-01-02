package projects.tanks.client.garage.models.item.delaymount
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.delaymount.DelayMountCategoryCC;
   import projects.tanks.client.garage.models.item.delaymount.DelayMountCategoryModelServer;
   
   public class DelayMountCategoryModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1655340370,1523265001);
      
      protected var server:DelayMountCategoryModelServer;
      
      public function DelayMountCategoryModelBase()
      {
         super();
         this.server = new DelayMountCategoryModelServer(IModel(this));
      }
      
      protected function getInitParam() : DelayMountCategoryCC
      {
         return DelayMountCategoryCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

