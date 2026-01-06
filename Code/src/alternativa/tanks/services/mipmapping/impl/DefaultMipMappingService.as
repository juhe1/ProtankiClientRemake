package alternativa.tanks.services.mipmapping.impl
{
   import alternativa.tanks.services.mipmapping.*;
   import alternativa.utils.TextureMaterialRegistry;
   
   public class DefaultMipMappingService implements MipMappingService
   {
      
      private var mipMappingEnabled:Boolean;
      
      private var materialRegistries:Vector.<TextureMaterialRegistry> = new Vector.<TextureMaterialRegistry>();
      
      public function DefaultMipMappingService()
      {
         super();
      }
      
      public function isMipMappingEnabled() : Boolean
      {
         return this.mipMappingEnabled;
      }
      
      public function setMipMapping(param1:Boolean) : void
      {
         var _loc2_:TextureMaterialRegistry = null;
         if(this.mipMappingEnabled != param1)
         {
            this.mipMappingEnabled = param1;
            for each(_loc2_ in this.materialRegistries)
            {
               _loc2_.setMipMapping(param1);
            }
         }
      }
      
      public function toggleMipMapping() : void
      {
         this.setMipMapping(!this.mipMappingEnabled);
      }
      
      public function addMaterialRegistry(param1:TextureMaterialRegistry) : void
      {
         this.materialRegistries.push(param1);
         param1.setMipMapping(this.mipMappingEnabled);
      }
   }
}

