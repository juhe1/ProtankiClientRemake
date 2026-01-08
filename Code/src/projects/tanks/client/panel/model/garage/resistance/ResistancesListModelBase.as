package projects.tanks.client.panel.model.garage.resistance
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.panel.model.garage.resistance.ResistancesCC;

   public class ResistancesListModelBase extends Model
   {
      public static const modelId:Long = Long.getLong(1350664067,-353806112);

      protected var server:ResistancesListModelServer;

      public function ResistancesListModelBase()
      {
         super();
         this.server = new ResistancesListModelServer(IModel(this));
      }

      protected function getInitParam() : ResistancesCC
      {
         return ResistancesCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
