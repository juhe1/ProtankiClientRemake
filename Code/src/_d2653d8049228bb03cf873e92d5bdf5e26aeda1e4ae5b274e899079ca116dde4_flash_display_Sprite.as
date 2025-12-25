package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d2653d8049228bb03cf873e92d5bdf5e26aeda1e4ae5b274e899079ca116dde4_flash_display_Sprite extends Sprite
   {
      
      public function _d2653d8049228bb03cf873e92d5bdf5e26aeda1e4ae5b274e899079ca116dde4_flash_display_Sprite()
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

