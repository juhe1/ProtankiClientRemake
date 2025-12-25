package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.battleinvite.BattleInviteCC;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.SoundResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBattleInviteCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BattleInviteCC;
      
      private var newname_4310__END:ICodec;
      
      public function CodecBattleInviteCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4310__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BattleInviteCC = new BattleInviteCC();
         _loc2_.soundNotification = this.newname_4310__END.decode(param1) as SoundResource;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BattleInviteCC = BattleInviteCC(param2);
         this.newname_4310__END.encode(param1,_loc3_.soundNotification);
         return 4;
      }
   }
}

