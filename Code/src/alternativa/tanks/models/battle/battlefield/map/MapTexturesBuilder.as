package alternativa.tanks.models.battle.battlefield.map
{
   import alternativa.tanks.engine3d.IndexedTextureConstructor;
   import alternativa.utils.TextureMaterialRegistry;
   import alternativa.utils.textureutils.ITextureConstructorListener;
   import alternativa.utils.textureutils.TextureConstructor;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class MapTexturesBuilder extends EventDispatcher implements ITextureConstructorListener
   {
      
      private var materialRegistry:TextureMaterialRegistry;
      
      private var maxBatchSize:int;
      
      private var totalCounter:int;
      
      private var lastCollectionIndex:int;
      
      private var texturedPropsCollections:Vector.<TexturedPropsCollection>;
      
      private var constructors:Vector.<IndexedTextureConstructor>;
      
      private var killed:Boolean;
      
      private var textures:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      public function MapTexturesBuilder(param1:TextureMaterialRegistry, param2:int)
      {
         super();
         this.materialRegistry = param1;
         this.maxBatchSize = param2;
      }
      
      public function destroy() : void
      {
         var _loc1_:BitmapData = null;
         this.killed = true;
         this.texturedPropsCollections = null;
         this.constructors = null;
         for each(_loc1_ in this.textures)
         {
            _loc1_.dispose();
         }
         this.textures = null;
      }
      
      public function run(param1:Vector.<TexturedPropsCollection>) : void
      {
         this.texturedPropsCollections = param1.concat();
         this.totalCounter = 0;
         this.lastCollectionIndex = 0;
         this.createTextureConstructors();
         this.runConstructors();
      }
      
      private function createTextureConstructors() : void
      {
         this.constructors = new Vector.<IndexedTextureConstructor>(this.maxBatchSize);
         var _loc1_:int = 0;
         while(_loc1_ < this.maxBatchSize)
         {
            this.constructors[_loc1_] = new IndexedTextureConstructor();
            _loc1_++;
         }
      }
      
      private function runConstructors() : void
      {
         var _loc1_:IndexedTextureConstructor = null;
         for each(_loc1_ in this.constructors)
         {
            this.runConstructor(_loc1_);
         }
      }
      
      private function runConstructor(param1:IndexedTextureConstructor) : void
      {
         var _loc2_:TexturedPropsCollection = null;
         if(this.lastCollectionIndex < this.texturedPropsCollections.length)
         {
            param1.index = this.lastCollectionIndex;
            _loc2_ = this.texturedPropsCollections[this.lastCollectionIndex++];
            param1.createTexture(_loc2_.getTextureData(),this);
         }
      }
      
      [Obfuscation(rename="false")]
      public function onTextureReady(param1:TextureConstructor) : void
      {
         var _loc2_:IndexedTextureConstructor = IndexedTextureConstructor(param1);
         if(this.killed)
         {
            _loc2_.disposeTexture();
         }
         else
         {
            this.textures.push(_loc2_.texture);
            this.assignMaterialToProps(_loc2_);
            ++this.totalCounter;
            if(this.totalCounter == this.texturedPropsCollections.length)
            {
               this.complete();
            }
            else
            {
               this.runConstructor(_loc2_);
            }
         }
      }
      
      private function assignMaterialToProps(param1:IndexedTextureConstructor) : void
      {
         var _loc2_:TexturedPropsCollection = this.texturedPropsCollections[param1.index];
         _loc2_.setMaterial(this.materialRegistry.getMaterial(param1.texture));
      }
      
      private function complete() : void
      {
         this.texturedPropsCollections = null;
         this.constructors = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function getTextures() : Vector.<BitmapData>
      {
         return this.textures;
      }
   }
}

