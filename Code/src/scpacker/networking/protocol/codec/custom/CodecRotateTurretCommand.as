package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.user.tank.commands.RotateTurretCommand;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecRotateTurretCommand implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = RotateTurretCommand;
      
      private var newname_4159__END:ICodec;
      
      private var newname_4160__END:ICodec;
      
      public function CodecRotateTurretCommand(param1:ProtocolInitializer)
      {
         super();
         this.newname_4159__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4160__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:RotateTurretCommand = new RotateTurretCommand();
         _loc2_.angle = this.newname_4159__END.decode(param1) as Number;
         _loc2_.control = this.newname_4160__END.decode(param1) as int;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc4_:RotateTurretCommand = RotateTurretCommand(param2);
         _loc3_ += this.newname_4159__END.encode(param1,_loc4_.angle);
         return _loc3_ + this.newname_4160__END.encode(param1,_loc4_.control);
      }
   }
}

