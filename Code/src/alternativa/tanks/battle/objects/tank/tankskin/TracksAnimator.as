package alternativa.tanks.battle.objects.tank.tankskin
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.objects.tank.*;
   import alternativa.tanks.battle.objects.tank.tankchassis.SuspensionRay;
   import alternativa.tanks.battle.objects.tank.tankchassis.Track;
   import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
   import alternativa.tanks.utils.MathUtils;
   
   public class TracksAnimator
   {
      
      private static const MIN_TRACK_SPEED:Number = 100;
      
      private static const _bodyPointVelocity:Vector3 = new Vector3();
      
      private var chassis:TrackedChassis;
      
      private var skin:TankSkin;
      
      private var maxSpeedSmoother:ValueSmoother;
      
      public function TracksAnimator(param1:TrackedChassis, param2:TankSkin, param3:ValueSmoother)
      {
         super();
         this.chassis = param1;
         this.skin = param2;
         this.maxSpeedSmoother = param3;
      }
      
      public function animate(param1:Number) : void
      {
         this.calculateTracksAnimationSpeed(param1);
         this.skin.updateTracks(param1 * this.chassis.leftTrack.animationSpeed,param1 * this.chassis.rightTrack.animationSpeed);
      }
      
      private function calculateTracksAnimationSpeed(param1:Number) : void
      {
         this.calculateTrackAnimationSpeed(this.chassis.leftTrack,param1);
         this.calculateTrackAnimationSpeed(this.chassis.rightTrack,param1);
      }
      
      private function calculateTrackAnimationSpeed(param1:Track, param2:Number) : void
      {
         if(this.hasCorrectContacts(param1))
         {
            this.animateTrackWithContacts(param1,param2);
         }
         else
         {
            this.animateTrackWithoutContacts(param1,param2);
         }
      }
      
      private function hasCorrectContacts(param1:Track) : Boolean
      {
         return param1.body.baseMatrix.m22 > 0 && param1.numContacts > 0;
      }
      
      private function animateTrackWithContacts(param1:Track, param2:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = this.getTrackSpeed(param1);
         if(this.requiresSynchronizedAnimation(param1,_loc3_))
         {
            param1.animationSpeed = _loc3_;
         }
         else
         {
            _loc4_ = this.getDesiredSpeedCoeff(param1) * MIN_TRACK_SPEED;
            param1.setAnimationSpeed(_loc4_,this.chassis.getAcceleration() * param2);
         }
      }
      
      private function getTrackSpeed(param1:Track) : Number
      {
         var _loc2_:Vector3 = param1.averageSurfaceVelocity;
         var _loc3_:SuspensionRay = param1.rays[param1.numRays >> 1];
         this.getBodyPointVelocity(param1.body,_loc3_.getGlobalOrigin(),_bodyPointVelocity);
         var _loc4_:Number = _bodyPointVelocity.x - _loc2_.x;
         var _loc5_:Number = _bodyPointVelocity.y - _loc2_.y;
         var _loc6_:Number = _bodyPointVelocity.z - _loc2_.z;
         var _loc7_:Matrix3 = param1.body.baseMatrix;
         return _loc4_ * _loc7_.m01 + _loc5_ * _loc7_.m11 + _loc6_ * _loc7_.m21;
      }
      
      private function getBodyPointVelocity(param1:Body, param2:Vector3, param3:Vector3) : void
      {
         var _loc5_:Number = NaN;
         var _loc8_:Vector3 = null;
         var _loc4_:Vector3 = param1.state.position;
         _loc5_ = param2.x - _loc4_.x;
         var _loc6_:Number = param2.y - _loc4_.y;
         var _loc7_:Number = param2.z - _loc4_.z;
         _loc8_ = param1.state.angularVelocity;
         param3.x = _loc8_.y * _loc7_ - _loc8_.z * _loc6_;
         param3.y = _loc8_.z * _loc5_ - _loc8_.x * _loc7_;
         param3.z = _loc8_.x * _loc6_ - _loc8_.y * _loc5_;
         var _loc9_:Vector3 = param1.state.velocity;
         param3.x += _loc9_.x;
         param3.y += _loc9_.y;
         param3.z += _loc9_.z;
      }
      
      private function requiresSynchronizedAnimation(param1:Track, param2:Number) : Boolean
      {
         var _loc3_:Number = this.getDesiredSpeedCoeff(param1);
         return Math.abs(param2) > 0.8 * MIN_TRACK_SPEED || _loc3_ == 0 || MathUtils.numberSign(param2,1) * MathUtils.sign(_loc3_) == -1;
      }
      
      private function getDesiredSpeedCoeff(param1:Track) : Number
      {
         var _loc2_:int = this.chassis.getActualMovementDirection();
         var _loc3_:int = this.chassis.getActualTurnDirection();
         var _loc4_:Number = 0;
         if(_loc2_ == 0)
         {
            _loc4_ = param1.side * _loc3_ * 0.5;
         }
         else if(_loc3_ == 0)
         {
            _loc4_ = _loc2_;
         }
         else
         {
            _loc4_ = _loc2_ * (3 + param1.side * _loc3_) / 4;
         }
         return _loc4_;
      }
      
      private function animateTrackWithoutContacts(param1:Track, param2:Number) : void
      {
         var _loc3_:Number = this.getDesiredSpeedCoeff(param1);
         param1.setAnimationSpeed(_loc3_ * this.maxSpeedSmoother.getTargetValue(),this.chassis.getAcceleration() * param2);
      }
   }
}

