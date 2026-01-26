package alternativa.tanks.models.tank.ultimate.hornet.radar
{
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.RayIntersectionData;
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleView;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.models.battle.gui.markers.PointHudIndicator;
   import alternativa.tanks.models.tank.LocalTankInfoService;
   import alternativa.tanks.models.tank.bosstate.IBossState;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar.BattleUltimateRadarCC;
   import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import alternativa.engine3d.alternativa3d;
   
   use namespace alternativa3d;
   
   public class BattleRadarHudIndicators implements Renderer
   {
      [Inject]
      public static var battleService:BattleService;
      
      [Inject]
      public static var localTankInfoService:LocalTankInfoService;
      
      private static const m:Matrix4 = new Matrix4();
      
      private static const m1:Matrix4 = new Matrix4();
      
      private static const v:Vector3 = new Vector3();
      
      private static const pointPosition:Vector3 = new Vector3();
      
      private static const cameraPosition:Vector3 = new Vector3();
      
      private static const direction:Vector3 = new Vector3();
      
      private static const exclusionDict:Dictionary = new Dictionary();
      
      private var markers:Array = [];
      
      private var markersMap:Dictionary = new Dictionary();
      
      private var camera:Camera3D;
      
      private var battleUltimateRadarCC:BattleUltimateRadarCC;
      
      public function BattleRadarHudIndicators(param1:BattleUltimateRadarCC)
      {
         super();
         this.camera = battleService.getBattleScene3D().getCamera();
         this.battleUltimateRadarCC = param1;
      }
      
      private static function composeObject3DMatrix(param1:Object3D) : Matrix4
      {
         var _loc6_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc2_:Number = Math.cos(param1.rotationX);
         var _loc3_:Number = Math.sin(param1.rotationX);
         var _loc4_:Number = Math.cos(param1.rotationY);
         var _loc5_:Number = Math.sin(param1.rotationY);
         _loc6_ = Math.cos(param1.rotationZ);
         var _loc7_:Number = Math.sin(param1.rotationZ);
         var _loc8_:Number = _loc6_ * _loc5_;
         _loc9_ = _loc7_ * _loc5_;
         _loc10_ = _loc4_ * param1.scaleX;
         _loc11_ = _loc3_ * param1.scaleY;
         var _loc12_:Number = _loc2_ * param1.scaleY;
         _loc13_ = _loc2_ * param1.scaleZ;
         var _loc14_:Number = _loc3_ * param1.scaleZ;
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
      
      public function addTankMarker(param1:Tank) : void
      {
         var _loc2_:PointHudIndicator = null;
         if(this.markersMap[param1] == null)
         {
            _loc2_ = this.createMarker(param1);
            _loc2_.visible = false;
            this.markers.push(_loc2_);
            this.markersMap[param1] = _loc2_;
            battleService.getBattleView().addOverlayObject(_loc2_);
         }
      }
      
      private function createMarker(param1:Tank) : PointHudIndicator
      {
         return new PointHudIndicator(this.getIndicatorBitmap(param1),param1);
      }
      
      public function removeTankMarker(param1:Tank) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PointHudIndicator = this.markersMap[param1];
         if(_loc2_ != null)
         {
            delete this.markersMap[param1];
            battleService.getBattleView().removeOverlayObject(_loc2_);
            _loc3_ = int(this.markers.indexOf(_loc2_));
            if(_loc3_ >= 0)
            {
               this.markers.splice(_loc3_,1);
            }
         }
      }
      
      private function getIndicatorBitmap(param1:Tank) : Bitmap
      {
         switch(param1.teamType)
         {
            case BattleTeam.RED:
               return new Bitmap(this.battleUltimateRadarCC.redTankMarker);
            case BattleTeam.BLUE:
               return new Bitmap(this.battleUltimateRadarCC.blueTankMarker);
            case BattleTeam.NONE:
         }
         return new Bitmap(this.battleUltimateRadarCC.neutralTankMarker);
      }
      
      public function render(param1:int, param2:int) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:PointHudIndicator = null;
         var _loc3_:Matrix4 = this.calculateProjectionMatrix();
         for(_loc4_ in this.markersMap)
         {
            _loc5_ = this.markersMap[_loc4_];
            this.updateMarker(_loc3_,_loc5_,_loc4_);
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
      
      private function updateMarker(param1:Matrix4, param2:PointHudIndicator, param3:Tank) : void
      {
         var _loc8_:Number = NaN;
         if(!param2.isActive(this.camera) || this.getBossRelationRole(param3) == BossRelationRole.BOSS)
         {
            param2.visible = false;
            return;
         }
         param2.readPosition3D(v);
         v.transform4(param1);
         this.projectToView(v);
         var _loc4_:Number = 15;
         var _loc5_:Number = this.getMarginY();
         var _loc6_:Boolean = this.isPointInsideViewport(v.x,v.y,_loc4_,_loc5_);
         if(v.z > 0 && _loc6_)
         {
            _loc8_ = this.getPointAlpha(param2,param3);
            if(_loc8_ == 0)
            {
               param2.visible = false;
               param2.alpha = 0;
            }
            else
            {
               param2.visible = true;
               param2.alpha = _loc8_;
            }
         }
         else
         {
            param2.alpha = 1;
            param2.visible = false;
         }
         var _loc7_:BattleView = battleService.getBattleView();
         param2.x = int(v.x + _loc7_.getWidth() / 2 - 12);
         param2.y = int(v.y + _loc7_.getHeight() / 2 - 12);
         param2.zindex = this.getDistanceToCamera(param2);
      }
      
      private function getBossRelationRole(param1:Tank) : BossRelationRole
      {
         return IBossState(param1.getUser().adapt(IBossState)).role();
      }
      
      private function getDistanceToCamera(param1:PointHudIndicator) : Number
      {
         param1.readPosition3D(pointPosition);
         cameraPosition.reset(this.camera.x,this.camera.y,this.camera.z);
         direction.diff(pointPosition,cameraPosition);
         return direction.length();
      }
      
      private function getPointAlpha(param1:PointHudIndicator, param2:Tank) : Number
      {
         var _loc4_:RayIntersectionData = null;
         param1.readPosition3D(pointPosition);
         cameraPosition.reset(this.camera.x,this.camera.y,this.camera.z);
         direction.diff(pointPosition,cameraPosition);
         direction.normalize();
         var _loc3_:Number = pointPosition.distanceTo(cameraPosition);
         this.fillExclusionDict(param2);
         if(_loc3_ > this.battleUltimateRadarCC.farMarkerDistance)
         {
            return 1;
         }
         _loc4_ = battleService.getBattleScene3D().raycast(cameraPosition,direction,exclusionDict);
         if(_loc4_ != null && _loc4_.time < _loc3_)
         {
            return 1;
         }
         if(_loc3_ < this.battleUltimateRadarCC.nearMarkerDistance)
         {
            return 0;
         }
         return (_loc3_ - this.battleUltimateRadarCC.nearMarkerDistance) / (this.battleUltimateRadarCC.farMarkerDistance - this.battleUltimateRadarCC.nearMarkerDistance);
      }
      
      private function fillExclusionDict(param1:Tank) : void
      {
         var _loc2_:Object = null;
         for(_loc2_ in exclusionDict)
         {
            delete exclusionDict[_loc2_];
         }
         for(_loc2_ in battleService.getExcludedObjects3D())
         {
            exclusionDict[_loc2_] = 1;
         }
         exclusionDict[param1.getTurret3D()] = 1;
         exclusionDict[param1.getHullMesh()] = 1;
         if(localTankInfoService.isLocalTankLoaded())
         {
            exclusionDict[localTankInfoService.getLocalTank().getHullMesh()] = 1;
            exclusionDict[localTankInfoService.getLocalTank().getTurret3D()] = 1;
         }
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
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc1_:Number = this.camera.viewSizeX / this.camera.focalLength;
         var _loc2_:Number = this.camera.viewSizeY / this.camera.focalLength;
         var _loc3_:Number = Math.cos(this.camera.rotationX);
         var _loc4_:Number = Math.sin(this.camera.rotationX);
         var _loc5_:Number = Math.cos(this.camera.rotationY);
         var _loc6_:Number = Math.sin(this.camera.rotationY);
         var _loc7_:Number = Math.cos(this.camera.rotationZ);
         var _loc8_:Number = Math.sin(this.camera.rotationZ);
         var _loc9_:Number = _loc7_ * _loc6_;
         var _loc10_:Number = _loc8_ * _loc6_;
         var _loc11_:Number = _loc5_ * this.camera.scaleX;
         var _loc12_:Number = _loc4_ * this.camera.scaleY;
         _loc13_ = _loc3_ * this.camera.scaleY;
         _loc14_ = _loc3_ * this.camera.scaleZ;
         _loc15_ = _loc4_ * this.camera.scaleZ;
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

