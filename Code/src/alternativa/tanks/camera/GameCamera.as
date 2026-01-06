package alternativa.tanks.camera
{
   import alternativa.engine3d.core.Camera3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.scene3d.CameraFovCalculator;
   
   public class GameCamera extends Camera3D
   {
      
      private static const m:Matrix3 = new Matrix3();
      
      public var position:Vector3 = new Vector3();
      
      public var xAxis:Vector3 = new Vector3();
      
      public var yAxis:Vector3 = new Vector3();
      
      public var zAxis:Vector3 = new Vector3();
      
      public function GameCamera()
      {
         super();
         nearClipping = 40;
         farClipping = 200000;
         z = 10000;
         rotationX = -0.01;
         diagramVerticalMargin = 35;
      }
      
      public function calculateAdditionalData() : void
      {
         var _loc5_:Number = NaN;
         var _loc1_:Number = Math.cos(rotationX);
         var _loc2_:Number = Math.sin(rotationX);
         var _loc3_:Number = Math.cos(rotationY);
         var _loc4_:Number = Math.sin(rotationY);
         _loc5_ = Math.cos(rotationZ);
         var _loc6_:Number = Math.sin(rotationZ);
         var _loc7_:Number = _loc5_ * _loc4_;
         var _loc8_:Number = _loc6_ * _loc4_;
         this.xAxis.x = _loc5_ * _loc3_;
         this.yAxis.x = _loc7_ * _loc2_ - _loc6_ * _loc1_;
         this.zAxis.x = _loc7_ * _loc1_ + _loc6_ * _loc2_;
         this.xAxis.y = _loc6_ * _loc3_;
         this.yAxis.y = _loc8_ * _loc2_ + _loc5_ * _loc1_;
         this.zAxis.y = _loc8_ * _loc1_ - _loc5_ * _loc2_;
         this.xAxis.z = -_loc4_;
         this.yAxis.z = _loc3_ * _loc2_;
         this.zAxis.z = _loc3_ * _loc1_;
         this.position.x = x;
         this.position.y = y;
         this.position.z = z;
      }
      
      public function getGlobalVector(param1:Vector3, param2:Vector3) : void
      {
         m.setRotationMatrix(rotationX,rotationY,rotationZ);
         m.transformVector(param1,param2);
      }
      
      public function getLocalVector(param1:Vector3, param2:Vector3) : void
      {
         m.setRotationMatrix(rotationX,rotationY,rotationZ);
         m.transformVectorInverse(param1,param2);
      }
      
      public function setPosition(param1:Vector3) : void
      {
         x = param1.x;
         y = param1.y;
         z = param1.z;
      }
      
      public function updateFov() : void
      {
         fov = CameraFovCalculator.getCameraFov(view.width,view.height);
      }
   }
}

