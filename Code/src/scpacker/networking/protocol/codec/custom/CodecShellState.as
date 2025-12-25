package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.ShellState;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecShellState implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = ShellState;
      
      private var newname_4270__END:ICodec;
      
      private var newname_4271__END:ICodec;
      
      private var newname_4272__END:ICodec;
      
      public function CodecShellState(param1:ProtocolInitializer)
      {
         super();
         this.newname_4270__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4271__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4272__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:ShellState = new ShellState();
         _loc2_.clientTime = this.newname_4270__END.decode(param1) as int;
         _loc2_.direction = this.newname_4271__END.decode(param1) as Vector3d;
         _loc2_.position = this.newname_4272__END.decode(param1) as Vector3d;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ShellState = ShellState(param2);
         var _loc4_:int = 0;
         _loc4_ = _loc4_ + this.newname_4270__END.encode(param1,_loc3_.clientTime);
         _loc4_ = _loc4_ + this.newname_4271__END.encode(param1,_loc3_.direction);
         return _loc4_ + this.newname_4272__END.encode(param1,_loc3_.position);
      }
   }
}

