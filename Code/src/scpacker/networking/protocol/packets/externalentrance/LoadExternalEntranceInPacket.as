package scpacker.networking.protocol.packets.externalentrance
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.entrance.model.entrance.externalentrance.SocialNetworkEntranceParams;
   
   public class LoadExternalEntranceInPacket extends AbstractPacket
   {
      public static const id:int = -1715719586;
      
      public var socialNetworkEntranceParams:Vector.<SocialNetworkEntranceParams>;
      
      public function LoadExternalEntranceInPacket(param1:Vector.<SocialNetworkEntranceParams> = null)
      {
         super();
         this.socialNetworkEntranceParams = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecSocialNetworkEntranceParams");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.socialNetworkEntranceParams = param1 as Vector.<SocialNetworkEntranceParams>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadExternalEntranceInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 3;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

