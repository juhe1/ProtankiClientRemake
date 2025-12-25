package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class VectorCodecByte implements ICodec
   {
      public function VectorCodecByte()
      {
         super();
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.readInt();
         var _loc2_:Vector.<int> = new Vector.<int>(_loc3_,true);
         while(_loc4_ < _loc3_)
         {
            _loc2_[_loc4_] = param1.readByte();
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc5_:int = 0;
         var _loc3_:Vector.<int> = Vector.<int>(param2);
         var _loc4_:int = int(_loc3_.length);
         param1.writeInt(_loc4_);
         while(_loc5_ < _loc4_)
         {
            param1.writeByte(_loc3_[_loc5_]);
            _loc5_++;
         }
         return _loc4_;
      }
   }
}

