package alternativa.tanks.gui.tables
{
   import alternativa.osgi.service.locale.ILocaleService;
   import alternativa.tanks.service.item.ItemService;
   import assets.Diamond;
   import controls.Money;
   import controls.base.LabelBase;
   import flash.display.Sprite;
   import flash.text.TextFormatAlign;
   import projects.tanks.client.garage.models.item.kit.KitItem;
   
   public class KitItemInfoRow extends Sprite
   {
      
      [Inject] // added
      public static var itemService:ItemService;
      
      [Inject] // added
      public static var localeService:ILocaleService;
      
      public function KitItemInfoRow(param1:int, param2:int, param3:KitItem, param4:int, param5:int)
      {
         super();
         var _loc6_:int = param2;
         this.y = param1;
         var _loc7_:LabelBase = new LabelBase();
         _loc7_.align = TextFormatAlign.LEFT;
         _loc7_.text = itemService.getName(param3.item) + (param3.count <= 1 ? "" : " ×" + String(param3.count));
         _loc7_.x = param4;
         addChild(_loc7_);
         var _loc8_:Diamond = new Diamond();
         _loc8_.x = _loc6_ - _loc7_.x - _loc8_.width;
         addChild(_loc8_);
         _loc8_.y = param5;
         var _loc9_:int = itemService.getPriceWithoutDiscount(param3.item) * param3.count;
         var _loc10_:LabelBase = new LabelBase();
         _loc10_.align = TextFormatAlign.RIGHT;
         _loc10_.text = Money.numToString(_loc9_,false);
         _loc10_.x = _loc8_.x - _loc10_.width - 1;
         addChild(_loc10_);
      }
   }
}

