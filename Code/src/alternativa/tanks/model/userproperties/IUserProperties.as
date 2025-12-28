package alternativa.tanks.model.userproperties
{
   [ModelInterface]
   public interface IUserProperties
   {
      
      function getId() : String;
      
      function getName() : String;
      
      function getScore() : int;
      
      function getRank() : int;
      
      function getNextScore() : int;
      
      function getPlace() : int;
   }
}