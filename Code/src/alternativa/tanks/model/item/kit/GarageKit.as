package alternativa.tanks.model.item.kit
{
   import projects.tanks.client.garage.models.item.kit.KitItem;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   [ModelInterface]
   public interface GarageKit
   {
      
      function getImage() : ImageResource;
      
      function getPrice() : int;
      
      function getPriceWithoutDiscount() : int;
      
      function getPriceAlreadyBought() : int;
      
      function getPriceYouSave() : int;
      
      function getItems() : Vector.<KitItem>;
      
      function canBuy() : Boolean;
   }
}

