package alternativa.tanks.sfx.damageindicator
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import controls.Label;
   import filters.Filters;
   import flash.display.BitmapData;
   
   public class DamageIndicatorEffect extends PooledObject implements GraphicEffect
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const POP_HEIGHT:Number = 100;
      
      private static const REST_HEIGHT:Number = 250;
      
      private static const MAX_HEIGHT:Number = 300;
      
      private static const POP_SPEED:Number = 1000;
      
      private static const REST_SPEED:Number = 100;
      
      private static var label:Label = new Label();
      
      private var sprite:Sprite3D;
      
      private var time:int;
      
      private var z:Number;
      
      private var origin:Vector3 = new Vector3();
      
      private var container:Scene3DContainer;
      
      private var variationX:Number;
      
      private var variationY:Number;
      
      public function DamageIndicatorEffect(param1:Pool)
      {
         super(param1);
         this.sprite = new Sprite3D(0,0);
         this.sprite.perspectiveScale = false;
         this.sprite.material = new TextureMaterial(null,false,false);
         this.sprite.useShadowMap = false;
         this.sprite.useLight = false;
         this.sprite.depthTest = false;
         label.size = 16;
         label.filters = Filters.SHADOW_FILTERS;
      }
      
      public static function start(param1:Vector3, param2:uint, param3:int) : void
      {
         var _loc4_:DamageIndicatorEffect = DamageIndicatorEffect(battleService.getObjectPool().getObject(DamageIndicatorEffect));
         _loc4_.init(param1,param2,param3);
         battleService.getBattleScene3D().addGraphicEffect(_loc4_);
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         this.container = battleService.getBattleScene3D().getFrontContainer();
         this.container.addChild(this.sprite);
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         this.sprite.x = this.origin.x + this.z * this.variationX;
         this.sprite.y = this.origin.y + this.z * this.variationY;
         this.sprite.z = this.origin.z + this.z;
         this.time += param1;
         var _loc3_:Number = this.z < POP_HEIGHT ? POP_SPEED : REST_SPEED;
         this.z += _loc3_ * param1 * 0.001;
         if(this.z < REST_HEIGHT)
         {
            this.sprite.alpha = 1;
         }
         else
         {
            this.sprite.alpha = (MAX_HEIGHT - this.z) / (MAX_HEIGHT - REST_HEIGHT);
            if(this.sprite.alpha < 0)
            {
               this.sprite.alpha = 0;
               return false;
            }
         }
         return true;
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
      
      private function init(param1:Vector3, param2:uint, param3:int) : void
      {
         this.origin.copy(param1);
         this.time = 0;
         this.z = 0;
         this.variationX = Math.random() - 0.5;
         this.variationY = Math.random() - 0.5;
         label.text = param3.toString();
         label.color = param2;
         var _loc4_:BitmapData = new BitmapData(60,20,true,0);
         _loc4_.draw(label);
         TextureMaterial(this.sprite.material).texture = _loc4_;
         this.sprite.width = _loc4_.width;
         this.sprite.height = _loc4_.height;
         this.sprite.calculateBounds();
      }
   }
}

