package projects.tanks.client.panel.model.bonus.showing.image
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class BonusImageShowingModelBase extends Model
   {

      protected var server:BonusImageShowingModelServer;

      public static const modelId:Long = Long.getLong(641472381,-160466740);

      public function BonusImageShowingModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new BonusImageShowingModelServer(IModel(this));
      }

      protected function getInitParam() : BonusImageCC
      {
         return BonusImageCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
