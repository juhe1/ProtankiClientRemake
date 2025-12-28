package alternativa.tanks.services.tankregistry
{
   import flash.utils.Dictionary;
   import alternativa.object.ClientObject;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
   
   public class TankUsersRegistryServiceImpl implements TankUsersRegistry
   {
      public static var userPropertiesService:IUserPropertiesService;

      private const users:Dictionary = new Dictionary();
      
      private var userList:Vector.<ClientObject>;
      
      private var userCount:int;
      
      private var localUser:ClientObject;
      
      public function TankUsersRegistryServiceImpl()
      {
         super();
      }
      
      public function addUser(param1:ClientObject) : void
      {
         this.userList = null;
         if(!this.users[param1.id])
         {
            this.users[param1.id] = param1;
            ++this.userCount;
         }
         if(userPropertiesService.userName == param1.id)
         {
            this.localUser = param1;
         }
      }
      
      public function removeUser(param1:ClientObject) : void
      {
         this.userList = null;
         if(Boolean(this.users[param1.id]))
         {
            delete this.users[param1.id];
            --this.userCount;
         }
         if(userPropertiesService.userName == param1.id)
         {
            this.localUser = null;
         }
      }
      
      public function getUserCount() : int
      {
         return this.userCount;
      }
      
      public function getUsers() : Vector.<ClientObject>
      {
         var _loc1_:ClientObject = null;
         if(this.userList == null)
         {
            this.userList = new Vector.<ClientObject>();
            for each(_loc1_ in this.users)
            {
               this.userList.push(_loc1_);
            }
         }
         return this.userList;
      }
      
      public function getUser(param1:String) : ClientObject
      {
         return this.users[param1];
      }
      
      public function getLocalUser() : ClientObject
      {
         return this.localUser;
      }
      
      public function existLocalUser() : Boolean
      {
         return this.localUser != null;
      }
   }
}

