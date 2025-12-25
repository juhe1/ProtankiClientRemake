package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c0279b445b74660f70428d3efbcd52cd01737e65fcf45c99e196551e01b93ba9_flash_display_Sprite extends Sprite
   {
      
      public function _c0279b445b74660f70428d3efbcd52cd01737e65fcf45c99e196551e01b93ba9_flash_display_Sprite()
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

