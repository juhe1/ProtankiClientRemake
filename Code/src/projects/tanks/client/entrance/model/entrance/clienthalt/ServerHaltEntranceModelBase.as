package projects.tanks.client.entrance.model.entrance.clienthalt
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class ServerHaltEntranceModelBase extends Model
   {

      protected var server:ServerHaltEntranceModelServer;

      public static const modelId:Long = Long.getLong(946668342,813083086);

      public function ServerHaltEntranceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new ServerHaltEntranceModelServer(IModel(this));
      }

      protected function getInitParam() : ServerHaltEntranceCC
      {
         return ServerHaltEntranceCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
