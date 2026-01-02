package projects.tanks.client.garage.models.item.present
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.present.PresentItemCC;
   import projects.tanks.client.garage.models.item.present.PresentItemModelServer;
   
   public class PresentItemModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(253893103,1551357114);
      
      protected var server:PresentItemModelServer;
      
      public function PresentItemModelBase()
      {
         super();
         this.server = new PresentItemModelServer(IModel(this));
      }
      
      protected function getInitParam() : PresentItemCC
      {
         return PresentItemCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

