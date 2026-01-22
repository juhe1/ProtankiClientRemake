package projects.tanks.client.commons.models.challenge.time
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ChallengesTimeModelBase extends Model
   {

      protected var server:ChallengesTimeModelServer;

      public static const modelId:Long = Long.getLong(1891796571,199395138);

      public function ChallengesTimeModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ChallengesTimeModelServer(IModel(this));
      }

      protected function getInitParam() : ChallengesTimeCC
      {
         return ChallengesTimeCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
