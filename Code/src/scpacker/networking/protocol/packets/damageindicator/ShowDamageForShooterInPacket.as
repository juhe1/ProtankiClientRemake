package scpacker.networking.protocol.packets.damageindicator
{
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.client.battlefield.models.user.damageindicator.TargetTankDamage;
   
   public class ShowDamageForShooterInPacket extends AbstractPacket
   {
      public static const id:int = -1165230470;
      
      public var damages:Vector.<TargetTankDamage>;
      
      public function ShowDamageForShooterInPacket(param1:Vector.<TargetTankDamage> = null)
      {
         super();
         this.damages = param1;
         registerProperty(param1);
         registerPropertyCodec("scpacker.networking.protocol.codec.custom.VectorCodecTargetTankDamage");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.damages = param1 as Vector.<TargetTankDamage>;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new ShowDamageForShooterInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 47;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}

