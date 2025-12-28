package alternativa.tanks.help
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.locale.ILocaleService;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.HelperAlign;
   
   public class ButtonBarHelper extends PanelBubbleHelper
   {
      
      public function ButtonBarHelper(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Boolean)
      {
         super(param1,param2,param3);
         var _loc6_:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
         var _loc7_:String = _loc6_.getText(param4 ? TanksLocale.TEXT_PARTNER_HELP_PANEL_BUTTON_BAR_HELPER_TEXT : TanksLocale.TEXT_HELP_PANEL_BUTTON_BAR_HELPER_TEXT);
         if(param5)
         {
            _loc7_ += _loc6_.getText(TanksLocale.TEXT_HELP_PANEL_BUTTON_BAR_FULLSCREEN_TEXT);
         }
         text = _loc7_;
         arrowLehgth = int(_loc6_.getText(TanksLocale.TEXT_HELP_PANEL_BUTTON_BAR_HELPER_ARROW_LENGTH));
         arrowAlign = HelperAlign.TOP_RIGHT;
      }
   }
}

