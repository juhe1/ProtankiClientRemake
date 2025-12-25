package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _da59b1fe24ea2d71f0ea6548b1c885dbaf9539f2cda6a3af18e463e36434bf02_flash_display_Sprite extends Sprite
   {
      
      public function _da59b1fe24ea2d71f0ea6548b1c885dbaf9539f2cda6a3af18e463e36434bf02_flash_display_Sprite()
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

