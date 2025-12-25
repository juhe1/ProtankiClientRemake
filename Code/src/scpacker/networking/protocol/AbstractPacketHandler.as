package scpacker.networking.protocol
{
   import alternativa.osgi.OSGi;
   import alternativa.tanks.services.tankregistry.TankUsersRegistry;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.registry.SpaceRegistry;
   import platform.client.fp10.core.registry.GameTypeRegistry;
   
   public class AbstractPacketHandler
   {
      public var id:int;
      
      protected var modelRegistry:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      
      protected var resourceRegistry:ResourceRegistry = ResourceRegistry(OSGi.getInstance().getService(ResourceRegistry));
      
      protected var gameTypeRegistry:GameTypeRegistry = GameTypeRegistry(OSGi.getInstance().getService(GameTypeRegistry));
      
      protected var spaceRegistry:SpaceRegistry = SpaceRegistry(OSGi.getInstance().getService(SpaceRegistry));
      
      protected var tankUsersRegistry:TankUsersRegistry = TankUsersRegistry(OSGi.getInstance().getService(TankUsersRegistry));
      
      public function AbstractPacketHandler()
      {
         super();
      }
   }
}

