package projects.tanks.client.battlefield.models.user.damageindicator
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class DamageIndicatorModelBase extends Model
   {

      protected var server:DamageIndicatorModelServer;

      private static const modelId:Long = Long.getLong(756280393,-1366394900);

      public function DamageIndicatorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new DamageIndicatorModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
