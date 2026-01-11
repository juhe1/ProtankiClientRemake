package projects.tanks.client.battlefield.models.user.turnover
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class TankTurnOverModelBase extends Model
   {

      protected var server:TankTurnOverModelServer;

      public static const modelId:Long = Long.getLong(979293197,-632476978);

      public function TankTurnOverModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new TankTurnOverModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
