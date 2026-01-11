package projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.autoaiming
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   import projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.VerticalAnglesCC;

   public class WeaponVerticalAnglesModelBase extends Model
   {

      protected var server:WeaponVerticalAnglesModelServer;

      public static const modelId:Long = Long.getLong(1835454872,-194543840);

      public function WeaponVerticalAnglesModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new WeaponVerticalAnglesModelServer(IModel(this));
      }

      protected function getInitParam() : VerticalAnglesCC
      {
         return VerticalAnglesCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
