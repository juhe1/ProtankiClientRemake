package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _346a0ccfd66971bc884df48dcd14d36b2aaf0d74e88d7df18b968d276799682f_flash_display_Sprite extends Sprite
   {
      
      public function _346a0ccfd66971bc884df48dcd14d36b2aaf0d74e88d7df18b968d276799682f_flash_display_Sprite()
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

