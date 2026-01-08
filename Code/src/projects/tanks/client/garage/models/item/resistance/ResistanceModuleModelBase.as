package projects.tanks.client.garage.models.item.resistance
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ResistanceModuleModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(422480254,471726203);

      protected var server:ResistanceModuleModelServer;

      public function ResistanceModuleModelBase()
      {
         super();
         this.server = new ResistanceModuleModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
