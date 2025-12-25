package platform.client.fp10.core.resource.validation
{
   public interface IBatchHashCalculator
   {
      
      function clearHash() : void;
      
      function appendHash(param1:IValidationHash) : void;
      
      function getHash() : IValidationHash;
      
      function getErrorHash() : IValidationHash;
   }
}

