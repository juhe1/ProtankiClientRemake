package projects.tanks.client.battlefield.models.tankparts.weapon.streamweapon
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class StreamWeaponModelBase extends Model
   {

      protected var server:StreamWeaponModelServer;

      private static const modelId:Long = Long.getLong(479046028,-1680303089);

      public function StreamWeaponModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new StreamWeaponModelServer(IModel(this));
      }

      protected function getInitParam() : StreamWeaponCC
      {
         return StreamWeaponCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
