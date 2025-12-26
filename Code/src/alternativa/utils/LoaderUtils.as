package alternativa.utils
{
   import flash.utils.ByteArray;
   import alternativa.types.Long;
   
   public class LoaderUtils
   {
      
      private static const SEPARATOR:String = "/";
       
      
      public function LoaderUtils()
      {
         super();
      }
      
      public static function getResourcePath(resourceId:ByteArray, version:ByteArray) : String
      {
         var highVersion:uint = 0;
         var lowVersion:uint = 0;
         highVersion = version.readUnsignedInt();
         lowVersion = version.readUnsignedInt();
         var versionOct:String = new Long(highVersion,lowVersion).toOct();
         return SEPARATOR + resourceId.readUnsignedInt().toString(8) + SEPARATOR + resourceId.readUnsignedShort().toString(8) + SEPARATOR + resourceId.readUnsignedByte().toString(8) + SEPARATOR + resourceId.readUnsignedByte().toString(8) + SEPARATOR + versionOct + SEPARATOR;
      }
   }
}
