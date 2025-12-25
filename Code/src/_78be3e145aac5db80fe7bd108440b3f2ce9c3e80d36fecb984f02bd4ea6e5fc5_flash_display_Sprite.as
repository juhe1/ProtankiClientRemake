package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _78be3e145aac5db80fe7bd108440b3f2ce9c3e80d36fecb984f02bd4ea6e5fc5_flash_display_Sprite extends Sprite
   {
      
      public function _78be3e145aac5db80fe7bd108440b3f2ce9c3e80d36fecb984f02bd4ea6e5fc5_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain.apply(null,rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain.apply(null,rest);
      }
   }
}

