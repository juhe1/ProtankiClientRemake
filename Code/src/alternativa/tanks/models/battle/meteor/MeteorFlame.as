package alternativa.tanks.models.battle.meteor
{
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.sfx.PositionAndRotationProvider;
   import flash.display.BlendMode;
   
   public class MeteorFlame implements GraphicEffect
   {
      
      private var material:TextureMaterial;
      
      private var container:Scene3DContainer;
      
      private var positionAndRotationProvider:PositionAndRotationProvider;
      
      private var flameTime:Number = 0;
      
      private var alive:Boolean = false;
      
      private var fadingOut:Boolean = false;
      
      private var fadeOutTime:Number = 0;
      
      internal const FLAME_SPRITE_SIZE:Number = 512;
      
      internal const FLAMES_COUNT:Number = 24;
      
      internal const FLAME_LOOP:Number = 0.8;
      
      internal const FADE_OUT_DURATION_COEFF:Number = 0.5;
      
      private var meteorPosition:Vector3;
      
      private var meteorDirection:Vector3;
      
      private var flames:Vector.<Sprite3D>;
      
      public function MeteorFlame(param1:TextureMaterial, param2:PositionAndRotationProvider)
      {
         var _loc4_:Sprite3D = null;
         this.meteorPosition = new Vector3();
         this.meteorDirection = new Vector3();
         super();
         this.material = param1;
         this.positionAndRotationProvider = param2;
         this.flames = new Vector.<Sprite3D>();
         var _loc3_:int = 0;
         while(_loc3_ < this.FLAMES_COUNT)
         {
            _loc4_ = new Sprite3D(this.FLAME_SPRITE_SIZE,this.FLAME_SPRITE_SIZE,param1);
            _loc4_.blendMode = BlendMode.ADD;
            this.flames.push(_loc4_);
            _loc3_++;
         }
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         var _loc2_:Sprite3D = null;
         this.container = param1;
         this.alive = true;
         this.fadingOut = false;
         this.flameTime = 0;
         for each(_loc2_ in this.flames)
         {
            param1.addChild(_loc2_);
         }
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         this.positionAndRotationProvider.readPositionAndRotation(this.meteorPosition,this.meteorDirection);
         this.meteorPosition.addScaled(-1700,this.meteorDirection);
         this.update(param1 / 1000,this.meteorPosition,this.meteorDirection);
         return this.alive;
      }
      
      private function update(param1:Number, param2:Vector3, param3:Vector3) : void
      {
         var _loc5_:Sprite3D = null;
         this.flameTime += param1;
         var _loc4_:int = 0;
         while(_loc4_ < this.flames.length)
         {
            _loc5_ = this.flames[_loc4_];
            this.updateFlame(_loc5_,this.flameTime + _loc4_ * this.FLAME_LOOP / this.FLAMES_COUNT,param2,param3);
            _loc4_++;
         }
      }
      
      private function updateFlame(param1:Sprite3D, param2:Number, param3:Vector3, param4:Vector3) : void
      {
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc5_:Number = 5 / 60;
         var _loc6_:Number = this.FLAME_LOOP;
         var _loc7_:Number = 0.5;
         var _loc8_:Number = 0.8;
         var _loc9_:Number = 0.2;
         var _loc10_:Number = 20;
         var _loc11_:Number = 300;
         var _loc12_:Number = 3000;
         var _loc13_:Number = 0.6;
         var _loc14_:Number = 1;
         var _loc15_:Number = 0;
         if(!this.fadingOut)
         {
            _loc20_ = param2 % _loc6_;
         }
         else
         {
            _loc20_ = Math.min((param2 - this.fadeOutTime) / this.FADE_OUT_DURATION_COEFF,this.FLAME_LOOP / this.FADE_OUT_DURATION_COEFF);
         }
         if(_loc20_ <= _loc5_)
         {
            _loc16_ = _loc20_ / _loc5_;
            _loc17_ = _loc7_ + (_loc8_ - _loc7_) * _loc16_;
            _loc18_ = _loc10_ + (_loc11_ - _loc10_) * _loc16_;
            _loc19_ = _loc13_ + (_loc14_ - _loc13_) * _loc16_;
         }
         else
         {
            _loc16_ = (_loc20_ - _loc5_) / (_loc6_ - _loc5_);
            _loc17_ = _loc8_ + (_loc9_ - _loc8_) * _loc16_;
            _loc18_ = _loc11_ + (_loc12_ - _loc11_) * _loc16_;
            _loc19_ = _loc14_ + (_loc15_ - _loc14_) * _loc16_;
         }
         param1.scaleX = _loc17_;
         param1.scaleY = _loc17_;
         param1.scaleZ = _loc17_;
         param1.x = param3.x - param4.x * _loc18_;
         param1.y = param3.y - param4.y * _loc18_;
         param1.z = param3.z - param4.z * _loc18_;
         param1.alpha = _loc19_;
      }
      
      public function destroy() : void
      {
         var _loc1_:Sprite3D = null;
         if(this.container != null)
         {
            for each(_loc1_ in this.flames)
            {
               this.container.removeChild(_loc1_);
            }
            this.container = null;
         }
      }
      
      public function kill() : void
      {
         this.alive = false;
      }
      
      public function fadeOut() : void
      {
         this.fadingOut = true;
         this.fadeOutTime = this.flameTime;
      }
   }
}

