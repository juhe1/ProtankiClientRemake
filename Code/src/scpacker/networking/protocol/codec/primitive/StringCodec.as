package scpacker.networking.protocol.codec.primitive
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.codec.OptionalCodec;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class StringCodec extends OptionalCodec implements ICodec
   {
      public const optionalVector:Boolean = true;
      
      public const element:Class = String;
      
      public function StringCodec()
      {
         super();
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(addBool(param1,param2))
         {
            return 1;
         }
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(String(param2));
         var _loc4_:int = int(_loc3_.length);
         param1.writeInt(_loc4_);
         param1.writeUTFBytes(String(param2));
         return 5 + _loc4_;
      }
      
      public function decode(param1:ByteArray) : Object
      {
         if(getBool(param1))
         {
            return null;
         }
         return param1.readUTFBytes(param1.readInt());
      }
   }
}

