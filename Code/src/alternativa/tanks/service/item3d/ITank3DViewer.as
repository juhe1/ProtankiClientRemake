package alternativa.tanks.service.item3d
{
   import alternativa.tanks.gui.tankpreview.TankPreviewWindow;
   import flash.display.BitmapData;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   
   public interface ITank3DViewer
   {
      
      function setView(param1:TankPreviewWindow) : void;
      
      function resetView() : void;
      
      function setArmor(param1:Tanks3DSResource) : void;
      
      function setWeapon(param1:Tanks3DSResource) : void;
      
      function setDrone(param1:Tanks3DSResource) : void;
      
      function setColor(param1:BitmapData) : void;
      
      function setPreviewColor(param1:BitmapData) : void;
      
      function setAnimation(param1:MultiframeImageResource) : void;
      
      function setPreviewAnimation(param1:MultiframeImageResource) : void;
      
      function closePreview() : void;
   }
}

