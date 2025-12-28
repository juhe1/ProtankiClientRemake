package alternativa.tanks.gui.panel.buttons
{
   import flash.display.Bitmap;
   
   public class ShopBarButton extends MainPanelOrangeWideButton
   {
      
      private static const shopCrystals:Class = ShopBarButton_shopCrystals;
      
      private static const shopCrystalsIcon:Bitmap = new shopCrystals();
      
      public function ShopBarButton()
      {
         super(shopCrystalsIcon,1,2);
      }
   }
}

