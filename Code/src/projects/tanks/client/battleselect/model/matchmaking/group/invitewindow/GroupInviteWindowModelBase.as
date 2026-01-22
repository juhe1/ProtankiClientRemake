package projects.tanks.client.battleselect.model.matchmaking.group.invitewindow
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;

   public class GroupInviteWindowModelBase extends Model
   {

      protected var server:GroupInviteWindowModelServer;

      public static const modelId:Long = Long.getLong(443203981,347316300);

      public function GroupInviteWindowModelBase()
      {
         super();
         this.initCodecs();
      }

      protected function initCodecs() : void
      {
         this.server = new GroupInviteWindowModelServer(IModel(this));
      }

      override public function get id() : Long
      {
         return modelId;
      }
   }
}
