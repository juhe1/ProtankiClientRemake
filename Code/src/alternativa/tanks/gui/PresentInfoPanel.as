package alternativa.tanks.gui
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.types.Long;
   import controls.base.LabelBase;
   import flash.display.Sprite;
   import forms.ColorConstants;
   import forms.userlabel.UserLabel;
   import projects.tanks.clients.flash.commons.services.datetime.DateFormatter;
   import projects.tanks.clients.fp10.libraries.TanksLocale;
   
   public class PresentInfoPanel extends Sprite
   {
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      private var fromLabel:LabelBase;
      
      private var presenterLabel:UserLabel;
      
      private var dateLabel:LabelBase;
      
      private var messageLabel:LabelBase;
      
      public function PresentInfoPanel(param1:int)
      {
         super();
         this.fromLabel = new LabelBase();
         this.fromLabel.text = localeService.getText(TanksLocale.TEXT_PRESENT_INFO_FROM_LABEL);
         this.fromLabel.color = ColorConstants.GREEN_TEXT;
         addChild(this.fromLabel);
         this.dateLabel = new LabelBase();
         this.dateLabel.y = this.fromLabel.height;
         this.dateLabel.color = ColorConstants.GREEN_TEXT;
         addChild(this.dateLabel);
         var _loc2_:LabelBase = new LabelBase();
         _loc2_.y = this.dateLabel.y + this.dateLabel.height + 12;
         _loc2_.text = localeService.getText(TanksLocale.TEXT_PRESENT_INFO_MESSAGE_LABEL);
         _loc2_.color = ColorConstants.GREEN_TEXT;
         addChild(_loc2_);
         this.messageLabel = new LabelBase();
         this.messageLabel.multiline = true;
         this.messageLabel.wordWrap = true;
         this.messageLabel.width = param1;
         this.messageLabel.color = ColorConstants.GREEN_TEXT;
         this.messageLabel.y = _loc2_.y + this.dateLabel.height + 12;
         addChild(this.messageLabel);
      }
      
      public function update(param1:String, param2:Date, param3:String) : void
      {
         this.destroyPresenterLabel();
         this.presenterLabel = new UserLabel(param1);
         this.presenterLabel.x = this.fromLabel.textWidth + 2;
         addChild(this.presenterLabel);
         this.dateLabel.text = localeService.getText(TanksLocale.TEXT_PRESENT_INFO_DATE_LABEL) + " " + DateFormatter.formatDateToLocalized(param2) + " " + DateFormatter.formatTime(param2);
         this.messageLabel.text = param3;
      }
      
      public function setMessageWidth(param1:Number) : void
      {
         this.messageLabel.width = param1;
      }
      
      public function destroyPresenterLabel() : void
      {
         if(this.presenterLabel != null)
         {
            if(contains(this.presenterLabel))
            {
               removeChild(this.presenterLabel);
            }
            this.presenterLabel = null;
         }
      }
      
      public function destroy() : void
      {
         this.destroyPresenterLabel();
      }
   }
}

