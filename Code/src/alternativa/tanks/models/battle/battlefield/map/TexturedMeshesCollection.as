package alternativa.tanks.models.battle.battlefield.map
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.proplib.objects.PropMesh;
   import alternativa.utils.textureutils.TextureByteData;
   
   public class TexturedMeshesCollection implements TexturedPropsCollection
   {
      
      private var meshes:Vector.<Mesh> = new Vector.<Mesh>();
      
      private var propMesh:PropMesh;
      
      private var textureName:String;
      
      private var excludedMaterialName:String;
      
      public function TexturedMeshesCollection(param1:PropMesh, param2:String)
      {
         super();
         this.propMesh = param1;
         this.textureName = param2;
      }
      
      public function add(param1:Mesh, param2:String = null) : void
      {
         this.excludedMaterialName = param2;
         this.meshes.push(param1);
      }
      
      public function getTextureData() : TextureByteData
      {
         return this.propMesh.textures.getValue(this.textureName);
      }
      
      public function setMaterial(param1:TextureMaterial) : void
      {
         var _loc2_:Mesh = null;
         var _loc3_:Face = null;
         for each(_loc2_ in this.meshes)
         {
            for each(_loc3_ in _loc2_.faces)
            {
               if(Boolean(this.excludedMaterialName) && _loc3_.material.name != this.excludedMaterialName)
               {
                  _loc3_.material = param1;
               }
            }
            _loc2_.removeVertex(_loc2_.addVertex(0,0,0));
         }
      }
   }
}

