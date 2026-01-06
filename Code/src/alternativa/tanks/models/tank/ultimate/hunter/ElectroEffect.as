package alternativa.tanks.models.tank.ultimate.hunter
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.BlendMode;
   import flash.geom.Vector3D;
   
   public class ElectroEffect extends PooledObject implements GraphicEffect
   {
      
      private static const SIZE:int = 600;
      
      public static const MID:Number = 4 / 60;
      
      public static const END:Number = 10 / 60;
      
      public static const OFFSET:Number = 150;
      
      private static const vector:Vector3D = new Vector3D();
      
      private var container:Scene3DContainer;
      
      private var target:Object3D;
      
      private var repeatTimes:uint;
      
      private var sprite:Sprite3D;
      
      private var time:Number;
      
      private var counter:uint;
      
      public function ElectroEffect(param1:Pool)
      {
         super(param1);
         this.sprite = new Sprite3D(SIZE,SIZE);
         this.sprite.rotation = Math.random() * Math.PI * 2;
         this.sprite.useLight = false;
         this.sprite.useShadowMap = false;
         this.sprite.blendMode = BlendMode.ADD;
         this.sprite.softAttenuation = 20;
      }
      
      public function init(param1:TextureMaterial, param2:Object3D, param3:uint) : *
      {
         this.target = param2;
         this.repeatTimes = param3;
         this.time = 0;
         this.counter = 0;
         this.sprite.material = param1;
         this.sprite.topLeftU = 0;
         this.sprite.bottomRightU = 0.5;
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
         vector.x = param2.x - this.target.x;
         vector.y = param2.y - this.target.y;
         vector.z = param2.z - this.target.z + 50;
         vector.normalize();
         this.sprite.x = this.target.x + vector.x * OFFSET;
         this.sprite.y = this.target.y + vector.y * OFFSET;
         this.sprite.z = this.target.z + vector.z * OFFSET + 100;
         if(this.time <= MID)
         {
            this.sprite.alpha = this.time / MID;
            return true;
         }
         if(this.time <= END)
         {
            this.sprite.alpha = 1 - (this.time - MID) / (END - MID);
            return true;
         }
         if(++this.counter < this.repeatTimes)
         {
            this.sprite.rotation = Math.random() * Math.PI * 2;
            this.sprite.topLeftU += 0.5;
            this.sprite.bottomRightU += 0.5;
            this.time = 0;
            return true;
         }
         return false;
      }
      
      public function destroy() : void
      {
         this.container.removeChild(this.sprite);
         this.container = null;
         this.sprite.material = null;
         this.target = null;
         recycle();
      }
      
      public function kill() : void
      {
         this.sprite.alpha = 0;
      }
   }
}

