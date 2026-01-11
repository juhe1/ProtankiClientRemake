package projects.tanks.client.battlefield.models.bonus.bonus.common
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BonusCommonModelBase extends Model
   {

      protected var server:BonusCommonModelServer;

      public static const modelId:Long = Long.getLong(2087671478,1672369054);

      public function BonusCommonModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BonusCommonModelServer(IModel(this));
      }

      protected function getInitParam() : BonusCommonCC
      {
         return BonusCommonCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
