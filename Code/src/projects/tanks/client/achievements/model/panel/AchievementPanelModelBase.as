package projects.tanks.client.achievements.model.panel
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AchievementPanelModelBase extends Model
   {

      protected var server:AchievementPanelModelServer;

      public static const modelId:Long = Long.getLong(1524513374,287342893);

      public function AchievementPanelModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AchievementPanelModelServer(IModel(this));
      }

      protected function getInitParam() : AchievementCC
      {
         return AchievementCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
