package alternativa.physics
{
   public class BodyList
   {
      
      public var head:BodyListItem;
      
      public var tail:BodyListItem;
      
      public var size:int;
      
      public function BodyList()
      {
         super();
      }
      
      public function append(param1:Body) : void
      {
         var _loc2_:BodyListItem = BodyListItem.create(param1);
         if(this.head == null)
         {
            this.head = this.tail = _loc2_;
         }
         else
         {
            this.tail.next = _loc2_;
            _loc2_.prev = this.tail;
            this.tail = _loc2_;
         }
         ++this.size;
      }
      
      public function remove(param1:Body) : Boolean
      {
         var _loc2_:BodyListItem = this.findItem(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         if(_loc2_ == this.head)
         {
            if(this.size == 1)
            {
               this.head = this.tail = null;
            }
            else
            {
               this.head = _loc2_.next;
               this.head.prev = null;
            }
         }
         else if(_loc2_ == this.tail)
         {
            this.tail = _loc2_.prev;
            this.tail.next = null;
         }
         else
         {
            _loc2_.prev.next = _loc2_.next;
            _loc2_.next.prev = _loc2_.prev;
         }
         _loc2_.dispose();
         --this.size;
         return true;
      }
      
      public function findItem(param1:Body) : BodyListItem
      {
         var _loc2_:BodyListItem = this.head;
         while(_loc2_ != null && _loc2_.body != param1)
         {
            _loc2_ = _loc2_.next;
         }
         return _loc2_;
      }
   }
}

