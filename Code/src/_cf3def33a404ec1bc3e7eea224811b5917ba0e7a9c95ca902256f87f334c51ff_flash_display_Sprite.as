package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _cf3def33a404ec1bc3e7eea224811b5917ba0e7a9c95ca902256f87f334c51ff_flash_display_Sprite extends Sprite
   {
      
      public function _cf3def33a404ec1bc3e7eea224811b5917ba0e7a9c95ca902256f87f334c51ff_flash_display_Sprite()
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

