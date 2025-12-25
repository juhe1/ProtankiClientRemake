package platform.client.fp10.core.resource.validation
{
   import com.hurlant.crypto.hash.MD5;
   import flash.utils.ByteArray;
   
   public class MD5HashCalculationMethod implements IHashCalculationMethod
   {
      
      private static var _instance:MD5HashCalculationMethod = new MD5HashCalculationMethod();
      
      private static var md5:MD5 = new MD5();
      
      public function MD5HashCalculationMethod()
      {
         super();
      }
      
      public static function get instance() : MD5HashCalculationMethod
      {
         return _instance;
      }
      
      public function calculateByteArrayHash(param1:ByteArray, param2:String) : IValidationHash
      {
         return new ByteArrayValidationHash(md5.hash(param1));
      }
   }
}

