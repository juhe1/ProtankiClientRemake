package alternativa.tanks.bonuses
{
   import alternativa.types.Long;
   import flash.utils.Dictionary;
   
   public class BonusCache
   {
      
      private static const parachuteCache:ObjectCache = new ObjectCache();
      
      private static const cordsCache:ObjectCache = new ObjectCache();
      
      private static var boxCaches:Dictionary = new Dictionary();
      
      public function BonusCache()
      {
         super();
      }
      
      public static function isParachuteCacheEmpty() : Boolean
      {
         return parachuteCache.isEmpty();
      }
      
      public static function getParachute() : Parachute
      {
         return Parachute(parachuteCache.get());
      }
      
      public static function putParachute(param1:Parachute) : void
      {
         parachuteCache.put(param1);
      }
      
      public static function isCordsCacheEmpty() : Boolean
      {
         return cordsCache.isEmpty();
      }
      
      public static function getCords() : Cords
      {
         return Cords(cordsCache.get());
      }
      
      public static function putCords(param1:Cords) : void
      {
         cordsCache.put(param1);
      }
      
      public static function isBonusMeshCacheEmpty(param1:Long) : Boolean
      {
         return getBonusMeshCache(param1).isEmpty();
      }
      
      public static function getBonusMesh(param1:Long) : BonusMesh
      {
         return BonusMesh(getBonusMeshCache(param1).get());
      }
      
      public static function putBonusMesh(param1:BonusMesh) : void
      {
         getBonusMeshCache(param1.getObjectId()).put(param1);
      }
      
      public static function clear() : void
      {
         parachuteCache.clear();
         cordsCache.clear();
         clearBoxCaches();
      }
      
      private static function getBonusMeshCache(param1:Long) : ObjectCache
      {
         var _loc2_:ObjectCache = boxCaches[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new ObjectCache();
            boxCaches[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private static function clearBoxCaches() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:ObjectCache = null;
         for(_loc1_ in boxCaches)
         {
            _loc2_ = boxCaches[_loc1_];
            _loc2_.clear();
            delete boxCaches[_loc1_];
         }
      }
   }
}

