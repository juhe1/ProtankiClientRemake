package projects.tanks.client.entrance.model.entrance.invite
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class InviteEntranceModelBase extends Model
   {

      protected var server:InviteEntranceModelServer;

      public static const modelId:Long = Long.getLong(2122883443,1406559758);

      public function InviteEntranceModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new InviteEntranceModelServer(IModel(this));
      }

      protected function getInitParam() : InviteEntranceCC
      {
         return InviteEntranceCC(initParams[Model.object]);
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
