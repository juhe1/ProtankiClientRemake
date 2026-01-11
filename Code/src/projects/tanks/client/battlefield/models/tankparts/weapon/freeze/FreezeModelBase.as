package projects.tanks.client.battlefield.models.tankparts.weapon.freeze
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class FreezeModelBase extends Model
   {

      protected var server:FreezeModelServer;

      public static const modelId:Long = Long.getLong(2120141642,699496177);

      public function FreezeModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new FreezeModelServer(IModel(this));
      }

      protected function getInitParam() : FreezeCC
      {
         return FreezeCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
