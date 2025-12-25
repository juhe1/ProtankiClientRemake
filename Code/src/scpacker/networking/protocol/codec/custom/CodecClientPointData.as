package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battlefield.models.battle.cp.ClientPointData;
   import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecClientPointData implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = ClientPointData;
      
      private var newname_4240__END:ICodec;
      
      private var newname_4117__END:ICodec;
      
      private var newname_4241__END:ICodec;
      
      private var newname_4242__END:ICodec;
      
      private var newname_4243__END:ICodec;
      
      private var newname_4244__END:ICodec;
      
      private var newname_4245__END:ICodec;
      
      public function CodecClientPointData(param1:ProtocolInitializer)
      {
         super();
         this.newname_4240__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4117__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4241__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4242__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4243__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4244__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecControlPointState");
         this.newname_4245__END = param1.getCodec("scpacker.networking.protocol.codec.complex.VectorCodecString");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:ClientPointData = new ClientPointData();
         _loc2_.id = this.newname_4240__END.decode(param1) as int;
         _loc2_.name = this.newname_4117__END.decode(param1) as String;
         _loc2_.position = this.newname_4241__END.decode(param1) as Vector3d;
         _loc2_.score = this.newname_4242__END.decode(param1) as Number;
         _loc2_.scoreChangeRate = this.newname_4243__END.decode(param1) as Number;
         _loc2_.currentState = this.newname_4244__END.decode(param1) as ControlPointState;
         _loc2_.tankIds = this.newname_4245__END.decode(param1) as Vector.<String>;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:ClientPointData = ClientPointData(param2);
         this.newname_4240__END.encode(param1,_loc3_.id);
         this.newname_4117__END.encode(param1,_loc3_.name);
         this.newname_4241__END.encode(param1,_loc3_.position);
         this.newname_4242__END.encode(param1,_loc3_.score);
         this.newname_4243__END.encode(param1,_loc3_.scoreChangeRate);
         this.newname_4244__END.encode(param1,_loc3_.currentState);
         this.newname_4245__END.encode(param1,_loc3_.tankIds);
         return 4;
      }
   }
}

