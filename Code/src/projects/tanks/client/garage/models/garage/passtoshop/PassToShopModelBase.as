package projects.tanks.client.garage.models.garage.passtoshop
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.garage.passtoshop.PassToShopCC;
   import projects.tanks.client.garage.models.garage.passtoshop.PassToShopModelServer;
   
   public class PassToShopModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(2134722200,-2075306131);
      
      protected var server:PassToShopModelServer;
      
      public function PassToShopModelBase()
      {
         super();
         this.server = new PassToShopModelServer(IModel(this));
      }
      
      protected function getInitParam() : PassToShopCC
      {
         return PassToShopCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

