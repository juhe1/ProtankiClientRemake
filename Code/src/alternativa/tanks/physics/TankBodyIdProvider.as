package alternativa.tanks.physics
{
   import alternativa.tanks.utils.BitVector;
   
   public class TankBodyIdProvider
   {
      
      private static const MAX_IDS:int = 64;
      
      private static const instance:TankBodyIdProvider = new TankBodyIdProvider();
      
      private const ids:Vector.<int> = new Vector.<int>(MAX_IDS,true);
      
      private const claimedIds:BitVector = new BitVector(MAX_IDS);
      
      private var firstFreeIdIndex:int;
      
      public function TankBodyIdProvider()
      {
         super();
         this.reset();
      }
      
      public static function claimId() : int
      {
         return instance.claim();
      }
      
      public static function releaseId(param1:int) : void
      {
         instance.release(param1);
      }
      
      public static function resetIds() : void
      {
         instance.reset();
      }
      
      public function claim() : int
      {
         var _loc1_:int = 0;
         if(this.firstFreeIdIndex < MAX_IDS)
         {
            _loc1_ = this.ids[this.firstFreeIdIndex++];
            this.claimedIds.setBit(_loc1_);
            return _loc1_;
         }
         throw new Error();
      }
      
      public function release(param1:int) : void
      {
         if(this.claimedIds.getBit(param1) == 1)
         {
            this.claimedIds.clearBit(param1);
            this.ids[--this.firstFreeIdIndex] = param1;
         }
      }
      
      public function reset() : void
      {
         this.firstFreeIdIndex = 0;
         var _loc1_:int = 0;
         while(_loc1_ < MAX_IDS)
         {
            this.ids[_loc1_] = _loc1_;
            _loc1_++;
         }
         this.claimedIds.clear();
      }
   }
}

