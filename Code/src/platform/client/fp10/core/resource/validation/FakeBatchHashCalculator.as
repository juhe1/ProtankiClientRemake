package platform.client.fp10.core.resource.validation
{
   public class FakeBatchHashCalculator implements IBatchHashCalculator
   {
      
      private static const instance:FakeBatchHashCalculator = new FakeBatchHashCalculator();
      
      public function FakeBatchHashCalculator()
      {
         super();
      }
      
      public static function getInstance() : IBatchHashCalculator
      {
         return instance;
      }
      
      public function clearHash() : void
      {
      }
      
      public function getHash() : IValidationHash
      {
         return ByteArrayValidationHash.EMPTY;
      }
      
      public function getErrorHash() : IValidationHash
      {
         return ByteArrayValidationHash.WRONG;
      }
      
      public function appendHash(param1:IValidationHash) : void
      {
      }
   }
}

