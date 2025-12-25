package platform.client.fp10.core.resource.validation
{
   import com.hurlant.util.Base64;
   import flash.utils.ByteArray;
   
   public class ByteArrayValidationHash implements IValidationHash
   {
      
      public static var EMPTY:ByteArrayValidationHash = new ByteArrayValidationHash(new ByteArray());
      
      public static var WRONG:ByteArrayValidationHash = new ByteArrayValidationHash(new ByteArray(),true);
      
      public var data:ByteArray;
      
      public var isWrong:Boolean;
      
      public function ByteArrayValidationHash(param1:ByteArray, param2:Boolean = false)
      {
         super();
         this.data = param1;
         this.isWrong = param2;
      }
      
      public function getTextHash() : String
      {
         return this.isWrong ? "WRONG" : Base64.encodeByteArray(this.data);
      }
      
      public function toString() : String
      {
         return this.getTextHash();
      }
   }
}

