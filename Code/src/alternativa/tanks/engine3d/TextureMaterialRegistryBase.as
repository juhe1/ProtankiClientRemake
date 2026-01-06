package alternativa.tanks.engine3d
{
   import alternativa.engine3d.core.MipMapping;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.materials.AnimatedPaintMaterial;
   import alternativa.tanks.materials.PaintMaterial;
   import alternativa.types.Long;
   import alternativa.utils.TextureMaterialRegistry;
   import alternativa.utils.clearDictionary;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.resource.types.MultiframeTextureResource;
   import platform.client.fp10.core.resource.types.TextureResource;
   
   public class TextureMaterialRegistryBase implements TextureMaterialRegistry
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private var materialStat:CachedEntityStat = new CachedEntityStat();
      
      private var materialFactory:TextureMaterialFactory;
      
      private var mipMappingEnabled:Boolean;
      
      private const materials:Vector.<TextureMaterial> = new Vector.<TextureMaterial>();
      
      private const entryForTexture:Dictionary = new Dictionary();
      
      private const entryForMaterial:Dictionary = new Dictionary();
      
      public function TextureMaterialRegistryBase(param1:TextureMaterialFactory)
      {
         super();
         this.materialFactory = param1;
      }
      
      public function getMaterialStat() : CachedEntityStat
      {
         return this.materialStat;
      }
      
      public function getAnimatedPaint(param1:MultiframeTextureResource, param2:BitmapData, param3:BitmapData, param4:Long) : AnimatedPaintMaterial
      {
         var _loc9_:MaterialEntry = null;
         ++this.materialStat.requestCount;
         var _loc5_:String = param1.id + " " + param4;
         if(_loc5_ in this.entryForTexture)
         {
            _loc9_ = this.entryForTexture[_loc5_];
            ++_loc9_.referenceCount;
            return _loc9_.material as AnimatedPaintMaterial;
         }
         var _loc6_:int = param1.data.width / param1.frameWidth;
         var _loc7_:int = param1.data.height / param1.frameHeight;
         var _loc8_:AnimatedPaintMaterial = new AnimatedPaintMaterial(param1.data,param2,param3,_loc6_,_loc7_,param1.fps,param1.numFrames,this.mipMappingEnabled ? int(MipMapping.PER_PIXEL) : 0);
         _loc9_ = this.createPaintMaterialEntry(_loc5_,_loc8_);
         ++_loc9_.referenceCount;
         this.materials.push(_loc8_);
         ++this.materialStat.createCount;
         return _loc8_;
      }
      
      public function getPaint(param1:TextureResource, param2:BitmapData, param3:BitmapData, param4:Long) : PaintMaterial
      {
         var _loc7_:MaterialEntry = null;
         ++this.materialStat.requestCount;
         var _loc5_:String = param1.id + " " + param4;
         if(_loc5_ in this.entryForTexture)
         {
            _loc7_ = this.entryForTexture[_loc5_];
            ++_loc7_.referenceCount;
            return _loc7_.material as PaintMaterial;
         }
         var _loc6_:PaintMaterial = new PaintMaterial(param1.data,param2,param3,this.mipMappingEnabled ? int(MipMapping.PER_PIXEL) : 0);
         _loc7_ = this.createPaintMaterialEntry(_loc5_,_loc6_);
         ++_loc7_.referenceCount;
         this.materials.push(_loc6_);
         ++this.materialStat.createCount;
         return _loc6_;
      }
      
      public function getMaterial(param1:BitmapData, param2:Boolean = true) : TextureMaterial
      {
         if(param1 == null)
         {
            throw new ArgumentError("Texture is null");
         }
         ++this.materialStat.requestCount;
         var _loc3_:MaterialEntry = this.getOrCreateEntry(param1,param2);
         ++_loc3_.referenceCount;
         return _loc3_.material;
      }
      
      private function getOrCreateEntry(param1:BitmapData, param2:Boolean) : MaterialEntry
      {
         var _loc4_:TextureMaterial = null;
         var _loc3_:MaterialEntry = this.entryForTexture[param1];
         if(_loc3_ == null)
         {
            _loc4_ = this.createMaterial(param1,param2);
            _loc3_ = this.createMaterialEntry(param1,_loc4_);
         }
         return _loc3_;
      }
      
      private function createMaterial(param1:BitmapData, param2:Boolean) : TextureMaterial
      {
         var _loc3_:BitmapData = this.getTexture(param1,param2);
         var _loc4_:TextureMaterial = this.materialFactory.createTextureMaterial(_loc3_,this.mipMappingEnabled);
         this.materials.push(_loc4_);
         ++this.materialStat.createCount;
         return _loc4_;
      }
      
      protected function getTexture(param1:BitmapData, param2:Boolean) : BitmapData
      {
         throw new Error("Not implemented");
      }
      
      private function createPaintMaterialEntry(param1:String, param2:TextureMaterial) : MaterialEntry
      {
         var _loc3_:MaterialEntry = new MaterialEntry(param1,param2);
         this.entryForTexture[param1] = _loc3_;
         this.entryForMaterial[param2] = _loc3_;
         return _loc3_;
      }
      
      private function createMaterialEntry(param1:BitmapData, param2:TextureMaterial) : MaterialEntry
      {
         var _loc3_:MaterialEntry = new MaterialEntry(param1,param2);
         this.entryForTexture[param1] = _loc3_;
         this.entryForMaterial[param2] = _loc3_;
         return _loc3_;
      }
      
      public function addMaterial(param1:TextureMaterial) : void
      {
         var _loc2_:MaterialEntry = this.createMaterialEntry(null,param1);
         ++_loc2_.referenceCount;
         this.entryForMaterial[param1] = _loc2_;
         this.materials.push(param1);
      }
      
      public function releaseMaterial(param1:TextureMaterial) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:MaterialEntry = this.entryForMaterial[param1];
         if(_loc2_ != null)
         {
            ++this.materialStat.releaseCount;
            --_loc2_.referenceCount;
            if(_loc2_.referenceCount == 0)
            {
               this.removeMaterialEntry(_loc2_);
            }
         }
      }
      
      private function removeMaterialEntry(param1:MaterialEntry) : void
      {
         ++this.materialStat.destroyCount;
         var _loc2_:TextureMaterial = param1.material;
         if(param1.keyData in this.entryForTexture)
         {
            delete this.entryForTexture[param1.keyData];
         }
         delete this.entryForMaterial[_loc2_];
         param1.material = null;
         var _loc3_:int = int(this.materials.indexOf(_loc2_));
         this.materials.splice(_loc3_,1);
         _loc2_.dispose();
      }
      
      protected function forEachMaterial(param1:Function) : void
      {
         var _loc2_:TextureMaterial = null;
         for each(_loc2_ in this.materials)
         {
            param1(_loc2_);
         }
      }
      
      public function setMipMapping(param1:Boolean) : void
      {
         if(this.mipMappingEnabled != param1)
         {
            if(param1)
            {
               this.enableMipMapping();
            }
            else
            {
               this.disableMipMapping();
            }
         }
      }
      
      private function enableMipMapping() : void
      {
         if(!this.mipMappingEnabled)
         {
            this.mipMappingEnabled = true;
            this.forEachMaterial(this.disposeResource);
            this.forEachMaterial(this._enableMipMapping);
         }
      }
      
      private function _enableMipMapping(param1:TextureMaterial) : void
      {
         param1.mipMapping = MipMapping.PER_PIXEL;
      }
      
      private function disableMipMapping() : void
      {
         if(this.mipMappingEnabled)
         {
            this.mipMappingEnabled = false;
            this.forEachMaterial(this.disposeResource);
            this.forEachMaterial(this._disableMipMapping);
         }
      }
      
      private function disposeResource(param1:TextureMaterial) : void
      {
         param1.disposeResource();
      }
      
      private function _disableMipMapping(param1:TextureMaterial) : void
      {
         param1.mipMapping = MipMapping.NONE;
      }
      
      public function clear() : void
      {
         this.forEachMaterial(this._clearTexture);
         this.materials.length = 0;
         clearDictionary(this.entryForTexture);
         clearDictionary(this.entryForMaterial);
         this.materialStat.clear();
      }
      
      private function _clearTexture(param1:TextureMaterial) : void
      {
         param1.texture = null;
      }
      
      protected function getEntry(param1:TextureMaterial) : MaterialEntry
      {
         return this.entryForMaterial[param1];
      }
   }
}

