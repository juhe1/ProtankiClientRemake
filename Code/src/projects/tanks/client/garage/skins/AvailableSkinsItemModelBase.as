package projects.tanks.client.garage.skins
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class AvailableSkinsItemModelBase extends Model
   {
      protected var server:AvailableSkinsItemModelServer;

      public static var modelId:Long = Long.getLong(1212548768,-1645485380);

      public function AvailableSkinsItemModelBase()
      {
         super();
         this.server = new AvailableSkinsItemModelServer(IModel(this));
      }

      protected function getInitParam() : AvailableSkinsCC
      {
         return AvailableSkinsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
