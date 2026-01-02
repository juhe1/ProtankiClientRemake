package alternativa.tanks.model.item.present
{
   import alternativa.types.Long;
   
   [ModelInterface]
   public interface UserPresent
   {
      
      function getText() : String;
      
      function getPresenterId() : String;
      
      function getDate() : Date;
   }
}

