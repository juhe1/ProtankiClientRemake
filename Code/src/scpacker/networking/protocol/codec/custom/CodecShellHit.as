package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.ShellState;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.ShellHit;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecShellHit implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = ShellHit;
      
      private var newname_4290__END:ICodec;
      
      private var newname_4291__END:ICodec;
      
      private var newname_4292__END:ICodec;
      
      public function CodecShellHit(param1:ProtocolInitializer)
      {
         super();
         this.newname_4290__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4291__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecShellState");
         this.newname_4292__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecTargetPosition");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:ShellHit = new ShellHit();
         _loc2_.shotId = this.newname_4290__END.decode(param1) as int;
         _loc2_.state = this.newname_4291__END.decode(param1) as Vector.<ShellState>;
         _loc2_.targets = this.newname_4292__END.decode(param1) as Vector.<TargetPosition>;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc4_:int = 0;
         var _loc3_:ShellHit = ShellHit(param2);
         _loc4_ += this.newname_4290__END.encode(param1,_loc3_.shotId);
         _loc4_ = _loc4_ + this.newname_4291__END.encode(param1,_loc3_.state);
         return _loc4_ + this.newname_4292__END.encode(param1,_loc3_.targets);
      }
   }
}

