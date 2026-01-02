package scpacker.utils
{
   import alternativa.types.Long;
   
   public class IdTool
   {
      private static var id:int = 1000000;
      
      public function IdTool()
      {
         super();
      }
      
      public static function getNextId() : Long
      {
         return Long.fromInt(++id);
      }
   }
}

