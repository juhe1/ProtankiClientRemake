package alternativa.tanks.models.battle.meteor.nuclear
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.BlendMode;
   
   public class NuclearBangSprite extends PooledObject implements GraphicEffect
   {
      
      internal const SPEED:Number = 90;
      
      private var sprite:Sprite3D;
      
      private var container:Scene3DContainer = null;
      
      private var direction:Vector3 = new Vector3();
      
      private var w:Number = 0;
      
      private var time:Number = 0;
      
      public function NuclearBangSprite(param1:Pool)
      {
         super(param1);
      }
      
      private function initCommon(param1:Vector3, param2:Vector3, param3:Number) : void
      {
         this.sprite = new Sprite3D(NuclearBangEffect.SIZE * param3,NuclearBangEffect.SIZE * param3);
         this.sprite.rotation = -Math.PI / 2 + Math.random() * Math.PI;
         this.sprite.x = param1.x + param2.x;
         this.sprite.y = param1.y + param2.y;
         this.sprite.z = param1.z + param2.z;
         this.sprite.useLight = false;
         this.sprite.useShadowMap = false;
         this.sprite.softAttenuation = 200;
         this.direction.copy(param2).normalize();
         this.w = Math.random() > 0.5 ? 1 : -1;
      }
      
      public function initSmoke(param1:Vector3, param2:Vector3, param3:Number, param4:TextureMaterial) : void
      {
         this.initCommon(param1,param2,param3);
         this.sprite.material = param4;
         this.time = 0;
      }
      
      public function initFlame(param1:Vector3, param2:Vector3, param3:Number, param4:TextureMaterial) : void
      {
         this.initCommon(param1,param2,param3);
         this.sprite.blendMode = BlendMode.ADD;
         this.sprite.material = param4;
         this.time = 0;
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.sprite);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc3_:Number = param1 / 1000;
         this.time += _loc3_;
         var _loc4_:Boolean = false;
         var _loc5_:Number = 1;
         if(this.time <= NuclearBangEffect.KEY1)
         {
            _loc5_ = this.time / NuclearBangEffect.KEY1;
            _loc4_ = true;
         }
         else if(this.time <= NuclearBangEffect.KEY2)
         {
            _loc5_ = 1;
            _loc4_ = true;
         }
         else if(this.time <= NuclearBangEffect.END)
         {
            _loc5_ = 1 - (this.time - NuclearBangEffect.KEY2) / (NuclearBangEffect.END - NuclearBangEffect.KEY2);
            _loc4_ = true;
         }
         this.sprite.x += this.direction.x * _loc3_ * this.SPEED;
         this.sprite.y += this.direction.y * _loc3_ * this.SPEED;
         this.sprite.z += this.direction.z * _loc3_ * this.SPEED * 2.4;
         this.sprite.rotation += this.w * _loc3_ * 0.3;
         this.sprite.alpha = _loc5_;
         return _loc4_ && _loc5_ <= 1;
      }
      
      public function destroy() : void
      {
         if(this.container != null)
         {
            this.container.removeChild(this.sprite);
            this.container = null;
         }
         this.sprite.material = null;
         recycle();
      }
      
      public function kill() : void
      {
         this.destroy();
      }
   }
}

