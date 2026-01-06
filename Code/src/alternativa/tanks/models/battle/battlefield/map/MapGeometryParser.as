package alternativa.tanks.models.battle.battlefield.map
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.objects.BSP;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Occluder;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.physics.collision.types.AABB;
   import alternativa.proplib.PropLibRegistry;
   import alternativa.proplib.PropLibrary;
   import alternativa.proplib.objects.PropMesh;
   import alternativa.proplib.objects.PropObject;
   import alternativa.proplib.objects.PropSprite;
   import alternativa.proplib.types.PropData;
   import alternativa.proplib.types.PropGroup;
   import alternativa.tanks.battle.scene3d.Object3DNames;
   import alternativa.utils.clearDictionary;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.utils.Dictionary;
   
   public class MapGeometryParser
   {
      
      private static const objectMatrix:Matrix3D = new Matrix3D();
      
      private static const components:Vector.<Vector3D> = Vector.<Vector3D>([new Vector3D(),new Vector3D(),new Vector3D(1,1,1)]);
      
      private var propLibRegistry:PropLibRegistry;
      
      private var texturedPropsRegistry:TexturedPropsRegistry = new TexturedPropsRegistry();
      
      private var objects:Vector.<Object3D> = new Vector.<Object3D>();
      
      private var sprites:Vector.<Object3D> = new Vector.<Object3D>();
      
      private var occluders:Vector.<Occluder> = new Vector.<Occluder>();
      
      private var billboards:Vector.<Mesh> = new Vector.<Mesh>();
      
      private var meshProps:Vector.<Object3D> = new Vector.<Object3D>();
      
      private var propObjectByMesh:Dictionary = new Dictionary();
      
      private var textureNameByMesh:Dictionary = new Dictionary();
      
      private var mapBounds:AABB = new AABB();
      
      private var normalsCalculator:NormalsCalculator = new NormalsCalculator();
      
      private var christmasTree:Object3D;
      
      private var christmasTreeToys:Vector.<Object3D> = new Vector.<Object3D>();
      
      public function MapGeometryParser(param1:PropLibRegistry)
      {
         super();
         this.propLibRegistry = param1;
      }
      
      private static function getPropTextureName(param1:XML) : String
      {
         var _loc2_:String = null;
         var _loc3_:XMLList = param1.elements("texture-name");
         if(_loc3_.length() > 0)
         {
            _loc2_ = _loc3_[0];
         }
         return _loc2_ || PropMesh.DEFAULT_TEXTURE;
      }
      
      private static function readVector3D(param1:XMLList, param2:Vector3D) : void
      {
         var _loc3_:XML = null;
         if(param1.length() > 0)
         {
            _loc3_ = param1[0];
            param2.x = parseFloat(_loc3_.x);
            param2.y = parseFloat(_loc3_.y);
            param2.z = parseFloat(_loc3_.z);
         }
         else
         {
            param2.x = param2.y = param2.z = 0;
         }
      }
      
      public function parse(param1:XML) : void
      {
         this.parseProps(param1);
         this.normalsCalculator.calculateNormals(this.meshProps);
         if(this.christmasTree != null)
         {
            (this.christmasTree as Mesh).calculateVerticesNormalsByAngle(Math.PI / 3,1);
         }
         this.makeBSPs();
      }
      
      private function parseProps(param1:XML) : void
      {
         var _loc2_:XML = null;
         for each(_loc2_ in param1.elements("static-geometry").prop)
         {
            this.parseProp(_loc2_);
         }
      }
      
      private function parseProp(param1:XML) : void
      {
         var _loc2_:PropObject = this.getPropObject(param1);
         if(_loc2_ != null)
         {
            if(_loc2_ is PropMesh)
            {
               this.parseMesh(param1,PropMesh(_loc2_));
            }
            else if(_loc2_ is PropSprite)
            {
               this.parseSprite(param1,PropSprite(_loc2_));
            }
         }
      }
      
      private function getPropObject(param1:XML) : PropObject
      {
         var _loc2_:String = param1.attribute("library-name");
         var _loc3_:String = param1.attribute("group-name");
         var _loc4_:String = param1.@name;
         var _loc5_:PropLibrary = this.propLibRegistry.getLibrary(_loc2_);
         if(_loc5_ == null)
         {
            return null;
         }
         var _loc6_:PropGroup = _loc5_.rootGroup.getGroupByName(_loc3_);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc7_:PropData = _loc6_.getPropByName(_loc4_);
         if(_loc7_ == null)
         {
            return null;
         }
         return _loc7_.getDefaultState().getDefaultObject();
      }
      
      private function parseMesh(param1:XML, param2:PropMesh) : void
      {
         if(param1.@name == "Billboard")
         {
            this.parseBillboard(param1,param2);
         }
         else
         {
            this.parseMeshProp(param1,param2);
         }
      }
      
      private function parseBillboard(param1:XML, param2:PropMesh) : void
      {
         var _loc3_:Mesh = null;
         _loc3_ = Mesh(param2.object.clone());
         _loc3_.calculateFacesNormals();
         _loc3_.calculateVerticesNormalsByAngle(0);
         _loc3_.sorting = Sorting.DYNAMIC_BSP;
         _loc3_.name = Object3DNames.STATIC;
         this.billboards.push(_loc3_);
         var _loc4_:String = getPropTextureName(param1);
         this.texturedPropsRegistry.addMesh(param2,_loc4_,_loc3_,"display");
         var _loc5_:Vector3D = components[0];
         readVector3D(param1.position,_loc5_);
         this.mapBounds.addPoint(_loc5_.x,_loc5_.y,_loc5_.z);
         var _loc6_:Vector3D = components[1];
         readVector3D(param1.rotation,_loc6_);
         _loc3_.x = _loc5_.x;
         _loc3_.y = _loc5_.y;
         _loc3_.z = _loc5_.z;
         _loc3_.rotationZ = _loc6_.z;
         this.objects.push(_loc3_);
      }
      
      private function parseMeshProp(param1:XML, param2:PropMesh) : void
      {
         var _loc3_:Mesh = Mesh(param2.object.clone());
         var _loc4_:Vector3D = components[0];
         readVector3D(param1.position,_loc4_);
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.y;
         _loc3_.z = _loc4_.z;
         this.mapBounds.addPoint(_loc4_.x,_loc4_.y,_loc4_.z);
         var _loc5_:Vector3D = components[1];
         readVector3D(param1.rotation,_loc5_);
         _loc3_.rotationZ = _loc5_.z;
         var _loc6_:String = getPropTextureName(param1);
         this.meshProps.push(_loc3_);
         this.propObjectByMesh[_loc3_] = param2;
         this.textureNameByMesh[_loc3_] = _loc6_;
         this.createOccluders(param2,components);
         if(param1.@name == "Elka")
         {
            this.christmasTree = _loc3_;
         }
      }
      
      private function createOccluders(param1:PropMesh, param2:Vector.<Vector3D>) : void
      {
         var _loc3_:Occluder = null;
         var _loc4_:Matrix3D = null;
         var _loc5_:Occluder = null;
         if(param1.occluders != null)
         {
            objectMatrix.recompose(param2);
            for each(_loc3_ in param1.occluders)
            {
               _loc4_ = _loc3_.matrix;
               _loc4_.append(objectMatrix);
               _loc5_ = Occluder(_loc3_.clone());
               _loc5_.matrix = _loc4_;
               this.occluders.push(_loc5_);
            }
         }
      }
      
      private function parseSprite(param1:XML, param2:PropSprite) : void
      {
         var _loc5_:Vector3D = null;
         var _loc3_:Sprite3D = Sprite3D(param2.object.clone());
         if(param1.@name.indexOf("Shar") >= 0)
         {
            this.christmasTreeToys.push(_loc3_);
            _loc5_ = components[0];
            readVector3D(param1.position,_loc5_);
            _loc3_.x = _loc5_.x;
            _loc3_.y = _loc5_.y;
            _loc3_.z = _loc5_.z;
            _loc3_.name = param1.@name;
            return;
         }
         _loc3_.shadowMapAlphaThreshold = 0;
         _loc3_.softAttenuation = 80;
         this.sprites.push(_loc3_);
         var _loc4_:Vector3D = components[0];
         readVector3D(param1.position,_loc4_);
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.y;
         _loc3_.z = _loc4_.z;
         _loc3_.width = param2.scale;
         this.texturedPropsRegistry.addSprite3D(param2,_loc3_);
      }
      
      private function makeBSPs() : void
      {
         var _loc1_:Object3D = null;
         var _loc2_:Mesh = null;
         var _loc3_:BSP = null;
         for each(_loc1_ in this.meshProps)
         {
            _loc2_ = _loc1_ as Mesh;
            _loc3_ = new BSP();
            _loc3_.name = Object3DNames.STATIC;
            _loc3_.createTree(_loc2_,true);
            _loc3_.x = _loc2_.x;
            _loc3_.y = _loc2_.y;
            _loc3_.z = _loc2_.z;
            _loc3_.rotationZ = _loc2_.rotationZ;
            this.texturedPropsRegistry.addBSP(this.propObjectByMesh[_loc2_],this.textureNameByMesh[_loc2_],_loc3_);
            this.objects.push(_loc3_);
            if(_loc2_ == this.christmasTree)
            {
               this.christmasTree = _loc3_;
            }
         }
         this.meshProps.length = 0;
         clearDictionary(this.propObjectByMesh);
         clearDictionary(this.textureNameByMesh);
      }
      
      public function clear() : void
      {
         this.propLibRegistry = null;
         this.texturedPropsRegistry.clear();
         this.objects.length = 0;
         this.sprites.length = 0;
         this.occluders.length = 0;
         this.billboards.length = 0;
         this.christmasTree = null;
         this.christmasTreeToys.length = 0;
      }
      
      public function getObjects() : Vector.<Object3D>
      {
         return this.objects;
      }
      
      public function getSprites() : Vector.<Object3D>
      {
         return this.sprites;
      }
      
      public function getOccluders() : Vector.<Occluder>
      {
         return this.occluders;
      }
      
      public function getBillboards() : Vector.<Mesh>
      {
         return this.billboards;
      }
      
      public function getTexturedPropsCollections() : Vector.<TexturedPropsCollection>
      {
         return this.texturedPropsRegistry.getCollections();
      }
      
      public function getMapBounds() : AABB
      {
         return this.mapBounds;
      }
      
      public function getChristmasTree() : Object3D
      {
         return this.christmasTree;
      }
      
      public function getChristmasTreeToys() : Vector.<Object3D>
      {
         return this.christmasTreeToys;
      }
   }
}

