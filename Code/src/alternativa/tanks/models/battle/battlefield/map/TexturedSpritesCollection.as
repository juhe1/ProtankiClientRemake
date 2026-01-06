package alternativa.tanks.models.battle.battlefield.map
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.proplib.objects.PropSprite;
   import alternativa.utils.textureutils.TextureByteData;
   import flash.display.BitmapData;
   
   public class TexturedSpritesCollection implements TexturedPropsCollection
   {
      
      private var propSprite:PropSprite;
      
      private var sprites:Vector.<Sprite3D> = new Vector.<Sprite3D>();
      
      public function TexturedSpritesCollection(param1:PropSprite, param2:String)
      {
         super();
         this.propSprite = param1;
      }
      
      public function addSprite3D(param1:Sprite3D) : void
      {
         this.sprites.push(param1);
      }
      
      public function setMaterial(param1:TextureMaterial) : void
      {
         var _loc3_:Sprite3D = null;
         var _loc4_:Number = NaN;
         var _loc2_:BitmapData = param1.texture;
         for each(_loc3_ in this.sprites)
         {
            _loc3_.material = param1;
            _loc4_ = Number(_loc3_.width);
            _loc3_.width = _loc4_ * _loc2_.width;
            _loc3_.height = _loc4_ * _loc2_.height;
         }
      }
      
      public function getTextureData() : TextureByteData
      {
         return this.propSprite.textureData;
      }
   }
}

