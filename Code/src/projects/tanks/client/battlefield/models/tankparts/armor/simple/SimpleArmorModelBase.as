package projects.tanks.client.battlefield.models.tankparts.armor.simple
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class SimpleArmorModelBase extends Model
   {

      protected var server:SimpleArmorModelServer;

      private static const modelId:Long = Long.getLong(1842275960,1015636683);

      public function SimpleArmorModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new SimpleArmorModelServer(IModel(this));
      }

      protected function getInitParam() : SimpleArmorCC
      {
         return SimpleArmorCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
