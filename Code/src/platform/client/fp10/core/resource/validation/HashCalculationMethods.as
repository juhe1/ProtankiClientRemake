package platform.client.fp10.core.resource.validation
{
   import platform.client.fp10.core.registry.ResourceRegistry;
   
   public class HashCalculationMethods
   {
      
      [Inject]
      public static var resourceRegistry:ResourceRegistry;
      
      public static const DEFAULT:int = 0;
      
      public static const NONE:int = 1;
      
      public static const MD5:int = 2;
      
      public static const SHA1:int = 3;
      
      public static const FAST_MD5:int = 4;
      
      public function HashCalculationMethods()
      {
         super();
      }
      
      public static function getMethod(param1:int) : IHashCalculationMethod
      {
         var _loc2_:IHashCalculationMethod = null;
         switch(param1)
         {
            case DEFAULT:
               throw new NoSuchHashCalculationMethodException();
            case NONE:
               return NoneHashCalculationMethod.instance;
            case MD5:
               return MD5HashCalculationMethod.instance;
            case SHA1:
               return SHA1HashCalculationMethod.instance;
            case FAST_MD5:
               return FastMD5HashCalculationMethod.instance;
            default:
               _loc2_ = resourceRegistry.getHashCalculationMethod(param1);
               if(_loc2_ == null)
               {
                  throw new NoSuchHashCalculationMethodException();
               }
               return _loc2_;
         }
      }
   }
}

