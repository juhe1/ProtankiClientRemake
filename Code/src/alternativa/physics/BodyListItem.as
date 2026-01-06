package alternativa.physics
{
   public class BodyListItem
   {
      
      private static var poolTop:BodyListItem;
      
      public var body:Body;
      
      public var next:BodyListItem;
      
      public var prev:BodyListItem;
      
      public function BodyListItem(param1:Body)
      {
         super();
         this.body = param1;
      }
      
      public static function create(param1:Body) : BodyListItem
      {
         var _loc2_:BodyListItem = null;
         if(poolTop == null)
         {
            _loc2_ = new BodyListItem(param1);
         }
         else
         {
            _loc2_ = poolTop;
            poolTop = _loc2_.next;
            _loc2_.next = null;
            _loc2_.body = param1;
         }
         return _loc2_;
      }
      
      public static function clearPool() : void
      {
         var _loc1_:BodyListItem = poolTop;
         while(_loc1_ != null)
         {
            poolTop = _loc1_.next;
            _loc1_.next = null;
            _loc1_ = poolTop;
         }
      }
      
      public function dispose() : void
      {
         this.body = null;
         this.prev = null;
         this.next = poolTop;
         poolTop = this;
      }
   }
}

