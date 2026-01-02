package projects.tanks.clients.fp10.libraries.tanksservices.service.group
{
   public interface IGroupInfoService
   {
      
      function addGroupUser(param1:String) : *;
      
      function isInSameGroup(param1:String) : Boolean;
      
      function hasGroups() : Boolean;
      
      function setHasGroups(param1:Boolean) : *;
   }
}

