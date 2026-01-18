package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.codec.ICodec;
   import utils.TankNameGameObjectMapper;
   import scpacker.networking.protocol.ProtocolInitializer;
   
   public class CodecTargetHit implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = TargetHit;
      
      private var newname_2399__END:TankUsersRegistry;
      
      private var newname_4390__END:ICodec;
      
      private var newname_4296__END:ICodec;
      
      private var newname_4391__END:ICodec;
      
      private var newname_4298__END:ICodec;
      
      public function CodecTargetHit(param1:ProtocolInitializer)
      {
         super();
         this.newname_2399__END = TankUsersRegistry(OSGi.getInstance().getService(TankUsersRegistry));
         this.newname_4390__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4296__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecVector3d");
         this.newname_4391__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.ByteCodec");
         this.newname_4298__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:TargetHit = new TargetHit();
         _loc2_.direction = this.newname_4390__END.decode(param1) as Vector3d;
         _loc2_.localHitPoint = this.newname_4296__END.decode(param1) as Vector3d;
         _loc2_.numberHits = this.newname_4391__END.decode(param1) as int;
         _loc2_.target = TankNameGameObjectMapper.getGameObjectByTankName(this.newname_4298__END.decode(param1) as String);
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc4_:TargetHit = TargetHit(param2);
         _loc3_ += this.newname_4390__END.encode(param1,_loc4_.direction);
         _loc3_ += this.newname_4296__END.encode(param1,_loc4_.localHitPoint);
         _loc3_ += this.newname_4391__END.encode(param1,_loc4_.numberHits);
         return _loc3_ + this.newname_4298__END.encode(param1,_loc4_.target);
      }
   }
}

