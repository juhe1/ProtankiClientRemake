package platform.client.fp10.core.resource.validation
{
   import com.hurlant.crypto.hash.MD5;
   import flash.utils.ByteArray;
   
   public class FastMD5HashCalculationMethod implements IHashCalculationMethod
   {
      
      private static var _instance:FastMD5HashCalculationMethod = new FastMD5HashCalculationMethod();
      
      private static const BLOCK_COUNT:int = 100;
      
      private static const BLOCK_SIZE:int = 1000;
      
      private static const SHORT_DATA_SIZE:int = BLOCK_COUNT * BLOCK_SIZE;
      
      private static const INITIAL_SHIFT:int = 17;
      
      private static const SHIFT_FACTOR:int = 414913;
      
      private static const SHIFT_PADDING:int = 213;
      
      private static var md5:MD5 = new MD5();
      
      private var shortData:ByteArray = new ByteArray();
      
      public function FastMD5HashCalculationMethod()
      {
         super();
         this.shortData.length = SHORT_DATA_SIZE;
      }
      
      public static function get instance() : FastMD5HashCalculationMethod
      {
         return _instance;
      }
      
      public function calculateByteArrayHash(param1:ByteArray, param2:String) : IValidationHash
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:int = int(param1.length);
         if(_loc3_ > SHORT_DATA_SIZE)
         {
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < BLOCK_COUNT)
            {
               _loc6_ = INITIAL_SHIFT;
               _loc7_ = 0;
               while(_loc7_ < BLOCK_SIZE)
               {
                  _loc8_ = int(param1[(_loc4_ + _loc7_) % _loc3_]);
                  this.shortData[_loc5_ * BLOCK_SIZE + _loc7_] = _loc8_;
                  _loc6_ = (_loc6_ + SHIFT_FACTOR * (_loc8_ + SHIFT_PADDING)) % _loc3_;
                  _loc7_++;
               }
               _loc4_ = (_loc4_ + _loc6_) % _loc3_;
               _loc5_++;
            }
            return new ByteArrayValidationHash(md5.hash(this.shortData));
         }
         return new ByteArrayValidationHash(md5.hash(param1));
      }
   }
}

