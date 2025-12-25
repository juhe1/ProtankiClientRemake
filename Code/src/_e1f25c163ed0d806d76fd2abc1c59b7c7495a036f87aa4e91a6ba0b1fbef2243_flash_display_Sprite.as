package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _e1f25c163ed0d806d76fd2abc1c59b7c7495a036f87aa4e91a6ba0b1fbef2243_flash_display_Sprite extends Sprite
   {
      
      public function _e1f25c163ed0d806d76fd2abc1c59b7c7495a036f87aa4e91a6ba0b1fbef2243_flash_display_Sprite()
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

