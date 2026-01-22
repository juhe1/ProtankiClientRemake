package projects.tanks.client.panel.model.bonus.showing.info
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BonusInfoModelBase extends Model
   {

      protected var server:BonusInfoModelServer;

      public static const modelId:Long = Long.getLong(833813262,1737001283);

      public function BonusInfoModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BonusInfoModelServer(IModel(this));
      }

      protected function getInitParam() : BonusInfoCC
      {
         return BonusInfoCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
