package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.user.damageindicator.TargetTankDamage;
   import projects.tanks.client.battlefield.models.user.damageindicator.DamageIndicatorType;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecTargetTankDamage implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = TargetTankDamage;
      
      private var newname_4315__END:ICodec;
      
      private var newname_4316__END:ICodec;
      
      private var newname_4298__END:ICodec;
      
      public function CodecTargetTankDamage(param1:ProtocolInitializer)
      {
         super();
         this.newname_4315__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4316__END = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecDamageIndicatorType");
         this.newname_4298__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.StringCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:TargetTankDamage = new TargetTankDamage();
         _loc2_.damageAmount = this.newname_4315__END.decode(param1) as Number;
         _loc2_.damageIndicatorType = this.newname_4316__END.decode(param1) as DamageIndicatorType;
         _loc2_.target = this.newname_4298__END.decode(param1) as String;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc4_:TargetTankDamage = TargetTankDamage(param2);
         _loc3_ += this.newname_4315__END.encode(param1,_loc4_.damageAmount);
         _loc3_ += this.newname_4316__END.encode(param1,_loc4_.damageIndicatorType);
         return _loc3_ + this.newname_4298__END.encode(param1,_loc4_.target);
      }
   }
}

