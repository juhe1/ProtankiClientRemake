package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1f056bce278203e2a04485b884473ff1474f233579628147b2f64278a040f1cd_flash_display_Sprite extends Sprite
   {
      
      public function _1f056bce278203e2a04485b884473ff1474f233579628147b2f64278a040f1cd_flash_display_Sprite()
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

