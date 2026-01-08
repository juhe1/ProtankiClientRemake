package projects.tanks.client.battlefield.models.tankparts.weapon.weakening
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class WeaponWeakeningModelBase extends Model
   {

      protected var server:WeaponWeakeningModelServer;

      private static const modelId:Long = Long.getLong(1486543535,-1939817925);

      public function WeaponWeakeningModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new WeaponWeakeningModelServer(IModel(this));
      }

      protected function getInitParam() : WeaponWeakeningCC
      {
         return WeaponWeakeningCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
