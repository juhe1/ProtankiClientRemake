package alternativa.tanks.models.battle.assault
{
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RayIntersectionData;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleView;
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.models.battle.commonflag.Flag;
   import alternativa.tanks.models.battle.ctf.*;
   import alternativa.tanks.models.battle.gui.markers.PointHudIndicator;
   import flash.utils.Dictionary;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class AssaultHudIndicators implements Renderer
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private static var emptyBase:Class = AssaultHudIndicators_emptyBase;
      
      private static var flagAssault:Class = AssaultHudIndicators_flagAssault;
      
      private static const m:Matrix4 = new Matrix4();
      
      private static const m1:Matrix4 = new Matrix4();
      
      private static const v:Vector3 = new Vector3();
      
      private static const pointPosition:Vector3 = new Vector3();
      
      private static const cameraPosition:Vector3 = new Vector3();
      
      private static const direction:Vector3 = new Vector3();
      
      private static const NEAR_MARKER_DISTANCE:Number = 6600;
      
      private static const FAR_MARKER_DISTANCE:Number = 7000;
      
      private var redMarkers:Dictionary = new Dictionary();
      
      private var redBaseMarkers:Dictionary = new Dictionary();
      
      private var markers:Array = [];
      
      private var camera:Camera3D;
      
      private var localTeam:BattleTeam;
      
      public function AssaultHudIndicators()
      {
         super();
         this.camera = battleService.getBattleScene3D().getCamera();
      }
      
      private static function getPerspectiveScale(param1:Camera3D, param2:Vector3) : Number
      {
         var _loc3_:Number = Math.cos(param1.rotationX);
         var _loc4_:Number = Math.sin(param1.rotationX);
         var _loc5_:Number = Math.cos(param1.rotationY);
         var _loc6_:Number = Math.sin(param1.rotationY);
         var _loc7_:Number = Math.cos(param1.rotationZ);
         var _loc8_:Number = Math.sin(param1.rotationZ);
         var _loc9_:Number = _loc7_ * _loc6_ * _loc3_ + _loc8_ * _loc4_;
         var _loc10_:Number = -_loc7_ * _loc4_ + _loc6_ * _loc8_ * _loc3_;
         var _loc11_:Number = _loc5_ * _loc3_;
         var _loc12_:Number = -_loc9_ * param1.x - _loc10_ * param1.y - _loc11_ * param1.z;
         var _loc13_:Number = param1.view.width * 0.5;
         var _loc14_:Number = param1.view.height * 0.5;
         var _loc15_:Number = Math.sqrt(_loc13_ * _loc13_ + _loc14_ * _loc14_) / Math.tan(param1.fov * 0.5);
         var _loc16_:Number = _loc9_ * param2.x + _loc10_ * param2.y + _loc11_ * param2.z + _loc12_;
         return _loc15_ / _loc16_;
      }
      
      private static function composeObject3DMatrix(param1:Object3D) : Matrix4
      {
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc2_:Number = Math.cos(param1.rotationX);
         var _loc3_:Number = Math.sin(param1.rotationX);
         var _loc4_:Number = Math.cos(param1.rotationY);
         var _loc5_:Number = Math.sin(param1.rotationY);
         var _loc6_:Number = Math.cos(param1.rotationZ);
         var _loc7_:Number = Math.sin(param1.rotationZ);
         var _loc8_:Number = _loc6_ * _loc5_;
         var _loc9_:Number = _loc7_ * _loc5_;
         var _loc10_:Number = _loc4_ * param1.scaleX;
         var _loc11_:Number = _loc3_ * param1.scaleY;
         var _loc12_:Number = _loc2_ * param1.scaleY;
         _loc13_ = _loc2_ * param1.scaleZ;
         _loc14_ = _loc3_ * param1.scaleZ;
         m1.m00 = _loc6_ * _loc10_;
         m1.m01 = _loc8_ * _loc11_ - _loc7_ * _loc12_;
         m1.m02 = _loc8_ * _loc13_ + _loc7_ * _loc14_;
         m1.m03 = param1.x;
         m1.m10 = _loc7_ * _loc10_;
         m1.m11 = _loc9_ * _loc11_ + _loc6_ * _loc12_;
         m1.m12 = _loc9_ * _loc13_ - _loc6_ * _loc14_;
         m1.m13 = param1.y;
         m1.m20 = -_loc5_ * param1.scaleX;
         m1.m21 = _loc4_ * _loc11_;
         m1.m22 = _loc4_ * _loc13_;
         m1.m23 = param1.z;
         return m1;
      }
      
      public function addRedFlag(param1:int, param2:Flag) : void
      {
         var _loc3_:PointHudIndicator = new PointHudIndicator(new flagAssault(),param2,null,new flagAssault());
         this.redMarkers[param1] = _loc3_;
         battleService.getBattleView().addOverlayObject(_loc3_);
         this.markers.push(_loc3_);
      }
      
      public function addRedBase(param1:int, param2:Object3D) : void
      {
         var _loc3_:PointHudIndicator = this.redMarkers[param1];
         var _loc4_:PointHudIndicator = new PointHudIndicator(new emptyBase(),new BaseIndicatorStateProvider(new Vector3(param2.x,param2.y,param2.z),_loc3_));
         _loc4_.visibleToBlue = false;
         this.redBaseMarkers[param1] = _loc4_;
         battleService.getBattleView().addOverlayObject(_loc4_);
         this.markers.push(_loc4_);
      }
      
      public function setLocalTeam(param1:BattleTeam) : void
      {
         this.localTeam = param1;
      }
      
      public function setFlagState(param1:int, param2:int) : void
      {
         this.redMarkers[param1].setState(param2);
      }
      
      public function render(param1:int, param2:int) : void
      {
         var _loc4_:PointHudIndicator = null;
         var _loc5_:PointHudIndicator = null;
         var _loc3_:Matrix4 = this.calculateProjectionMatrix();
         for each(_loc4_ in this.redBaseMarkers)
         {
            this.updateMarker(_loc3_,_loc4_);
         }
         for each(_loc5_ in this.redMarkers)
         {
            this.updateMarker(_loc3_,_loc5_);
         }
         this.sortChildren();
      }
      
      private function sortChildren() : void
      {
         var _loc1_:PointHudIndicator = null;
         this.markers.sortOn("zindex",Array.DESCENDING | Array.NUMERIC);
         for each(_loc1_ in this.markers)
         {
            battleService.getBattleView().addOverlayObject(_loc1_);
         }
      }
      
      private function updateMarker(param1:Matrix4, param2:PointHudIndicator) : void
      {
         var _loc7_:Number = NaN;
         if(!param2.isActive(this.camera) || !param2.visibleFor(this.localTeam))
         {
            param2.visible = false;
            return;
         }
         param2.readPosition3D(v);
         v.transform4(param1);
         this.projectToView(v);
         var _loc3_:Number = 15;
         var _loc4_:Number = this.getMarginY();
         var _loc5_:Boolean = this.isPointInsideViewport(v.x,v.y,_loc3_,_loc4_);
         if(v.z > 0 && _loc5_)
         {
            _loc7_ = this.getPointAlpha(param2);
            if(_loc7_ == 0)
            {
               param2.visible = false;
               param2.alpha = 0;
            }
            else
            {
               param2.visible = true;
               param2.alpha = _loc7_;
            }
         }
         else
         {
            param2.alpha = 1;
            param2.visible = false;
         }
         var _loc6_:BattleView = battleService.getBattleView();
         param2.x = int(v.x + _loc6_.getWidth() / 2 - 12);
         param2.y = int(v.y + _loc6_.getHeight() / 2 - 12);
         param2.zindex = this.getDistanceToCamera(param2);
      }
      
      private function getDistanceToCamera(param1:PointHudIndicator) : Number
      {
         param1.readPosition3D(pointPosition);
         cameraPosition.reset(this.camera.x,this.camera.y,this.camera.z);
         direction.diff(pointPosition,cameraPosition);
         return direction.length();
      }
      
      private function getPointAlpha(param1:PointHudIndicator) : Number
      {
         var _loc2_:Number = NaN;
         param1.readPosition3D(pointPosition);
         cameraPosition.reset(this.camera.x,this.camera.y,this.camera.z);
         direction.diff(pointPosition,cameraPosition);
         var _loc3_:Number = direction.length();
         direction.normalize();
         var _loc4_:RayIntersectionData = battleService.getBattleScene3D().raycast(cameraPosition,direction,battleService.getExcludedObjects3D());
         var _loc5_:Number = pointPosition.distanceTo(cameraPosition);
         if(_loc5_ < NEAR_MARKER_DISTANCE)
         {
            _loc2_ = 0;
         }
         else if(_loc5_ > FAR_MARKER_DISTANCE)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = (_loc5_ - NEAR_MARKER_DISTANCE) / (FAR_MARKER_DISTANCE - NEAR_MARKER_DISTANCE);
         }
         return _loc2_;
      }
      
      private function getMarginY() : int
      {
         switch(battleService.getBattleView().getScreenSize())
         {
            case BattleView.MAX_SCREEN_SIZE:
               return 70;
            case BattleView.MAX_SCREEN_SIZE - 1:
               return 40;
            default:
               return 15;
         }
      }
      
      private function isPointInsideViewport(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:BattleView = battleService.getBattleView();
         var _loc6_:Number = _loc5_.getWidth() / 2 - param3;
         var _loc7_:Number = _loc5_.getHeight() / 2 - param4;
         return param1 >= -_loc6_ && param1 <= _loc6_ && param2 >= -_loc7_ && param2 <= _loc7_;
      }
      
      private function projectToView(param1:Vector3) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1.z > 0.001)
         {
            param1.x = param1.x * this.camera.viewSizeX / param1.z;
            param1.y = param1.y * this.camera.viewSizeY / param1.z;
         }
         else if(param1.z < -0.001)
         {
            param1.x = -param1.x * this.camera.viewSizeX / param1.z;
            param1.y = -param1.y * this.camera.viewSizeY / param1.z;
         }
         else
         {
            _loc2_ = Number(battleService.getBattleView().getDiagonalSquared());
            _loc3_ = Math.sqrt(param1.x * param1.x + param1.y * param1.y);
            param1.x *= _loc2_ / _loc3_;
            param1.y *= _loc2_ / _loc3_;
         }
      }
      
      private function calculateProjectionMatrix() : Matrix4
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc1_:Number = this.camera.viewSizeX / this.camera.focalLength;
         var _loc2_:Number = this.camera.viewSizeY / this.camera.focalLength;
         var _loc3_:Number = Math.cos(this.camera.rotationX);
         var _loc4_:Number = Math.sin(this.camera.rotationX);
         _loc5_ = Math.cos(this.camera.rotationY);
         _loc6_ = Math.sin(this.camera.rotationY);
         _loc7_ = Math.cos(this.camera.rotationZ);
         _loc8_ = Math.sin(this.camera.rotationZ);
         var _loc9_:Number = _loc7_ * _loc6_;
         _loc10_ = _loc8_ * _loc6_;
         var _loc11_:Number = _loc5_ * this.camera.scaleX;
         _loc12_ = _loc4_ * this.camera.scaleY;
         var _loc13_:Number = _loc3_ * this.camera.scaleY;
         _loc14_ = _loc3_ * this.camera.scaleZ;
         var _loc15_:Number = _loc4_ * this.camera.scaleZ;
         m.m00 = _loc7_ * _loc11_ * _loc1_;
         m.m01 = (_loc9_ * _loc12_ - _loc8_ * _loc13_) * _loc2_;
         m.m02 = _loc9_ * _loc14_ + _loc8_ * _loc15_;
         m.m03 = this.camera.x;
         m.m10 = _loc8_ * _loc11_ * _loc1_;
         m.m11 = (_loc10_ * _loc12_ + _loc7_ * _loc13_) * _loc2_;
         m.m12 = _loc10_ * _loc14_ - _loc7_ * _loc15_;
         m.m13 = this.camera.y;
         m.m20 = -_loc6_ * this.camera.scaleX * _loc1_;
         m.m21 = _loc5_ * _loc12_ * _loc2_;
         m.m22 = _loc5_ * _loc14_;
         m.m23 = this.camera.z;
         var _loc16_:Object3D = this.camera;
         while(_loc16_.parent != null)
         {
            _loc16_ = _loc16_.parent;
            m.append(composeObject3DMatrix(_loc16_));
         }
         m.invert();
         return m;
      }
   }
}

