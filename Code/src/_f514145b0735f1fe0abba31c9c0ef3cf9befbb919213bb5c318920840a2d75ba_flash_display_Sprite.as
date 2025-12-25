package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f514145b0735f1fe0abba31c9c0ef3cf9befbb919213bb5c318920840a2d75ba_flash_display_Sprite extends Sprite
   {
      
      public function _f514145b0735f1fe0abba31c9c0ef3cf9befbb919213bb5c318920840a2d75ba_flash_display_Sprite()
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

