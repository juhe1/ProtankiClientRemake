package controls.base
{
   public class HackMenuButtonBase extends MainPanelButtonBase
   {
      
      private var iconClass:Class = HackIcon;
      
      public function HackMenuButtonBase()
      {
         super(this.iconClass);
      }
   }
}
