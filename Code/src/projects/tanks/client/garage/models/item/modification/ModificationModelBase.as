package projects.tanks.client.garage.models.item.modification
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.garage.models.item.modification.ModificationCC;

   public class ModificationModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(580825858,-1941731225);

      protected var server:ModificationModelServer;

      public function ModificationModelBase()
      {
         super();
         this.server = new ModificationModelServer(IModel(this));
      }

      protected function getInitParam() : ModificationCC
      {
         return ModificationCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
