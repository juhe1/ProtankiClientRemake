package projects.tanks.client.battlefield.models.continuebattle
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ContinueBattleModelBase extends Model
   {

      protected var server:ContinueBattleModelServer;

      public static const modelId:Long = Long.getLong(1750173911,1168019295);

      public function ContinueBattleModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ContinueBattleModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
