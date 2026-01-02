package projects.tanks.client.commons.models.coloring
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.commons.models.coloring.ColoringCC;
   import projects.tanks.client.commons.models.coloring.ColoringModelServer;
   
   public class ColoringModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(947299051,-358915161);
      
      protected var server:ColoringModelServer;
      
      public function ColoringModelBase()
      {
         super();
         this.server = new ColoringModelServer(IModel(this));
      }
      
      protected function getInitParam() : ColoringCC
      {
         return ColoringCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

