package projects.tanks.client.battlefield.models.teamlight
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TeamLightModelBase extends Model
   {

      protected var server:TeamLightModelServer;

      private static const modelId:Long = Long.getLong(40022888,448727509);

      public function TeamLightModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TeamLightModelServer(IModel(this));
      }

      protected function getInitParam() : TeamLightCC
      {
         return TeamLightCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
