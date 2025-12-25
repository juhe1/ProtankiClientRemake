package platform.client.fp10.core.resource.validation
{
   import flash.utils.ByteArray;
   
   public interface IHashCalculationMethod
   {
      
      function calculateByteArrayHash(param1:ByteArray, param2:String) : IValidationHash;
   }
}

