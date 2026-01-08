package projects.tanks.client.garage.skins.shot
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AvailableShotSkinsModelBase extends Model
   {
      protected var server:AvailableShotSkinsModelServer;

      public static var modelId:Long = Long.getLong(271121565,-563433199);

      public function AvailableShotSkinsModelBase()
      {
         super();
         this.server = new AvailableShotSkinsModelServer(IModel(this));
      }

      protected function getInitParam() : AvailableShotSkinsCC
      {
         return AvailableShotSkinsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
