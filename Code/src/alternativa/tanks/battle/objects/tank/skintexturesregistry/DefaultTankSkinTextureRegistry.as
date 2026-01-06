package alternativa.tanks.battle.objects.tank.skintexturesregistry
{
   import alternativa.tanks.battle.objects.tank.tankskin.TankSkinPartCacheItem;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class DefaultTankSkinTextureRegistry implements TankSkinTextureRegistry
   {
      
      private var textures:Dictionary = new Dictionary();
      
      public function DefaultTankSkinTextureRegistry()
      {
         super();
      }
      
      public function clear() : void
      {
         var _loc2_:Dictionary = null;
         var _loc3_:TextureEntry = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.textures)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.texture.dispose();
               _loc1_++;
            }
         }
         this.textures = new Dictionary();
      }
      
      public function getTexture(param1:TankSkinPartCacheItem, param2:BitmapData) : BitmapData
      {
         var _loc3_:Dictionary = this.getPartTextures(param1);
         var _loc4_:TextureEntry = this.getTextureEntry(param1,param2,_loc3_);
         ++_loc4_.referenceCount;
         return _loc4_.texture;
      }
      
      private function getPartTextures(param1:TankSkinPartCacheItem) : Dictionary
      {
         var _loc2_:Dictionary = this.textures[param1.partId];
         if(_loc2_ == null)
         {
            _loc2_ = new Dictionary();
            this.textures[param1.partId] = _loc2_;
         }
         return _loc2_;
      }
      
      private function getTextureEntry(param1:TankSkinPartCacheItem, param2:BitmapData, param3:Dictionary) : TextureEntry
      {
         var _loc4_:TextureEntry = param3[param2];
         if(_loc4_ == null)
         {
            _loc4_ = new TextureEntry(param1.createTexture(param2));
            param3[param2] = _loc4_;
         }
         return _loc4_;
      }
      
      public function releaseTexture(param1:TankSkinPartCacheItem, param2:BitmapData) : void
      {
         var _loc3_:Dictionary = this.textures[param1.partId];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:TextureEntry = _loc3_[param2];
         if(_loc4_ == null)
         {
            return;
         }
         --_loc4_.referenceCount;
         if(_loc4_.referenceCount == 0)
         {
            _loc4_.texture.dispose();
            delete _loc3_[param2];
         }
      }
   }
}

