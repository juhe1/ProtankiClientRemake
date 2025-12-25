package alternativa.startup
{
   import flash.utils.ByteArray;
   import mx.utils.Base64Encoder;
   
   public class URLEncoder
   {
       
      
      public function URLEncoder()
      {
         super();
      }
      
      public static function encode(url:String) : String
      {
         var encoder:Base64Encoder = new Base64Encoder();
         encoder.insertNewLines = false;
         var bytes:ByteArray = new ByteArray();
         bytes.writeUTFBytes(url);
         encoder.encodeUTFBytes(bytes.toString());
         return encoder.toString();
      }
   }
}
