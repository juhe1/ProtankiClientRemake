package alternativa.tanks.models.tank.codec
{
   public class BitArea
   {
      
      private var data:Array;
      
      private var length:int;
      
      private var position:int;
      
      public function BitArea(param1:Array, param2:int)
      {
         super();
         this.data = param1;
         this.position = 0;
         this.length = param2 * 8;
      }
      
      public function reset() : void
      {
         this.position = 0;
      }
      
      public function read(param1:int) : int
      {
         if(param1 > 32)
         {
            throw new Error("Cannot read more that 32 bit at once (requested " + param1 + ")");
         }
         if(this.position + param1 > this.length)
         {
            throw new Error("BitArea is out of data: requesed " + param1 + " bits, avaliable:" + (this.length - this.position));
         }
         var _loc2_:int = 0;
         var _loc3_:int = param1 - 1;
         while(_loc3_ >= 0)
         {
            if(this.getBit(this.position))
            {
               _loc2_ += 1 << _loc3_;
            }
            ++this.position;
            _loc3_--;
         }
         return _loc2_;
      }
      
      public function write(param1:int, param2:int) : void
      {
         var _loc4_:Boolean = false;
         if(param1 > 32)
         {
            throw new Error("Cannot write more that 32 bit at once (requested " + param1 + ")");
         }
         if(this.position + param1 > this.length)
         {
            throw new Error("BitArea overflow attempt to write " + param1 + " bits, space avaliable:" + (this.length - this.position));
         }
         var _loc3_:int = param1 - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = (param2 & 1 << _loc3_) != 0;
            this.setBit(this.position,_loc4_);
            ++this.position;
            _loc3_--;
         }
      }
      
      private function arrayToHezString(param1:Array) : String
      {
         var _loc4_:int = 0;
         var _loc2_:String = "";
         var _loc3_:Boolean = true;
         for each(_loc4_ in param1)
         {
            if(!_loc3_)
            {
               _loc2_ += ", ";
            }
            _loc2_ += _loc4_.toString(16);
            _loc3_ = false;
         }
         return _loc2_;
      }
      
      private function getBit(param1:int) : Boolean
      {
         var _loc2_:int = param1 >> 3;
         var _loc3_:int = 7 ^ param1 & 7;
         return (this.data[_loc2_] & 1 << _loc3_) != 0;
      }
      
      private function setBit(param1:int, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = param1 >> 3;
         var _loc4_:int = 7 ^ param1 & 7;
         if(param2)
         {
            this.data[_loc3_] = int(this.data[_loc3_] | 1 << _loc4_);
         }
         else
         {
            _loc5_ = int(0xFF ^ 1 << _loc4_);
            this.data[_loc3_] = int(this.data[_loc3_] & _loc5_);
         }
      }
      
      public function getLength() : int
      {
         return this.length;
      }
      
      public function getData() : Array
      {
         return this.data;
      }
   }
}

