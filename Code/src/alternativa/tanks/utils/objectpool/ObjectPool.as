package alternativa.tanks.utils.objectpool
{
   import flash.utils.Dictionary;
   
   public class ObjectPool
   {
      
      private var pools:Dictionary = new Dictionary();
      
      public function ObjectPool()
      {
         super();
      }
      
      public function getObject(param1:Class) : Object
      {
         return this.getPoolForClass(param1).getObject();
      }
      
      public function clear() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.pools)
         {
            Pool(this.pools[_loc1_]).clear();
            delete this.pools[_loc1_];
         }
      }
      
      public function clearPoolForClass(param1:Class) : void
      {
         var _loc2_:Pool = this.pools[param1];
         if(_loc2_ != null)
         {
            _loc2_.clear();
         }
      }
      
      [Obfuscation(rename="false")]
      public function toString() : String
      {
         var _loc2_:* = undefined;
         var _loc3_:Pool = null;
         var _loc1_:String = "";
         for(_loc2_ in this.pools)
         {
            _loc3_ = this.pools[_loc2_];
            _loc1_ += _loc2_ + ": " + _loc3_.getNumObjects() + "\n";
         }
         return _loc1_;
      }
      
      private function getPoolForClass(param1:Class) : Pool
      {
         var _loc2_:Pool = this.pools[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Pool(param1);
            this.pools[param1] = _loc2_;
         }
         return _loc2_;
      }
   }
}

