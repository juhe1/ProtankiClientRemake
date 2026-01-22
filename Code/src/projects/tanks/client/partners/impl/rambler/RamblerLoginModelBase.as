package projects.tanks.client.partners.impl.rambler
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RamblerLoginModelBase extends Model
   {

      protected var server:RamblerLoginModelServer;

      public static const modelId:Long = Long.getLong(644147707,1740542175);

      public function RamblerLoginModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RamblerLoginModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
