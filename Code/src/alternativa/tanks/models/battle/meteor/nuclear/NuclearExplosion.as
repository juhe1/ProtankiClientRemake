package alternativa.tanks.models.battle.meteor.nuclear
{
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Sprite3D;
   import flash.display.BlendMode;
   import flash.geom.Vector3D;
   
   public class NuclearExplosion
   {
      
      private static var flameMaterial:TextureMaterial = null;
      
      private static var smokeMaterial:TextureMaterial = null;
      
      private static var lightMaterial:TextureMaterial = null;
      
      private static var waveMaterial:TextureMaterial = null;
      
      private static const SIZE:Number = 550;
      
      internal static const COUNT1:int = 20;
      
      internal static const RADIUS1:Number = 1000;
      
      internal static const HEIGHT1:Number = 2000;
      
      internal static const COUNT2:int = 15;
      
      internal static const RADIUS2:Number = 850;
      
      internal static const HEIGHT2:Number = HEIGHT1 + SIZE * 0.6;
      
      internal static const COUNT3:int = 11;
      
      internal static const RADIUS3:Number = 650;
      
      internal static const HEIGHT3:Number = HEIGHT2 + SIZE * 0.4;
      
      internal static const COUNT4:int = 7;
      
      internal static const RADIUS4:Number = 290;
      
      internal static const HEIGHT4:Number = HEIGHT3 + SIZE * 0.3;
      
      internal static const COUNT5:int = 12;
      
      internal static const RADIUS5:Number = 800;
      
      internal static const HEIGHT5:Number = HEIGHT1 + SIZE * 0.1;
      
      internal static const COUNT6:int = 2;
      
      internal static const RADIUS6:Number = 50;
      
      internal static const HEIGHT6:Number = HEIGHT1 - SIZE * 0.5;
      
      internal static const COUNT7:int = 3;
      
      internal static const RADIUS7:Number = 120;
      
      internal static const HEIGHT7:Number = HEIGHT6 - SIZE * 0.5;
      
      internal static const COUNT8:int = 4;
      
      internal static const RADIUS8:Number = 200;
      
      internal static const HEIGHT8:Number = HEIGHT7 - SIZE * 0.5;
      
      internal static const COUNT9:int = 4;
      
      internal static const RADIUS9:Number = 160;
      
      internal static const HEIGHT9:Number = HEIGHT8 - SIZE * 0.2;
      
      internal static const COUNT10:int = 3;
      
      internal static const RADIUS10:Number = 50;
      
      internal static const HEIGHT10:Number = HEIGHT9 - SIZE * 0.6;
      
      internal static const COUNT11:int = 6;
      
      internal static const RADIUS11:Number = 150;
      
      internal static const HEIGHT11:Number = HEIGHT10 - SIZE * 0.5;
      
      internal static const COUNT12:int = 9;
      
      internal static const RADIUS12:Number = 450;
      
      internal static const HEIGHT12:Number = HEIGHT11 - SIZE * 0.4;
      
      internal static const COUNT13:int = 10;
      
      internal static const RADIUS13:Number = 550;
      
      internal static const HEIGHT13:Number = HEIGHT12 - SIZE * 0.1;
      
      internal static const KEY1:Number = 10 / 60;
      
      internal static const KEY2:Number = 120 / 60;
      
      internal static const END:Number = 160 / 60;
      
      internal static const SPEED:Number = 90;
      
      internal static const OFFSET:Number = RADIUS1 + SIZE;
      
      private static const vector:Vector3D = new Vector3D();
      
      private var container:Object3DContainer;
      
      private var camera:Camera3D;
      
      private var epicenter:Vector3D = new Vector3D();
      
      private var sprites:Vector.<Sprite3D> = new Vector.<Sprite3D>();
      
      private var directions:Vector.<Vector3D> = new Vector.<Vector3D>();
      
      private var light:Sprite3D = new Sprite3D(5000,5000,lightMaterial);
      
      private var wave:Mesh = new Mesh();
      
      private var time:Number = 0;
      
      public function NuclearExplosion(param1:Object3DContainer, param2:Camera3D, param3:Number, param4:Number, param5:Number)
      {
         super();
         this.container = param1;
         this.camera = param2;
         this.epicenter.x = param3;
         this.epicenter.y = param4;
         this.epicenter.z = param5;
         this.createRound(COUNT1,RADIUS1,HEIGHT1,0.6,0,true);
         this.createRound(COUNT2,RADIUS2,HEIGHT2,0.6,0,true);
         this.createRound(COUNT3,RADIUS3,HEIGHT3,0.6,0,true);
         this.createRound(COUNT4,RADIUS4,HEIGHT4,0.6,0,true);
         this.createRound(COUNT5,RADIUS5,HEIGHT5,0.7,0.4,false);
         this.createRound(COUNT6,RADIUS6,HEIGHT6,0.6,0,true);
         this.createRound(COUNT7,RADIUS7,HEIGHT7,0.6,-0.4,true);
         this.createRound(COUNT8,RADIUS8,HEIGHT8,0.6,0,true);
         this.createRound(COUNT9,RADIUS9,HEIGHT9,0.7,-0.2,false);
         this.createRound(COUNT10,RADIUS10,HEIGHT10,0.6,-0.3,true);
         this.createRound(COUNT11,RADIUS11,HEIGHT11,0.6,0,true);
         this.createRound(COUNT12,RADIUS12,HEIGHT12,0.6,0,true);
         this.createRound(COUNT13,RADIUS13,HEIGHT13,0.7,-0.2,false);
         this.light.useLight = false;
         this.light.useShadowMap = false;
         this.light.blendMode = BlendMode.ADD;
         this.light.softAttenuation = 400;
         param1.addChild(this.light);
         var _loc6_:Number = 2000;
         var _loc7_:Vertex = this.wave.addVertex(-_loc6_,_loc6_,0,0,0);
         var _loc8_:Vertex = this.wave.addVertex(-_loc6_,-_loc6_,0,0,1);
         var _loc9_:Vertex = this.wave.addVertex(_loc6_,-_loc6_,0,1,1);
         var _loc10_:Vertex = this.wave.addVertex(_loc6_,_loc6_,0,1,0);
         this.wave.addQuadFace(_loc7_,_loc8_,_loc9_,_loc10_,waveMaterial);
         this.wave.addQuadFace(_loc7_,_loc10_,_loc9_,_loc8_,waveMaterial);
         this.wave.calculateFacesNormals();
         this.wave.calculateBounds();
         this.wave.useLight = false;
         this.wave.useShadowMap = false;
         this.wave.shadowMapAlphaThreshold = 2;
         this.wave.depthMapAlphaThreshold = 2;
         this.wave.blendMode = BlendMode.ADD;
         this.wave.softAttenuation = 80;
         param1.addChild(this.wave);
      }
      
      private function createRound(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:Boolean) : void
      {
         var _loc9_:Vector3D = null;
         var _loc10_:Number = NaN;
         var _loc11_:Sprite3D = null;
         var _loc7_:Number = Math.PI * 2 / param1;
         var _loc8_:int = 0;
         while(_loc8_ < param1)
         {
            _loc9_ = new Vector3D();
            _loc9_.x = Math.cos(_loc8_ * _loc7_) * param2;
            _loc9_.y = Math.sin(_loc8_ * _loc7_) * param2;
            _loc9_.z = param3 - 100;
            _loc10_ = 1 + Math.random() * param4 + param5;
            _loc11_ = new Sprite3D(SIZE * _loc10_,SIZE * _loc10_);
            _loc11_.rotation = -Math.PI / 2 + Math.random() * Math.PI;
            _loc11_.x = this.epicenter.x + _loc9_.x;
            _loc11_.y = this.epicenter.y + _loc9_.y;
            _loc11_.z = this.epicenter.z + _loc9_.z;
            _loc11_.useLight = false;
            _loc11_.useShadowMap = false;
            if(param6)
            {
               _loc11_.blendMode = BlendMode.ADD;
               _loc11_.material = flameMaterial;
            }
            else
            {
               _loc11_.material = smokeMaterial;
            }
            _loc11_.softAttenuation = 200;
            this.container.addChild(_loc11_);
            this.sprites.push(_loc11_);
            _loc9_.normalize();
            _loc9_.w = Math.random() > 0.5 ? 1 : -1;
            this.directions.push(_loc9_);
            _loc8_++;
         }
      }
      
      public function update(param1:Number) : Boolean
      {
         var _loc10_:Sprite3D = null;
         var _loc11_:Vector3D = null;
         this.time += param1;
         vector.x = this.camera.x - this.epicenter.x;
         vector.y = this.camera.y - this.epicenter.y;
         vector.z = this.camera.z - this.epicenter.z - HEIGHT9;
         vector.normalize();
         this.light.x = this.epicenter.x + vector.x * OFFSET;
         this.light.y = this.epicenter.y + vector.y * OFFSET;
         this.light.z = this.epicenter.z + vector.z * OFFSET + HEIGHT9;
         this.wave.x = this.epicenter.x;
         this.wave.y = this.epicenter.y;
         this.wave.z = this.epicenter.z + 80;
         var _loc2_:Boolean = false;
         var _loc3_:Number = 1;
         if(this.time <= KEY1)
         {
            _loc3_ = this.time / KEY1;
            _loc2_ = true;
         }
         else if(this.time <= KEY2)
         {
            _loc3_ = 1;
            _loc2_ = true;
         }
         else if(this.time <= END)
         {
            _loc3_ = 1 - (this.time - KEY2) / (END - KEY2);
            _loc2_ = true;
         }
         var _loc4_:Number = KEY1 / 3;
         if(this.time <= _loc4_)
         {
            this.light.alpha = this.time / _loc4_;
            this.light.visible = true;
         }
         else if(this.time <= KEY2)
         {
            this.light.alpha = 1 - (this.time - _loc4_) / (KEY2 - _loc4_);
            this.light.visible = true;
         }
         else
         {
            this.light.visible = false;
         }
         var _loc5_:Number = 10 / 60;
         var _loc6_:Number = 20 / 60;
         if(this.time <= _loc4_)
         {
            this.wave.alpha = this.time / _loc5_;
            this.wave.visible = true;
         }
         else if(this.time <= _loc6_)
         {
            this.wave.alpha = 1 - (this.time - _loc5_) / (_loc6_ - _loc5_);
            this.wave.visible = true;
         }
         else
         {
            this.wave.visible = false;
         }
         var _loc7_:Number = param1 * 6;
         this.wave.scaleX += _loc7_;
         this.wave.scaleY += _loc7_;
         var _loc8_:int = int(this.sprites.length);
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            _loc10_ = this.sprites[_loc9_];
            _loc11_ = this.directions[_loc9_];
            _loc10_.x += _loc11_.x * param1 * SPEED;
            _loc10_.y += _loc11_.y * param1 * SPEED;
            _loc10_.z += _loc11_.z * param1 * SPEED * 2.4;
            _loc10_.rotation += _loc11_.w * param1 * 0.3;
            _loc10_.alpha = _loc3_;
            _loc9_++;
         }
         if(_loc3_ > 1)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function destroy() : void
      {
         var _loc1_:int = int(this.sprites.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.container.removeChild(this.sprites[_loc2_]);
            _loc2_++;
         }
         this.container.removeChild(this.light);
         this.container.removeChild(this.wave);
         this.camera = null;
         this.container = null;
      }
   }
}

