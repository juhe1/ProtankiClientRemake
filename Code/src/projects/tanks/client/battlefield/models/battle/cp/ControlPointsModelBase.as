package projects.tanks.client.battlefield.models.battle.cp
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ControlPointsModelBase extends Model
   {

      protected var server:ControlPointsModelServer;

      public static const modelId:Long = Long.getLong(375259874,-2064506790);

      public function ControlPointsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ControlPointsModelServer(IModel(this));
      }

      protected function getInitParam() : ControlPointsCC
      {
         return ControlPointsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
