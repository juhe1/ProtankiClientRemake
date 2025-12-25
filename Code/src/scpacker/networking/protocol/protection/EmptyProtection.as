package scpacker.networking.protocol.protection
{
   import flash.utils.ByteArray;
   
   public class EmptyProtection implements IProtection
   {
      public function EmptyProtection()
      {
         super();
      }
      
      public function encrypt(param1:ByteArray) : void
      {
      }
      
      public function decrypt(param1:ByteArray, param2:int) : void
      {
      }
   }
}

