package alternativa.tanks.utils
{
   public class BitVector
   {
      
      private var elements:Vector.<int>;
      
      public function BitVector(param1:uint)
      {
         super();
         this.elements = new Vector.<int>(param1 >> 5,true);
      }
      
      public function setBit(param1:int) : void
      {
         var _loc2_:int = param1 >> 5;
         this.elements[_loc2_] |= 1 << (param1 & 0x1F);
      }
      
      public function clearBit(param1:int) : void
      {
         var _loc2_:int = param1 >> 5;
         this.elements[_loc2_] &= ~(1 << (param1 & 0x1F));
      }
      
      public function getBit(param1:int) : int
      {
         var _loc2_:int = param1 >> 5;
         return this.elements[_loc2_] >> (param1 & 0x1F) & 1;
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.elements.length)
         {
            this.elements[_loc1_] = 0;
            _loc1_++;
         }
      }
   }
}

