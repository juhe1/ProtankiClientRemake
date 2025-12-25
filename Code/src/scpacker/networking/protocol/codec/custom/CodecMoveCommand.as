package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecMoveCommand implements ICodec
   {
      private var newname_4344__END:ICodec;
      
      private var newname_4160__END:ICodec;
      
      private var newname_4345__END:ICodec;
      
      private var newname_4297__END:ICodec;
      
      private var newname_4241__END:ICodec;
      
      public function CodecMoveCommand(param1:ProtocolInitializer)
      {
         super();
         this.newname_4344__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4160__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
         this.newname_4345__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4297__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4241__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:MoveCommand = new MoveCommand();
         _loc2_.angularVelocity = this.newname_4344__END.decode(param1) as Vector3d;
         _loc2_.control = this.newname_4160__END.decode(param1) as int;
         _loc2_.linearVelocity = this.newname_4345__END.decode(param1) as Vector3d;
         _loc2_.orientation = this.newname_4297__END.decode(param1) as Vector3d;
         _loc2_.position = this.newname_4241__END.decode(param1) as Vector3d;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc4_:int = 0;
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:MoveCommand = MoveCommand(param2);
         _loc4_ += this.newname_4344__END.encode(param1,_loc3_.angularVelocity);
         _loc4_ = _loc4_ + this.newname_4160__END.encode(param1,_loc3_.control);
         _loc4_ = _loc4_ + this.newname_4345__END.encode(param1,_loc3_.linearVelocity);
         _loc4_ = _loc4_ + this.newname_4297__END.encode(param1,_loc3_.orientation);
         return _loc4_ + this.newname_4241__END.encode(param1,_loc3_.position);
      }
   }
}

