package alternativa.tanks.help.achievements
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.locale.ILocaleService;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;
   
   public class PurchaseButtonHelper extends BubbleHelper
   {
      
      public function PurchaseButtonHelper()
      {
         super();
         var _loc1_:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
         text = _loc1_.getText(TanksLocale.TEXT_HELP_PANEL_ACHIEVEMENTS_FIRST_PURCHASE_BUTON_TEXT);
         arrowLehgth = int(_loc1_.getText(TanksLocale.TEXT_HELP_PANEL_ACHIEVEMENTS_FIRST_PURCHASE_BUTTON_ARROW_LENGTH));
         arrowAlign = HelperAlign.MIDDLE_RIGHT;
         _showLimit = 3;
      }
   }
}

