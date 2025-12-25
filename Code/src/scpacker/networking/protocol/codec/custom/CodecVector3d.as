package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.types.Vector3d;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.OptionalCodec;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecVector3d extends OptionalCodec implements ICodec
   {
      public const optionalVector:Boolean = true;
      
      public const element:Class = Vector3d;
      
      public function CodecVector3d(param1:ProtocolInitializer)
      {
         super();
      }
      
      public function decode(param1:ByteArray) : Object
      {
         if(getBool(param1))
         {
            return null;
         }
         var _loc2_:Vector3d = new Vector3d();
         _loc2_.x = param1.readFloat();
         _loc2_.y = param1.readFloat();
         _loc2_.z = param1.readFloat();
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc4_:int = 1;
         if(addBool(param1,param2))
         {
            return _loc4_;
         }
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:Vector3d = Vector3d(param2);
         param1.writeFloat(_loc3_.x);
         param1.writeFloat(_loc3_.y);
         param1.writeFloat(_loc3_.z);
         return _loc4_ + 12;
      }
   }
}

