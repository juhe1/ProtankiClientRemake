package projects.tanks.client.garage.models.user.present
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.user.present.PresentProfileModelServer;
   import projects.tanks.client.garage.models.user.present.PresentsCC;
   
   public class PresentProfileModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(566505089,2827348);
      
      protected var server:PresentProfileModelServer;
      
      public function PresentProfileModelBase()
      {
         super();
         this.server = new PresentProfileModelServer(IModel(this));
      }
      
      protected function getInitParam() : PresentsCC
      {
         return PresentsCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

