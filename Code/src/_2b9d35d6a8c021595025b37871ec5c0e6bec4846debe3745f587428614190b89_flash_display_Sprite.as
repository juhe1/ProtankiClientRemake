package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2b9d35d6a8c021595025b37871ec5c0e6bec4846debe3745f587428614190b89_flash_display_Sprite extends Sprite
   {
      
      public function _2b9d35d6a8c021595025b37871ec5c0e6bec4846debe3745f587428614190b89_flash_display_Sprite()
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

