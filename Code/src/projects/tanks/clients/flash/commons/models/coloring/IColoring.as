package projects.tanks.clients.flash.commons.models.coloring
{
   import alternativa.gfx.core.TextureResource;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;

   [ModelInterface]
   public interface IColoring
   {
      
      function getColoring() : TextureResource;
      
      function getAnimatedColoring() : MultiframeImageResource;
      
      function isAnimated() : Boolean;
   }
}

