package alternativa.tanks.model.item.present
{
   import platform.client.fp10.core.resource.types.ImageResource;
   import projects.tanks.client.garage.models.item.present.IPresentItemModelBase;
   import projects.tanks.client.garage.models.item.present.PresentItemModelBase;
   import projects.tanks.client.garage.models.user.present.PresentItem;
   
   [ModelInfo]
   public class PresentItemModel extends PresentItemModelBase implements IPresentItemModelBase, PresentImage, UserPresent
   {
      
      public function PresentItemModel()
      {
         super();
      }

      public function getText() : String
      {
         return getInitParam().text;
      }
      
      public function getImage() : ImageResource
      {
         return getInitParam().image;
      }

      public function getPresenterId() : String
      {
         return getInitParam().presenter;
      }
      
      public function getDate() : Date
      {
         return new Date(getInitParam().date);
      }
      
   }
}

