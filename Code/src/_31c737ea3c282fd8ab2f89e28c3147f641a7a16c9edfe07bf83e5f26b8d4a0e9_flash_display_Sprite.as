package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _31c737ea3c282fd8ab2f89e28c3147f641a7a16c9edfe07bf83e5f26b8d4a0e9_flash_display_Sprite extends Sprite
   {
      
      public function _31c737ea3c282fd8ab2f89e28c3147f641a7a16c9edfe07bf83e5f26b8d4a0e9_flash_display_Sprite()
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

