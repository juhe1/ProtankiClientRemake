
package scpacker.networking.protocol.packets.friends
{
   import projects.tanks.client.users.model.friends.container.UserContainerCC;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadFriendsListInPacket extends AbstractPacket
   {
      public static const id:int = 1422563374;

      public var friendsAcceptedCC:UserContainerCC;
      
      public var friendsAcceptedNotificatorCC:UserContainerCC;
      
      public var friendsIncomingCC:UserContainerCC;
      
      public var friendsIncomingNotificatorCC:UserContainerCC;
      
      public var friendsOutgoingCC:UserContainerCC;
      
      public function LoadFriendsListInPacket(param1:UserContainerCC = null, param2:UserContainerCC = null, param3:UserContainerCC = null, param4:UserContainerCC = null, param5:UserContainerCC = null)
      {
         super();
         this.friendsAcceptedCC = param1;
         this.friendsAcceptedNotificatorCC = param2;
         this.friendsIncomingCC = param3;
         this.friendsIncomingNotificatorCC = param4;
         this.friendsOutgoingCC = param5;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecUserContainerCC");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecUserContainerCC");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecUserContainerCC");
         registerProperty(param4);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecUserContainerCC");
         registerProperty(param5);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecUserContainerCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.friendsAcceptedCC = param1 as UserContainerCC;
               break;
            case 1:
               this.friendsAcceptedNotificatorCC = param1 as UserContainerCC;
               break;
            case 2:
               this.friendsIncomingCC = param1 as UserContainerCC;
               break;
            case 3:
               this.friendsIncomingNotificatorCC = param1 as UserContainerCC;
               break;
            case 4:
               this.friendsOutgoingCC = param1 as UserContainerCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadFriendsListInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 13;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
