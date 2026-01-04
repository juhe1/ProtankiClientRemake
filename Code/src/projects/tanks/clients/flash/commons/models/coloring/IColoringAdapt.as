package projects.tanks.clients.flash.commons.models.coloring
{
   import platform.client.fp10.core.model.impl.Model;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class IColoringAdapt implements IColoring
   {
      
      private var object:IGameObject;
      
      private var impl:IColoring;
      
      public function IColoringAdapt(param1:IGameObject, param2:IColoring)
      {
         super();
         this.object = param1;
         this.impl = param2;
      }
      
      public function getColoring() : ImageResource
      {
         var result:ImageResource = null;
         try
         {
            Model.object = this.object;
            result = this.impl.getColoring();
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
      
      public function getAnimatedColoring() : MultiframeImageResource
      {
         var result:MultiframeImageResource = null;
         try
         {
            Model.object = this.object;
            result = this.impl.getAnimatedColoring();
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
      
      public function isAnimated() : Boolean
      {
         var result:Boolean = false;
         try
         {
            Model.object = this.object;
            result = Boolean(this.impl.isAnimated());
         }
         finally
         {
            Model.popObject();
         }
         return result;
      }
   }
}

