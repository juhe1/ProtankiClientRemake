package projects.tanks.client.panel.model.bonus.showing.items
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BonusItemsShowingModelBase extends Model
   {

      protected var server:BonusItemsShowingModelServer;

      public static const modelId:Long = Long.getLong(1129865011,-1493936044);

      public function BonusItemsShowingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BonusItemsShowingModelServer(IModel(this));
      }

      protected function getInitParam() : BonusItemsShowingCC
      {
         return BonusItemsShowingCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
