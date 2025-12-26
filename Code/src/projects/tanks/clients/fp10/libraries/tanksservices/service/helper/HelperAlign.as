package projects.tanks.clients.fp10.libraries.tanksservices.service.helper
{
   public final class HelperAlign
   {
      
      public static const NONE:int = 0;
      
      public static const TOP_LEFT:int = 9;
      
      public static const TOP_CENTER:int = 17;
      
      public static const TOP_RIGHT:int = 33;
      
      public static const MIDDLE_LEFT:int = 10;
      
      public static const MIDDLE_CENTER:int = 18;
      
      public static const MIDDLE_RIGHT:int = 34;
      
      public static const BOTTOM_LEFT:int = 12;
      
      public static const BOTTOM_CENTER:int = 20;
      
      public static const BOTTOM_RIGHT:int = 36;
      
      public static const TOP_MASK:int = 1;
      
      public static const MIDDLE_MASK:int = 2;
      
      public static const BOTTOM_MASK:int = 4;
      
      public static const LEFT_MASK:int = 8;
      
      public static const CENTER_MASK:int = 16;
      
      public static const RIGHT_MASK:int = 32;
      
      public function HelperAlign()
      {
         super();
      }
      
      public static function stringOf(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 0:
               _loc2_ = "NONE";
               break;
            case 9:
               _loc2_ = "TOP_LEFT";
               break;
            case 17:
               _loc2_ = "TOP_CENTER";
               break;
            case 33:
               _loc2_ = "TOP_RIGHT";
               break;
            case 10:
               _loc2_ = "MIDDLE_LEFT";
               break;
            case 18:
               _loc2_ = "MIDDLE_CENTER";
               break;
            case 34:
               _loc2_ = "MIDDLE_RIGHT";
               break;
            case 12:
               _loc2_ = "BOTTOM_LEFT";
               break;
            case 20:
               _loc2_ = "BOTTOM_CENTER";
               break;
            case 36:
               _loc2_ = "BOTTOM_RIGHT";
         }
         return _loc2_;
      }
   }
}

