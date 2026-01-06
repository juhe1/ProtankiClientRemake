package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _17f23539650e2c00b2f0f500069676f4833fe45f9b464dacd5401fd18e72af33_flash_display_Sprite extends Sprite
   {
      
      public function _17f23539650e2c00b2f0f500069676f4833fe45f9b464dacd5401fd18e72af33_flash_display_Sprite()
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

