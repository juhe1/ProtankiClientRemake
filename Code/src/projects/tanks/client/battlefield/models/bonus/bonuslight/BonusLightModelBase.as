package projects.tanks.client.battlefield.models.bonus.bonuslight
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BonusLightModelBase extends Model
   {

      protected var server:BonusLightModelServer;

      private static const modelId:Long = Long.getLong(1742678945,1383804656);

      public function BonusLightModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BonusLightModelServer(IModel(this));
      }

      protected function getInitParam() : BonusLightCC
      {
         return BonusLightCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
