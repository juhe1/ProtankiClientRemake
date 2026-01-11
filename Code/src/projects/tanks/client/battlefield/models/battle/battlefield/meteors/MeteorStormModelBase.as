package projects.tanks.client.battlefield.models.battle.battlefield.meteors
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MeteorStormModelBase extends Model
   {

      protected var server:MeteorStormModelServer;

      public static const modelId:Long = Long.getLong(2135606158,-499224081);

      public function MeteorStormModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MeteorStormModelServer(IModel(this));
      }

      protected function getInitParam() : MeteorStormCC
      {
         return MeteorStormCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
