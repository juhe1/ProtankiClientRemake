package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _a0a2d7f3161d3a8c3a924a53207166415828256ff3c8a8ddfb81893aeec5210f_flash_display_Sprite extends Sprite
   {
      
      public function _a0a2d7f3161d3a8c3a924a53207166415828256ff3c8a8ddfb81893aeec5210f_flash_display_Sprite()
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

