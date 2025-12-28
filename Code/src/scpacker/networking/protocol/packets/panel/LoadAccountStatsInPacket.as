package scpacker.networking.protocol.packets.panel
{
   import projects.tanks.client.panel.model.profile.userproperties.UserPropertiesCC;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadAccountStatsInPacket extends AbstractPacket
   {
      public static const id:int = 907073245;
      
      public var userPropertyCC:UserPropertiesCC;
      
      public function LoadAccountStatsInPacket(param1:UserPropertiesCC = null)
      {
         super();
         this.userPropertyCC = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecUserPropertiesCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.userPropertyCC = param1 as UserPropertiesCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadAccountStatsInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 10;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
