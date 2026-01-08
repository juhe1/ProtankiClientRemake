package projects.tanks.client.battlefield.models.tankparts.weapon.turret
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class RotatingTurretModelBase extends Model
   {

      protected var server:RotatingTurretModelServer;

      private static const modelId:Long = Long.getLong(652662967,-1245415753);

      public function RotatingTurretModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new RotatingTurretModelServer(IModel(this));
      }

      protected function getInitParam() : RotatingTurretCC
      {
         return RotatingTurretCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
