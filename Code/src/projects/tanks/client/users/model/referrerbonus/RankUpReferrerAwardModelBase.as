package projects.tanks.client.users.model.referrerbonus
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RankUpReferrerAwardModelBase extends Model
   {

      protected var server:RankUpReferrerAwardModelServer;

      public static const modelId:Long = Long.getLong(2055575281,-1485567427);

      public function RankUpReferrerAwardModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RankUpReferrerAwardModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
