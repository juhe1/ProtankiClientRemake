package scpacker.networking.protocol.protection
{
   import flash.utils.ByteArray;
   
   public interface IProtection
   {
      function encrypt(param1:ByteArray) : void;
      
      function decrypt(param1:ByteArray, param2:int) : void;
   }
}

