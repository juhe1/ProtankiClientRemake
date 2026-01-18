package scpacker.networking.protocol.packets.isida
{
   import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
   import scpacker.networking.protocol.AbstractPacket;

   public class SetIsidaTargetInPacket extends AbstractPacket
   {
      public static const id:int = 2001632000;

      public var shooter:String;

      public var currentState:IsisState;

      public var target:TargetHit;

      public function SetIsidaTargetInPacket(param1:String = "", param2:IsisState = null, param3:TargetHit = null)
      {
         super();
         this.shooter = param1;
         this.currentState = param2;
         this.target = param3;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         registerProperty(param2);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecIsisState");
         registerProperty(param3);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.CodecTargetHit");
      }

      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.shooter = param1 as String;
               break;
            case 1:
               this.currentState = param1 as IsisState;
               break;
            case 2:
               this.target = param1 as TargetHit;
         }
      }

      override public function initializeSelf() : AbstractPacket
      {
         return new SetIsidaTargetInPacket();
      }

      override public function getPacketHandlerId() : int
      {
         return 55;
      }

      override public function getId() : int
      {
         return id;
      }
   }
}
