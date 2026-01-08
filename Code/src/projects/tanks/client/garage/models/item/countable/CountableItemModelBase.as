package projects.tanks.client.garage.models.item.countable
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class CountableItemModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(28163628,1959753058);

      protected var server:CountableItemModelServer;

      public function CountableItemModelBase()
      {
         super();
         this.server = new CountableItemModelServer(IModel(this));
      }

      protected function getInitParam() : CountableItemCC
      {
         return CountableItemCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
