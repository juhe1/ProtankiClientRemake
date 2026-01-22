package projects.tanks.client.panel.model.bonus.showing.items
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BonusItemModelBase extends Model
   {

      protected var server:BonusItemModelServer;

      public static const modelId:Long = Long.getLong(202988853,-1669191998);

      public function BonusItemModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BonusItemModelServer(IModel(this));
      }

      protected function getInitParam() : BonusItemCC
      {
         return BonusItemCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
