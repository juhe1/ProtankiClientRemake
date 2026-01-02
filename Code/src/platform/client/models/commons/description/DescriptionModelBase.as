package platform.client.models.commons.description
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.models.commons.description.DescriptionModelCC;
   import platform.client.models.commons.description.DescriptionModelServer;
   
   public class DescriptionModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(916213531,-841295065);
      
      protected var server:DescriptionModelServer;
      
      public function DescriptionModelBase()
      {
         super();
         this.server = new DescriptionModelServer(IModel(this));
      }
      
      protected function getInitParam() : DescriptionModelCC
      {
         return DescriptionModelCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

