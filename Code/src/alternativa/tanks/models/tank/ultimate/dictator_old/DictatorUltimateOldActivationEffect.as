package alternativa.tanks.models.tank.ultimate.dictator_old
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.display.usertitle.UserTitle;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.geom.Vector3D;
   
   public class DictatorUltimateOldActivationEffect extends PooledObject implements GraphicEffect
   {
      
      private var container:Scene3DContainer;
      
      private var sprite:Sprite3D;
      
      private var userTitle:UserTitle;
      
      private var zOffset:int;
      
      private var lifeTime:int;
      
      private var time:int;
      
      private var userTitlePosition:Vector3D;
      
      public function DictatorUltimateOldActivationEffect(param1:Pool)
      {
         super(param1);
         this.sprite = new Sprite3D(0,0);
         this.sprite.useShadowMap = false;
         this.sprite.useLight = false;
         this.sprite.depthTest = false;
      }
      
      public function init(param1:int, param2:int, param3:UserTitle, param4:int, param5:int, param6:TextureMaterial, param7:String) : void
      {
         this.lifeTime = param5;
         this.zOffset = param4;
         this.sprite.width = param1;
         this.sprite.height = param2;
         this.sprite.material = param6;
         this.sprite.softAttenuation = 150;
         this.sprite.depthMapAlphaThreshold = 2;
         this.sprite.shadowMapAlphaThreshold = 2;
         this.sprite.alpha = 1;
         this.sprite.perspectiveScale = true;
         this.sprite.blendMode = param7;
         this.time = 0;
         this.userTitle = param3;
         this.userTitlePosition = new Vector3D();
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = param1;
         param1.addChild(this.sprite);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         this.userTitle.readPosition(this.userTitlePosition);
         this.sprite.x = this.userTitlePosition.x;
         this.sprite.y = this.userTitlePosition.y;
         this.sprite.z = this.userTitlePosition.z + this.zOffset;
         this.time += param1;
         return this.time <= this.lifeTime;
      }
      
      public function destroy() : void
      {
         this.container.removeChild(this.sprite);
         this.container = null;
         recycle();
      }
      
      public function kill() : void
      {
         this.sprite.alpha = 0;
      }
   }
}

