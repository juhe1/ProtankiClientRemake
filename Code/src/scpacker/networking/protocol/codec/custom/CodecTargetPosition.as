package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   import utils.TankNameGameObjectMapper;
   
   public class CodecTargetPosition implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = TargetPosition;
      
      private var newname_2399__END:TankUsersRegistry;
      
      private var newname_4296__END:ICodec;
      
      private var newname_4297__END:ICodec;
      
      private var newname_4241__END:ICodec;
      
      private var newname_4298__END:ICodec;
      
      private var newname_4299__END:ICodec;
      
      public function CodecTargetPosition(param1:ProtocolInitializer)
      {
         super();
         this.newname_2399__END = TankUsersRegistry(OSGi.getInstance().getService(TankUsersRegistry));
         this.newname_4296__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4297__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4241__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4298__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
         this.newname_4299__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:TargetPosition = new TargetPosition();
         _loc2_.localHitPoint = this.newname_4296__END.decode(param1) as Vector3d;
         _loc2_.orientation = this.newname_4297__END.decode(param1) as Vector3d;
         _loc2_.position = this.newname_4241__END.decode(param1) as Vector3d;
         _loc2_.target = TankNameGameObjectMapper.getGameObjectByTankName(this.newname_4298__END.decode(param1) as String);
         _loc2_.turretAngle = this.newname_4299__END.decode(param1) as Number;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:int = 0;
         var _loc4_:TargetPosition = TargetPosition(param2);
         _loc3_ += this.newname_4296__END.encode(param1,_loc4_.localHitPoint);
         _loc3_ += this.newname_4297__END.encode(param1,_loc4_.orientation);
         _loc3_ += this.newname_4241__END.encode(param1,_loc4_.position);
         _loc3_ += this.newname_4298__END.encode(param1,_loc4_.target == null ? null : _loc4_.target.name);
         return _loc3_ + this.newname_4299__END.encode(param1,_loc4_.turretAngle);
      }
   }
}

