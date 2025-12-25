package projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties
{
   import flash.events.Event;
   
   public class UserPropertiesServiceEvent extends Event
   {
      public static const UPDATE_RANK:String = "UserPropertiesServiceEvent.UPDATE_RANK";
      
      public static const UPDATE_SCORE:String = "UserPropertiesServiceEvent.UPDATE_SCORE";
      
      public var userProperties:UserProperties;
      
      public function UserPropertiesServiceEvent(param1:String, param2:UserProperties, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.userProperties = param2;
      }
   }
}

