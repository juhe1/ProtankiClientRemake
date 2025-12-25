package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _3a5ef9a266050a8fdfe8cf9ec12455896ad83df38a1fb4ea4e9d8567ec108478_flash_display_Sprite extends Sprite
   {
      
      public function _3a5ef9a266050a8fdfe8cf9ec12455896ad83df38a1fb4ea4e9d8567ec108478_flash_display_Sprite()
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

