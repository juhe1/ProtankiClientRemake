package platform.client.fp10.core.resource.validation
{
   import flash.utils.ByteArray;
   
   public class NoneHashCalculationMethod implements IHashCalculationMethod
   {
      
      private static var _instance:NoneHashCalculationMethod = new NoneHashCalculationMethod();
      
      public function NoneHashCalculationMethod()
      {
         super();
      }
      
      public static function get instance() : NoneHashCalculationMethod
      {
         return _instance;
      }
      
      public function calculateByteArrayHash(param1:ByteArray, param2:String) : IValidationHash
      {
         return ByteArrayValidationHash.EMPTY;
      }
   }
}

