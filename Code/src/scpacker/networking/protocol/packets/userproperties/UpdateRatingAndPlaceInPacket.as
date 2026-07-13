package scpacker.networking.protocol.packets.userproperties
{
   import projects.tanks.client.tanksservices.model.notifier.battle.BattleNotifierData;
   import scpacker.networking.protocol.AbstractPacket;
   
   public class UpdateRatingAndPlaceInPacket extends AbstractPacket
   {
      public static const id:int = -1128606444;
      
      public var rating:Number;

      public var place:int;
      
      public function UpdateRatingAndPlaceInPacket(_rating:Number = 0, _place:int = 0)
      {
         super();
         this.rating = _rating;
         this.place = _place;
         registerProperty(_rating);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         registerProperty(_place);
         registerPropertyCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
      }
      
      override public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this.rating = param1 as Number;
               break;
            case 1:
               this.place = param1 as int;
         }
      }
      
      override public function initializeSelf() : AbstractPacket
      {
         return new UpdateRatingAndPlaceInPacket();
      }
      
      override public function getPacketHandlerId() : int
      {
         return 29;
      }
      
      override public function getId() : int
      {
         return id;
      }
   }
}