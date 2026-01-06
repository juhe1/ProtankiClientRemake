package alternativa.tanks.models.effects.ultimate
{
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.primitives.GeoSphere;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.GraphicEffect;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.geom.ColorTransform;
   import flash.geom.Vector3D;
   
   public class SparkleSphereEffect extends PooledObject implements GraphicEffect
   {
      
      private static const directionsMany:Vector.<Vector3D> = calculateDirections(2);
      
      private static const directionsFew:Vector.<Vector3D> = calculateDirections(1);
      
      private static const increaseTime:Number = 0.333;
      
      private var directions:Vector.<Vector3D>;
      
      private var sparklesCount:int;
      
      private var targetMesh:Mesh;
      
      private var isConsumer:Boolean;
      
      private var radius:Number;
      
      private var delay:Number;
      
      private var addScale:Number;
      
      private var sparkles:Vector.<SparkleEffect>;
      
      private var time:Number;
      
      private var container:Scene3DContainer;
      
      private var decreaseTime:Number = 1;
      
      public function SparkleSphereEffect(param1:Pool)
      {
         super(param1);
         this.sparkles = new Vector.<SparkleEffect>();
         var _loc2_:int = 0;
         while(_loc2_ < directionsMany.length)
         {
            this.sparkles.push(new SparkleEffect());
            _loc2_++;
         }
      }
      
      private static function calculateDirections(param1:int) : Vector.<Vector3D>
      {
         var _loc2_:int = 0;
         var _loc6_:Vertex = null;
         var _loc7_:Vector3D = null;
         var _loc8_:int = 0;
         var _loc9_:Vector3D = null;
         var _loc3_:Vector.<Vector3D> = new Vector.<Vector3D>();
         var _loc4_:GeoSphere = new GeoSphere(100,param1);
         var _loc5_:Vector.<Vertex> = _loc4_.vertices;
         for each(_loc6_ in _loc5_)
         {
            _loc8_ = int(_loc3_.length);
            _loc2_ = 0;
            while(_loc2_ < _loc8_)
            {
               _loc9_ = _loc3_[_loc2_];
               if(Math.abs(_loc9_.x - _loc6_.x) < 0.1 && Math.abs(_loc9_.y - _loc6_.y) < 0.1 && Math.abs(_loc9_.z - _loc6_.z) < 0.1)
               {
                  break;
               }
               _loc2_++;
            }
            if(_loc2_ == _loc8_)
            {
               _loc3_.push(new Vector3D(_loc6_.x,_loc6_.y,_loc6_.z));
            }
         }
         for each(_loc7_ in _loc3_)
         {
            _loc7_.normalize();
         }
         return _loc3_;
      }
      
      public function init(param1:TextureMaterial, param2:Mesh, param3:Boolean, param4:ColorTransform) : void
      {
         var _loc5_:int = 0;
         var _loc6_:SparkleEffect = null;
         this.time = 0;
         this.targetMesh = param2;
         this.isConsumer = param3;
         this.radius = param3 ? 300 : 700;
         this.delay = param3 ? 0.1 : 0;
         this.decreaseTime = param3 ? 1 / 2 : 1;
         this.addScale = param3 ? 0 : 0.5;
         this.directions = param3 ? directionsFew : directionsMany;
         this.sparklesCount = param3 ? int(directionsFew.length) : int(directionsMany.length);
         _loc5_ = 0;
         while(_loc5_ < directionsMany.length)
         {
            this.sparkles[_loc5_].colorTransform = param4;
            this.sparkles[_loc5_].visible = _loc5_ < this.sparklesCount;
            _loc5_++;
         }
         for each(_loc6_ in this.sparkles)
         {
            _loc6_.init(param1);
         }
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.sparkles.length)
         {
            param1.addChild(this.sparkles[_loc2_]);
            _loc2_++;
         }
         this.container = param1;
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:SparkleEffect = null;
         var _loc7_:Vector3D = null;
         var _loc8_:Number = 100;
         this.time += param1 / 1000;
         if(this.time <= this.delay)
         {
            _loc3_ = 0;
            while(_loc3_ < this.sparklesCount)
            {
               _loc6_ = this.sparkles[_loc3_];
               _loc6_.visible = false;
               _loc3_++;
            }
            return true;
         }
         if(this.time <= this.delay + increaseTime)
         {
            _loc4_ = (this.time - this.delay) / increaseTime;
            _loc4_ = Math.pow(_loc4_,0.25);
            _loc5_ = 1 + _loc4_ * this.addScale;
            _loc3_ = 0;
            while(_loc3_ < this.sparklesCount)
            {
               _loc6_ = this.sparkles[_loc3_];
               _loc7_ = this.directions[_loc3_];
               _loc6_.visible = true;
               _loc6_.x = this.targetMesh.x + _loc7_.x * this.radius * _loc4_;
               _loc6_.y = this.targetMesh.y + _loc7_.y * this.radius * _loc4_;
               _loc6_.z = this.targetMesh.z + _loc7_.z * this.radius * _loc4_ + _loc8_;
               _loc6_.scaleX = _loc5_;
               _loc6_.scaleY = _loc5_;
               _loc6_.scaleZ = _loc5_;
               _loc6_.alpha = _loc4_;
               _loc3_++;
            }
            return true;
         }
         if(this.time <= this.delay + increaseTime + this.decreaseTime)
         {
            _loc4_ = 1 - (this.time - this.delay - increaseTime) / this.decreaseTime;
            _loc4_ = Math.pow(_loc4_,0.3);
            _loc5_ = 1 + _loc4_ * this.addScale;
            _loc3_ = 0;
            while(_loc3_ < this.sparklesCount)
            {
               _loc6_ = this.sparkles[_loc3_];
               _loc7_ = this.directions[_loc3_];
               _loc6_.visible = true;
               _loc6_.x = this.targetMesh.x + _loc7_.x * this.radius * _loc4_;
               _loc6_.y = this.targetMesh.y + _loc7_.y * this.radius * _loc4_;
               _loc6_.z = this.targetMesh.z + _loc7_.z * this.radius * _loc4_ + _loc8_;
               _loc6_.scaleX = _loc5_;
               _loc6_.scaleY = _loc5_;
               _loc6_.scaleZ = _loc5_;
               _loc6_.alpha = _loc4_;
               _loc3_++;
            }
            return true;
         }
         return false;
      }
      
      public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.sparkles.length)
         {
            this.container.removeChild(this.sparkles[_loc1_]);
            _loc1_++;
         }
         this.container = null;
         this.targetMesh = null;
         this.sparkles = null;
      }
      
      public function kill() : void
      {
         this.destroy();
      }
   }
}

