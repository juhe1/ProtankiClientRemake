package projects.tanks.clients.fp10.libraries.tanksservices.service.group
{
   import alternativa.types.Long;
   import flash.events.EventDispatcher;
   
   public class GroupInfoService extends EventDispatcher implements IGroupInfoService
   {
      
      private var group:Vector.<String> = new Vector.<String>();
      
      private var _hasGroups:Boolean = false;
      
      public function GroupInfoService()
      {
         super();
      }
      
      public function addGroupUser(param1:String) : *
      {
         this._hasGroups = true;
         this.group.push(param1);
      }
      
      public function isInSameGroup(param1:String) : Boolean
      {
         return this.group.indexOf(param1) != -1;
      }
      
      public function hasGroups() : Boolean
      {
         return this._hasGroups;
      }
      
      public function setHasGroups(param1:Boolean) : *
      {
         this._hasGroups = param1;
      }
   }
}

