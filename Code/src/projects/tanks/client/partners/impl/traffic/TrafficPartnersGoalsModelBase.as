package projects.tanks.client.partners.impl.traffic
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TrafficPartnersGoalsModelBase extends Model
   {

      protected var server:TrafficPartnersGoalsModelServer;

      public static const modelId:Long = Long.getLong(1751879442,-1910987837);

      public function TrafficPartnersGoalsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TrafficPartnersGoalsModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
