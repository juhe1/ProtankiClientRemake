package scpacker.networking.protocol.packets.battleitem
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battleservice.model.types.BattleSuspicionLevel;
   
   public class ItemUpdateBattleSuspicionInPacket extends AbstractPacket
   {
      public static const id:int = -751613832;
      
      public var battleId:String;
      
      public var suspicionLevel:BattleSuspicionLevel;
      
      public function ItemUpdateBattleSuspicionInPacket(param1:String = "", param2:BattleSuspicionLevel = null)
      {
         super();
         this.battleId = param1;
         this.suspicionLevel = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecBattleSuspicionLevel");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.battleId = param1 as String;
               break;
            case 1:
               this.suspicionLevel = param1 as BattleSuspicionLevel;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ItemUpdateBattleSuspicionInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 32;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}
