package utils
{
   import platform.client.fp10.core.type.IGameObject;

   public class TankNameGameObjectMapper
   {
      
      private static var mappings:Object = {};
      
      public function TankNameGameObjectMapper()
      {
         throw new Error("TankNameToGameObjectMapper is a static utility class and cannot be instantiated");
      }
      
      /**
       * Gets a game object by tank name
       * @param tankName The tank name key
       * @return The mapped game object, or null if not found
       */
      public static function getGameObjectByTankName(tankName:String) : IGameObject
      {
         return mappings[tankName] || null;
      }
      
      /**
       * Gets a tank name by game object
       * @param gameObject The game object to search for
       * @return The tank name associated with the game object, or null if not found
       */
      public static function getTankNameByGameObject(gameObject:IGameObject) : String
      {
         for (var tankName:String in mappings)
         {
            if (mappings[tankName] === gameObject)
            {
               return tankName;
            }
         }
         return null;
      }
   }
}
