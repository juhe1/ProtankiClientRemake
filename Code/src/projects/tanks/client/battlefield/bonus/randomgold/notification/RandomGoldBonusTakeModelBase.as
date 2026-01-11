package projects.tanks.client.battlefield.bonus.randomgold.notification
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RandomGoldBonusTakeModelBase extends Model
   {

      protected var server:RandomGoldBonusTakeModelServer;

      public static const modelId:Long = Long.getLong(659324709,-1637199403);

      public function RandomGoldBonusTakeModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RandomGoldBonusTakeModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
