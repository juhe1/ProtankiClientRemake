package alternativa.tanks.utils
{
   public class CircularObjectBuffer
   {
      
      private var buffer:Vector.<Object>;
      
      private var writeIndex:int;
      
      private var headIndex:int;
      
      public function CircularObjectBuffer(param1:int)
      {
         super();
         this.buffer = new Vector.<Object>(param1 + 1,true);
      }
      
      public function addObject(param1:Object) : void
      {
         this.buffer[this.writeIndex] = param1;
         this.writeIndex = this.incIndex(this.writeIndex);
         if(this.headIndex == this.writeIndex)
         {
            this.headIndex = this.incIndex(this.headIndex);
         }
      }
      
      public function clear() : void
      {
         var _loc1_:int = int(this.buffer.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.buffer[_loc2_] = null;
            _loc2_++;
         }
         this.headIndex = this.writeIndex = 0;
      }
      
      public function getObjects() : Vector.<Object>
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = this.writeIndex - this.headIndex;
         if(_loc1_ < 0)
         {
            _loc1_ += this.buffer.length;
         }
         var _loc2_:Vector.<Object> = new Vector.<Object>(_loc1_);
         var _loc3_:int = int(this.buffer.length);
         _loc4_ = 0;
         _loc5_ = this.headIndex;
         while(_loc4_ < _loc1_)
         {
            if(_loc5_ == _loc3_)
            {
               _loc5_ = 0;
            }
            _loc2_[_loc4_] = this.buffer[_loc5_];
            _loc4_++;
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function incIndex(param1:int) : int
      {
         return ++param1 == this.buffer.length ? 0 : param1;
      }
   }
}

