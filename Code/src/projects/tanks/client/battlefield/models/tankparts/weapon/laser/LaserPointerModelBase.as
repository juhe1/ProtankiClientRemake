package projects.tanks.client.battlefield.models.tankparts.weapon.laser
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class LaserPointerModelBase extends Model
   {

      protected var server:LaserPointerModelServer;

      public static const modelId:Long = Long.getLong(1691794381,-1794202080);

      public function LaserPointerModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new LaserPointerModelServer(IModel(this));
      }

      protected function getInitParam() : LaserPointerCC
      {
         return LaserPointerCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
