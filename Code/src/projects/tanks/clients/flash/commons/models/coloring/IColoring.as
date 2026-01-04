package projects.tanks.clients.flash.commons.models.coloring
{
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.ImageResource;

   [ModelInterface]
   public interface IColoring
   {
      
      function getColoring() : ImageResource;
      
      function getAnimatedColoring() : MultiframeImageResource;
      
      function isAnimated() : Boolean;
   }
}

