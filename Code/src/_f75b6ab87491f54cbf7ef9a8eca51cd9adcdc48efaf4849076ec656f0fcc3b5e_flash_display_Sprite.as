package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _f75b6ab87491f54cbf7ef9a8eca51cd9adcdc48efaf4849076ec656f0fcc3b5e_flash_display_Sprite extends Sprite
   {
      
      public function _f75b6ab87491f54cbf7ef9a8eca51cd9adcdc48efaf4849076ec656f0fcc3b5e_flash_display_Sprite()
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

