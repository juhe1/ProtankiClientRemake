package scpacker.networking.protocol.packets.usercountry
{
   import projects.tanks.client.panel.model.usercountry.UserCountryCC;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class LoadUserCountryModelInPacket extends AbstractPacket
   {
      public static const id:int = -1232334539;
      
      public var cc:UserCountryCC;
      
      public function LoadUserCountryModelInPacket(param1:UserCountryCC = null)
      {
         super();
         this.cc = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecUserCountryCC");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.cc = param1 as UserCountryCC;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new LoadUserCountryModelInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 75;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

