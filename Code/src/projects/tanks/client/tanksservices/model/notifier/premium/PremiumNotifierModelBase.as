package projects.tanks.client.tanksservices.model.notifier.premium
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.registry.ModelRegistry;
   import alternativa.types.Long;
   
   public class PremiumNotifierModelBase extends Model
   {
      public static var modelId:Long = Long.getLong(302389563,-1379937773);
      
      public function PremiumNotifierModelBase()
      {
         super();
      }

      protected function getInitParam() : PremiumNotifierCC
      {
         return PremiumNotifierCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return modelId;
      }
   }
}

