package projects.tanks.client.commons.models.moveusertoclient
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class MoveUserToServerModelBase extends Model
   {

      protected var server:MoveUserToServerModelServer;

      public static const modelId:Long = Long.getLong(1594319086,-307533593);

      public function MoveUserToServerModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new MoveUserToServerModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
