package platform.client.fp10.core.resource.validation
{
   import alternativa.osgi.service.launcherparams.ILauncherParams;
   import flash.utils.ByteArray;
   
   public class BatchHashCalculator implements IBatchHashCalculator
   {
      
      [Inject] // added
      public static var launcherParams:ILauncherParams;
      
      private var currentHash:ByteArrayValidationHash;
      
      private var length:int;
      
      public function BatchHashCalculator()
      {
         super();
      }
      
      public static function getInstance() : IBatchHashCalculator
      {
         if(launcherParams.isDisableValidationResource())
         {
            return FakeBatchHashCalculator.getInstance();
         }
         var _loc1_:BatchHashCalculator = new BatchHashCalculator();
         _loc1_.clearHash();
         return _loc1_;
      }
      
      public function clearHash() : void
      {
         this.currentHash = ByteArrayValidationHash.EMPTY;
      }
      
      public function appendHash(param1:IValidationHash) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc2_:ByteArrayValidationHash = ByteArrayValidationHash(param1);
         if(_loc2_ != ByteArrayValidationHash.EMPTY)
         {
            if(this.currentHash == ByteArrayValidationHash.WRONG || _loc2_ == ByteArrayValidationHash.WRONG)
            {
               this.currentHash = ByteArrayValidationHash.WRONG;
            }
            else
            {
               if(this.currentHash == ByteArrayValidationHash.EMPTY)
               {
                  _loc4_ = new ByteArray();
                  this.length = _loc4_.length = _loc2_.data.length;
                  this.currentHash = new ByteArrayValidationHash(_loc4_);
               }
               _loc3_ = 0;
               while(_loc3_ < this.length)
               {
                  this.currentHash.data[_loc3_] ^= _loc2_.data[_loc3_];
                  _loc3_++;
               }
            }
         }
      }
      
      public function getHash() : IValidationHash
      {
         return this.currentHash;
      }
      
      public function getErrorHash() : IValidationHash
      {
         return ByteArrayValidationHash.WRONG;
      }
   }
}

