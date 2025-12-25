package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _25302d3cff0070d476cd3cd061e0d0603ab1857653fa9c2d73ff351d82c2610e_flash_display_Sprite extends Sprite
   {
      
      public function _25302d3cff0070d476cd3cd061e0d0603ab1857653fa9c2d73ff351d82c2610e_flash_display_Sprite()
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

