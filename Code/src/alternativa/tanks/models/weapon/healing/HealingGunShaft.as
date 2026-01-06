package alternativa.tanks.models.weapon.healing
{
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   
   internal class HealingGunShaft extends Mesh
   {
      
      private var verts:Vector.<Vertex>;
      
      private var vertsLen:int = 0;
      
      private var direction:int = 1;
      
      private var width:Number;
      
      private var segment:Number = 1;
      
      private var offset:Number = 0;
      
      private var wave1Offset:Number = 0;
      
      private var wave2Offset:Number = 0;
      
      public function HealingGunShaft()
      {
         var _loc4_:Vertex = null;
         var _loc5_:Vertex = null;
         this.verts = new Vector.<Vertex>();
         super();
         var _loc1_:Vertex = addVertex(-1,0,0);
         var _loc2_:Vertex = addVertex(1,0,0);
         this.verts[this.vertsLen] = _loc1_;
         ++this.vertsLen;
         this.verts[this.vertsLen] = _loc2_;
         ++this.vertsLen;
         var _loc3_:int = 0;
         while(_loc3_ < HealingGunEffectsParams.SHAFT_NUM_SEGMENTS)
         {
            _loc4_ = addVertex(-1,-_loc3_ - 1,0);
            _loc5_ = addVertex(1,-_loc3_ - 1,0);
            this.verts[this.vertsLen] = _loc4_;
            ++this.vertsLen;
            this.verts[this.vertsLen] = _loc5_;
            ++this.vertsLen;
            addQuadFace(_loc1_,_loc4_,_loc5_,_loc2_);
            _loc1_ = _loc4_;
            _loc2_ = _loc5_;
            _loc3_++;
         }
         calculateFacesNormals();
         sorting = Sorting.DYNAMIC_BSP;
         shadowMapAlphaThreshold = 2;
         depthMapAlphaThreshold = 2;
         useShadowMap = false;
         useLight = false;
      }
      
      public function init(param1:Number, param2:Number) : void
      {
         var _loc5_:Vertex = null;
         var _loc6_:Vertex = null;
         this.width = param1;
         var _loc3_:Number = param1 * 0.5;
         var _loc4_:int = 0;
         while(_loc4_ < this.vertsLen)
         {
            _loc5_ = this.verts[_loc4_];
            _loc4_++;
            _loc6_ = this.verts[_loc4_];
            _loc5_.x = -_loc3_;
            _loc5_.u = 0;
            _loc6_.x = _loc3_;
            _loc6_.u = 1;
            _loc4_++;
         }
         boundMinX = -_loc3_;
         boundMaxX = _loc3_;
         boundMinY = 0;
         boundMinZ = 0;
         boundMaxZ = 0;
      }
      
      public function setMaterial(param1:Material, param2:int) : void
      {
         this.direction = param2;
         setMaterialToAllFaces(param1);
         var _loc3_:TextureMaterial = param1 as TextureMaterial;
         if(_loc3_ != null && _loc3_.texture != null)
         {
            this.segment = this.width * _loc3_.texture.height / _loc3_.texture.width;
         }
         else
         {
            this.segment = this.width;
         }
         this.offset = 0;
         this.wave1Offset = 0;
         this.wave2Offset = 0;
      }
      
      public function update(param1:int, param2:Number) : void
      {
         var _loc11_:Vertex = null;
         var _loc12_:Vertex = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc3_:Number = HealingGunEffectsParams.SHAFT_WAVE_AMPLITUDE / this.width;
         var _loc4_:Number = this.direction * HealingGunEffectsParams.SHAFT_WAVE1_SPEED;
         var _loc5_:Number = this.direction * HealingGunEffectsParams.SHAFT_WAVE2_SPEED;
         var _loc6_:Number = this.direction * HealingGunEffectsParams.SHAFT_STREAM_SPEED / this.segment;
         this.wave1Offset += _loc4_ * param1 / 1000;
         this.wave2Offset += _loc5_ * param1 / 1000;
         this.offset += _loc6_ * param1 / 1000;
         var _loc7_:Number = param2 / HealingGunEffectsParams.SHAFT_NUM_SEGMENTS;
         var _loc8_:Number = param2 / 2;
         var _loc9_:Number = 1;
         var _loc10_:int = 0;
         while(_loc10_ < this.vertsLen)
         {
            _loc11_ = this.verts[_loc10_];
            _loc10_++;
            _loc12_ = this.verts[_loc10_];
            _loc11_.y = param2 - (_loc10_ >> 1) * _loc7_;
            _loc12_.y = _loc11_.y;
            _loc13_ = _loc8_ - _loc11_.y;
            _loc11_.v = _loc13_ / this.segment + this.offset;
            _loc12_.v = _loc11_.v;
            if(_loc11_.y < _loc8_)
            {
               _loc9_ = _loc11_.y / HealingGunEffectsParams.SHAFT_AMPLITUDE_FADE;
            }
            else
            {
               _loc9_ = (param2 - _loc11_.y) / HealingGunEffectsParams.SHAFT_AMPLITUDE_FADE;
            }
            if(_loc9_ > 1)
            {
               _loc9_ = 1;
            }
            _loc14_ = Math.sin(Math.PI * 2 * (_loc13_ + this.wave1Offset) / HealingGunEffectsParams.SHAFT_WAVE1_LENGTH);
            _loc15_ = Math.sin(Math.PI * 2 * (_loc13_ + this.wave2Offset) / HealingGunEffectsParams.SHAFT_WAVE2_LENGTH);
            _loc11_.u = (_loc14_ + _loc15_) * 0.5 * _loc3_ * _loc9_;
            _loc12_.u = 1 + _loc11_.u;
            _loc10_++;
         }
         boundMaxY = param2;
      }
      
      public function clear() : void
      {
         setMaterialToAllFaces(null);
      }
   }
}

