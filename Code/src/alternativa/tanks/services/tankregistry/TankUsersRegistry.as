package alternativa.tanks.services.tankregistry
{
   import alternativa.object.ClientObject;
   
   public interface TankUsersRegistry
   {
      
      function addUser(param1:ClientObject) : void;
      
      function removeUser(param1:ClientObject) : void;
      
      function getUserCount() : int;
      
      function getUsers() : Vector.<ClientObject>;
      
      function getUser(param1:String) : ClientObject;
      
      function getLocalUser() : ClientObject;
      
      function existLocalUser() : Boolean;
   }
}

