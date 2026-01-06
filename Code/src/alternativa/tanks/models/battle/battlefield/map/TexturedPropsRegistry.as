package alternativa.tanks.models.battle.battlefield.map
{
   import alternativa.engine3d.objects.BSP;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.proplib.objects.PropMesh;
   import alternativa.proplib.objects.PropObject;
   import alternativa.proplib.objects.PropSprite;
   import alternativa.utils.clearDictionary;
   import flash.utils.Dictionary;
   
   public class TexturedPropsRegistry
   {
      
      private var bspCollections:Dictionary = new Dictionary();
      
      private var meshCollections:Dictionary = new Dictionary();
      
      private var spriteCollections:Dictionary = new Dictionary();
      
      public function TexturedPropsRegistry()
      {
         super();
      }
      
      public function addBSP(param1:PropMesh, param2:String, param3:BSP) : void
      {
         var _loc4_:TexturedBSPsCollection = this.getBSPsCollection(param1,param2);
         _loc4_.addBsp(param3);
      }
      
      private function getBSPsCollection(param1:PropMesh, param2:String) : TexturedBSPsCollection
      {
         return TexturedBSPsCollection(this.getCollection(this.bspCollections,param1,param2,TexturedBSPsCollection));
      }
      
      public function addMesh(param1:PropMesh, param2:String, param3:Mesh, param4:String = null) : void
      {
         var _loc5_:TexturedMeshesCollection = this.getMeshesCollection(param1,param2);
         _loc5_.add(param3,param4);
      }
      
      private function getMeshesCollection(param1:PropMesh, param2:String) : TexturedMeshesCollection
      {
         return TexturedMeshesCollection(this.getCollection(this.meshCollections,param1,param2,TexturedMeshesCollection));
      }
      
      public function addSprite3D(param1:PropSprite, param2:Sprite3D) : void
      {
         var _loc3_:TexturedSpritesCollection = this.getSpritesCollection(param1);
         _loc3_.addSprite3D(param2);
      }
      
      private function getSpritesCollection(param1:PropSprite) : TexturedSpritesCollection
      {
         return TexturedSpritesCollection(this.getCollection(this.spriteCollections,param1,null,TexturedSpritesCollection));
      }
      
      private function getCollection(param1:Dictionary, param2:PropObject, param3:String, param4:Class) : TexturedPropsCollection
      {
         var _loc5_:Dictionary = param1[param2];
         if(_loc5_ == null)
         {
            _loc5_ = new Dictionary();
            param1[param2] = _loc5_;
         }
         var _loc6_:TexturedPropsCollection = _loc5_[param3];
         if(_loc6_ == null)
         {
            _loc6_ = new param4(param2,param3);
            _loc5_[param3] = _loc6_;
         }
         return _loc6_;
      }
      
      public function getCollections() : Vector.<TexturedPropsCollection>
      {
         var _loc1_:Vector.<TexturedPropsCollection> = new Vector.<TexturedPropsCollection>();
         this.collect(this.bspCollections,_loc1_);
         this.collect(this.meshCollections,_loc1_);
         this.collect(this.spriteCollections,_loc1_);
         return _loc1_;
      }
      
      private function collect(param1:Dictionary, param2:Vector.<TexturedPropsCollection>) : void
      {
         var _loc3_:Dictionary = null;
         var _loc4_:TexturedPropsCollection = null;
         for each(_loc3_ in param1)
         {
            for each(_loc4_ in _loc3_)
            {
               param2.push(_loc4_);
            }
         }
      }
      
      public function clear() : void
      {
         this.clearCollections(this.meshCollections);
         this.clearCollections(this.bspCollections);
         this.clearCollections(this.spriteCollections);
      }
      
      private function clearCollections(param1:Dictionary) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in param1)
         {
            clearDictionary(param1[_loc2_]);
            delete param1[_loc2_];
         }
      }
   }
}

