package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d1211cec2d9668b3e1670512fe369f4d85857764557045307c04e43929121ba2_flash_display_Sprite extends Sprite
   {
      
      public function _d1211cec2d9668b3e1670512fe369f4d85857764557045307c04e43929121ba2_flash_display_Sprite()
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

