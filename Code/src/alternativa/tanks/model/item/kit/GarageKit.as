package alternativa.tanks.model.item.kit
{
   import platform.client.fp10.core.resource.types.LocalizedImageResource;
   import projects.tanks.client.garage.models.item.kit.KitItem;
   
   [ModelInterface]
   public interface GarageKit
   {
      
      function getImage() : LocalizedImageResource;
      
      function getPrice() : int;
      
      function getPriceWithoutDiscount() : int;
      
      function getPriceAlreadyBought() : int;
      
      function getPriceYouSave() : int;
      
      function getItems() : Vector.<KitItem>;
      
      function canBuy() : Boolean;
   }
}

