package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _21ca517c702eec3cf1b69f4cb1b04a035a00a9d0271b2e69d537ed050bcced67_flash_display_Sprite extends Sprite
   {
      
      public function _21ca517c702eec3cf1b69f4cb1b04a035a00a9d0271b2e69d537ed050bcced67_flash_display_Sprite()
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

