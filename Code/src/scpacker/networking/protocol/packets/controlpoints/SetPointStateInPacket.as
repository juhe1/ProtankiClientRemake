package scpacker.networking.protocol.packets.controlpoints
{
   import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class SetPointStateInPacket extends AbstractPacket
   {
      public static const id:int = -1073178885;
      
      public var pointId:int;
      
      public var currentState:ControlPointState;
      
      public function SetPointStateInPacket(param1:int = 0, param2:ControlPointState = null)
      {
         super();
         this.pointId = param1;
         this.currentState = param2;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecControlPointState");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.pointId = param1 as int;
               break;
            case 1:
               this.currentState = param1 as ControlPointState;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new SetPointStateInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 60;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

