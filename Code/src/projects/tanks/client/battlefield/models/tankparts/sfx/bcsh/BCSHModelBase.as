package projects.tanks.client.battlefield.models.tankparts.sfx.bcsh
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class BCSHModelBase extends Model
   {
      
      public static var modelId:Long = Long.getLong(1099120188,-904226430);
      
      protected var server:BCSHModelServer;
      
      public function BCSHModelBase()
      {
         super();
         this.server = new BCSHModelServer(IModel(this));
      }
      
      protected function getInitParam() : BCSHModelCC
      {
         return BCSHModelCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

