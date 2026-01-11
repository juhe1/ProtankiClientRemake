package projects.tanks.client.battlefield.models.tankparts.weapon.common
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class WeaponCommonModelBase extends Model
   {

      protected var server:WeaponCommonModelServer;

      public static const modelId:Long = Long.getLong(288238981,44520685);

      public function WeaponCommonModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new WeaponCommonModelServer(IModel(this));
      }

      protected function getInitParam() : WeaponCommonCC
      {
         return WeaponCommonCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
