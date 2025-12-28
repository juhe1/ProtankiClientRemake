package alternativa.tanks.help.achievements
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.locale.ILocaleService;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.BubbleHelper;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;
   
   public class FirstBattleCreateHelper extends BubbleHelper
   {
      
      public function FirstBattleCreateHelper()
      {
         super();
         var _loc1_:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
         text = _loc1_.getText(TanksLocale.TEXT_HELP_PANEL_ACHIEVEMENTS_CREATE_BATTLE_TEXT);
         arrowLehgth = int(_loc1_.getText(TanksLocale.TEXT_HELP_PANEL_ACHIEVEMENTS_CREATE_BATTLE_ARROW_LENGTH));
         arrowAlign = HelperAlign.TOP_LEFT;
         _showLimit = 3;
      }
   }
}

