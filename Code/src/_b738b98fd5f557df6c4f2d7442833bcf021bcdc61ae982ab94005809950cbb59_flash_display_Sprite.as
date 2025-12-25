package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _b738b98fd5f557df6c4f2d7442833bcf021bcdc61ae982ab94005809950cbb59_flash_display_Sprite extends Sprite
   {
      
      public function _b738b98fd5f557df6c4f2d7442833bcf021bcdc61ae982ab94005809950cbb59_flash_display_Sprite()
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

