package projects.tanks.client.clans.space.createclan
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class ClanCreateModelServer
   {

      private var model:IModel;

      public function ClanCreateModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function createClan(param1:String, param2:String, param3:Long) : void
      {
      }

      public function validateName(param1:String) : void
      {
      }

      public function validateTag(param1:String) : void
      {
      }
   }
}
