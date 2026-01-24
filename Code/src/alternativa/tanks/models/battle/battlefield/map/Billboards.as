package alternativa.tanks.models.battle.battlefield.map
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   
   public class Billboards
   {
      
      [Inject] // added
      public static var textureMaterialRegistry:TextureMaterialRegistry;
      
      private static const BILLBOARD_MATERIAL_NAME:String = "display";
      
      private var billboards:Vector.<Mesh> = new Vector.<Mesh>();
      
      private var faces:Vector.<Face> = new Vector.<Face>();
      
      private var material:TextureMaterial;
      
      private var billboardImage:BitmapData;
      
      public function Billboards()
      {
         super();
      }
      
      public function add(param1:Mesh) : void
      {
         var _loc2_:Face = null;
         this.billboards.push(param1);
         for each(_loc2_ in param1.faces)
         {
            if(_loc2_.material.name == BILLBOARD_MATERIAL_NAME)
            {
               this.faces.push(_loc2_);
               if(this.material == null)
               {
                  this.material = TextureMaterial(_loc2_.material);
                  this.updateMaterial();
               }
            }
         }
      }
      
      public function setImage(param1:BitmapData) : void
      {
         this.billboardImage = param1;
         this.updateMaterial();
      }
      
      private function updateMaterial() : void
      {
         if(this.material != null && this.billboardImage != null)
         {
            this.material.texture = this.billboardImage;
            this.setMaterialResolution();
         }
      }
      
      private function setMaterialResolution() : void
      {
         if(this.billboards.length > 0)
         {
            this.material.resolution = 1;
         }
      }
   }
}

