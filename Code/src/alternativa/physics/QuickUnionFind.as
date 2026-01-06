package alternativa.physics
{
   public class QuickUnionFind
   {
      
      private var items:Vector.<int>;
      
      private var size:Vector.<int>;
      
      public function QuickUnionFind()
      {
         super();
         this.items = new Vector.<int>(1);
         this.size = new Vector.<int>(1);
      }
      
      public function init(param1:int) : void
      {
         this.items.length = param1;
         this.size.length = param1;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            this.items[_loc2_] = _loc2_;
            this.size[_loc2_] = 1;
            _loc2_++;
         }
      }
      
      public function union(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!this.connected(param1,param2))
         {
            _loc3_ = this.root(param1);
            _loc4_ = this.root(param2);
            _loc5_ = this.size[_loc3_];
            _loc6_ = this.size[_loc4_];
            if(_loc5_ > _loc6_)
            {
               this.items[_loc4_] = _loc3_;
               this.size[_loc3_] += _loc6_;
            }
            else
            {
               this.items[_loc3_] = _loc4_;
               this.size[_loc4_] += _loc5_;
            }
         }
      }
      
      public function connected(param1:int, param2:int) : Boolean
      {
         return this.root(param1) == this.root(param2);
      }
      
      public function root(param1:int) : int
      {
         var _loc2_:int = param1;
         while(this.items[_loc2_] != _loc2_)
         {
            _loc2_ = this.items[_loc2_];
         }
         return _loc2_;
      }
   }
}

