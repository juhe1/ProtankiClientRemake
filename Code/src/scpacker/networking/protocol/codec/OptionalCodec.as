package scpacker.networking.protocol.codec
{
   import flash.utils.ByteArray;
   
   public class OptionalCodec
   {
      public function OptionalCodec()
      {
         super();
      }
      
      public function getBool(param1:ByteArray) : Boolean
      {
         return param1.readBoolean();
      }
      
      public function addBool(param1:ByteArray, param2:Object) : Boolean
      {
         var _loc3_:* = param2 == null;
         param1.writeBoolean(_loc3_);
         return _loc3_;
      }
   }
}

