package alternativa.tanks.service.clan
{
   import flash.events.Event;
   
   public class ClanMembersListEvent extends Event
   {
      
      public static const REMOVE_USER:String = "ClanMembersListEvent.REMOVE_USER";
      
      public static const ACCEPTED_USER:String = "ClanMembersListEvent.ACCEPTED_USER";
      
      public static const REJECT_USER:String = "ClanMembersListEvent.REJECT_USER";
      
      public static const REVOKE_USER:String = "ClanMembersListEvent.REVOKE_USER";
      
      public var userId:String;
      
      public var userUid:String;
      
      public function ClanMembersListEvent(param1:String, param2:String, param3:String = "", param4:Boolean = false, param5:Boolean = false)

      {
         super(param1,param4,param5);
         this.userId = param2;
         this.userUid = param3;
      }
   }
}

