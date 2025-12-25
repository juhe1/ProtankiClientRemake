package platform.client.fp10.core.resource.validation
{
   import com.hurlant.crypto.hash.SHA1;
   import flash.utils.ByteArray;
   
   public class SHA1HashCalculationMethod implements IHashCalculationMethod
   {
      
      private static var _instance:SHA1HashCalculationMethod = new SHA1HashCalculationMethod();
      
      private static var sha1:SHA1 = new SHA1();
      
      public function SHA1HashCalculationMethod()
      {
         super();
      }
      
      public static function get instance() : SHA1HashCalculationMethod
      {
         return _instance;
      }
      
      public function calculateByteArrayHash(param1:ByteArray, param2:String) : IValidationHash
      {
         return new ByteArrayValidationHash(sha1.hash(param1));
      }
   }
}

