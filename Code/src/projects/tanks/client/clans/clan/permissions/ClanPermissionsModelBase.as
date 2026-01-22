package projects.tanks.client.clans.clan.permissions
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ClanPermissionsModelBase extends Model
   {

      protected var server:ClanPermissionsModelServer;

      public static const modelId:Long = Long.getLong(1602467880,168781542);

      public function ClanPermissionsModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ClanPermissionsModelServer(IModel(this));
      }

      protected function getInitParam() : ClanPermissionsCC
      {
         return ClanPermissionsCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
