package alternativa.tanks.models.weapon.artillery.sfx
{
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.engine3d.AnimatedSprite3D;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.BlendMode;
   
   public class ArtilleryFlame extends PooledObject implements GraphicEffect
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private const LIFE_TIME:Number = 1;
      
      private var flame:Sprite3D;
      
      private var smoke1:AnimatedSprite3D;
      
      private var smoke2:AnimatedSprite3D;
      
      private var container:Scene3DContainer;
      
      private var time:Number;
      
      private var origin:Vector3;
      
      private var direction:Vector3;
      
      private var front:Boolean;
      
      private var stream:Mesh;
      
      public function ArtilleryFlame(param1:Pool)
      {
         super(param1);
         this.flame = new Sprite3D(300,300);
         this.smoke1 = new AnimatedSprite3D(300,300);
         this.smoke2 = new AnimatedSprite3D(300,300);
         this.stream = new Mesh();
      }
      
      public function init(param1:Vector3, param2:Vector3, param3:ArtillerySfxData, param4:Boolean = false) : void
      {
         this.origin = param1.clone();
         this.direction = param2.clone();
         this.front = param4;
         this.flame.material = param3.flame;
         this.flame.rotation = Math.random() * Math.PI * 2;
         this.flame.blendMode = BlendMode.ADD;
         this.createSmoke(param3.smoke);
         this.createStream(param3.stream);
         this.time = param4 ? -3 / 60 : 0;
         battleService.addGraphicEffect(this);
      }
      
      private function createStream(param1:TextureMaterial) : void
      {
         var _loc2_:Vertex = null;
         var _loc3_:Vertex = null;
         var _loc4_:Vertex = null;
         var _loc5_:Vertex = null;
         if(this.stream.faces.length == 0)
         {
            _loc2_ = this.stream.addVertex(-40,320,0,0,0);
            _loc3_ = this.stream.addVertex(-40,0,0,0,1);
            _loc4_ = this.stream.addVertex(40,0,0,1,1);
            _loc5_ = this.stream.addVertex(40,320,0,1,0);
            this.stream.addQuadFace(_loc2_,_loc3_,_loc4_,_loc5_,param1);
            this.stream.addQuadFace(_loc5_,_loc4_,_loc3_,_loc2_,param1);
            this.stream.calculateFacesNormals();
            this.stream.calculateBounds();
            this.stream.alpha = 0.5;
            this.stream.blendMode = BlendMode.ADD;
         }
      }
      
      private function createSmoke(param1:TextureAnimation) : void
      {
         this.smoke1.setAnimationData(param1);
         this.smoke2.setAnimationData(param1);
         this.smoke1.rotation = Math.random() * Math.PI * 2;
         this.smoke2.rotation = Math.random() * Math.PI * 2;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.flame);
         param1.addChild(this.smoke1);
         param1.addChild(this.smoke2);
         param1.addChild(this.stream);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this.time += param1 / 1000;
         if(this.time > this.LIFE_TIME)
         {
            this.container.removeChild(this.flame);
            this.container.removeChild(this.smoke1);
            this.container.removeChild(this.smoke2);
            this.container.removeChild(this.stream);
            this.container = null;
            return false;
         }
         var _loc7_:Number = 2 / 60;
         var _loc8_:Number = 6 / 60;
         if(this.front && this.time >= _loc7_ && this.time < _loc8_)
         {
            _loc3_ = (this.time - _loc7_) / (_loc8_ - _loc7_);
            _loc5_ = 200 * _loc3_;
            this.stream.x = this.origin.x + this.direction.x * _loc5_;
            this.stream.y = this.origin.y + this.direction.y * _loc5_;
            this.stream.z = this.origin.z + this.direction.z * _loc5_;
            this.stream.scaleY = 1 + _loc3_;
            this.stream.rotationX = Math.atan2(this.direction.z,Math.sqrt(this.direction.x * this.direction.x + this.direction.y * this.direction.y));
            this.stream.rotationY = 0;
            this.stream.rotationZ = -Math.atan2(this.direction.x,this.direction.y);
            this.stream.visible = true;
         }
         else
         {
            this.stream.visible = false;
         }
         var _loc9_:Number = 0;
         var _loc10_:Number = 4 / 60;
         var _loc11_:Number = 12 / 60;
         var _loc12_:Number = 0.4;
         var _loc13_:Number = 0.8;
         var _loc14_:Number = 1.8;
         var _loc15_:Number = 20;
         var _loc16_:Number = 170;
         var _loc17_:Number = 300;
         var _loc18_:Number = 0.24;
         var _loc19_:Number = 1;
         var _loc20_:Number = 0;
         if(this.time < _loc9_)
         {
            this.flame.visible = false;
         }
         else if(this.time < _loc11_)
         {
            if(this.time <= _loc10_)
            {
               _loc3_ = this.time / _loc10_;
               _loc4_ = _loc12_ + (_loc13_ - _loc12_) * _loc3_;
               _loc5_ = _loc15_ + (_loc16_ - _loc15_) * _loc3_;
               _loc6_ = _loc18_ + (_loc19_ - _loc18_) * _loc3_;
            }
            else
            {
               _loc3_ = (this.time - _loc10_) / (_loc11_ - _loc10_);
               _loc4_ = _loc13_ + (_loc14_ - _loc13_) * _loc3_;
               _loc5_ = _loc16_ + (_loc17_ - _loc16_) * _loc3_;
               _loc6_ = _loc19_ + (_loc20_ - _loc19_) * _loc3_;
            }
            this.flame.scaleX = _loc4_;
            this.flame.scaleY = _loc4_;
            this.flame.scaleZ = _loc4_;
            this.flame.x = this.origin.x + this.direction.x * _loc5_;
            this.flame.y = this.origin.y + this.direction.y * _loc5_;
            this.flame.z = this.origin.z + this.direction.z * _loc5_;
            this.flame.alpha = _loc6_;
            this.flame.visible = true;
         }
         else
         {
            this.flame.visible = false;
         }
         var _loc21_:Number = 50 / 60;
         if(this.time < _loc9_)
         {
            this.smoke1.visible = false;
            this.smoke2.visible = false;
         }
         else if(this.time < _loc21_)
         {
            _loc3_ = this.time / _loc21_;
            _loc3_ = Math.pow(_loc3_,1 / 3);
            _loc4_ = _loc12_ + (_loc14_ - _loc12_) * _loc3_;
            _loc5_ = 350 * _loc3_;
            _loc6_ = 1 - _loc3_;
            this.smoke1.scaleX = _loc4_;
            this.smoke1.scaleY = _loc4_;
            this.smoke1.scaleZ = _loc4_;
            this.smoke1.x = this.origin.x + this.direction.x * _loc5_;
            this.smoke1.y = this.origin.y + this.direction.y * _loc5_;
            this.smoke1.z = this.origin.z + this.direction.z * _loc5_;
            this.smoke1.alpha = _loc6_;
            this.smoke1.visible = true;
            this.smoke1.update(param1);
            _loc4_ = _loc12_ + (_loc14_ * 0.7 - _loc12_) * _loc3_;
            _loc5_ = 210 * _loc3_;
            _loc6_ = 1 - _loc3_;
            this.smoke2.scaleX = _loc4_;
            this.smoke2.scaleY = _loc4_;
            this.smoke2.scaleZ = _loc4_;
            this.smoke2.x = this.origin.x + this.direction.x * _loc5_;
            this.smoke2.y = this.origin.y + this.direction.y * _loc5_;
            this.smoke2.z = this.origin.z + this.direction.z * _loc5_;
            this.smoke2.alpha = _loc6_;
            this.smoke2.visible = true;
            this.smoke2.update(param1);
         }
         else
         {
            this.smoke1.visible = false;
            this.smoke2.visible = false;
         }
         this.smoke2.update(param1);
         return true;
      }
      
      public function destroy() : void
      {
         if(Boolean(this.container))
         {
            this.container.removeChild(this.flame);
            this.container.removeChild(this.smoke1);
            this.container.removeChild(this.smoke2);
            this.container.removeChild(this.stream);
         }
         this.container = null;
         this.flame.material = null;
         this.smoke1.material = null;
         this.smoke2.material = null;
         recycle();
      }
      
      public function kill() : void
      {
         this.flame.alpha = 0;
         this.smoke1.alpha = 0;
         this.smoke2.alpha = 0;
      }
   }
}

