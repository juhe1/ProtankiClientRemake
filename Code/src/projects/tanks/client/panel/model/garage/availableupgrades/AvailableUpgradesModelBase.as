package projects.tanks.client.panel.model.garage.availableupgrades
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AvailableUpgradesModelBase extends Model
   {

      protected var server:AvailableUpgradesModelServer;

      public static const modelId:Long = Long.getLong(1703176691,-2087679293);

      public function AvailableUpgradesModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new AvailableUpgradesModelServer(IModel(this));
      }

      protected function getInitParam() : AvailableUpgradesCC
      {
         return AvailableUpgradesCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
