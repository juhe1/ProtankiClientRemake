package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battlefield.models.battle.assault.AssaultBase;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecAssaultBase implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = AssaultBase;
      
      private var newname_4240__END:ICodec;
      
      private var newname_4241__END:ICodec;
      
      public function CodecAssaultBase(param1:ProtocolInitializer)
      {
         super();
         this.newname_4240__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4241__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:AssaultBase = new AssaultBase();
         _loc2_.id = this.newname_4240__END.decode(param1) as int;
         _loc2_.position = this.newname_4241__END.decode(param1) as Vector3d;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:AssaultBase = AssaultBase(param2);
         this.newname_4240__END.encode(param1,_loc3_.id);
         this.newname_4241__END.encode(param1,_loc3_.position);
         return 4;
      }
   }
}

