package projects.tanks.client.garage.models.garage.present
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.garage.present.PresentGivenModelServer;
   
   public class PresentGivenModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1891481944,-1293130596);
      
      protected var server:PresentGivenModelServer;
      
      public function PresentGivenModelBase()
      {
         super();
         this.server = new PresentGivenModelServer(IModel(this));
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

