package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b832266a19ae544eb623712f268f5a9c9c52c4097a11424149ea4481ae785dee_flash_display_Sprite extends Sprite
   {
      
      public function _b832266a19ae544eb623712f268f5a9c9c52c4097a11424149ea4481ae785dee_flash_display_Sprite()
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

