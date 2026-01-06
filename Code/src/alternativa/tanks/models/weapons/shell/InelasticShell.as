package alternativa.tanks.models.weapons.shell
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.models.weapon.shared.MarginalCollider;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.utils.objectpool.Pool;
   import flash.errors.IllegalOperationError;
   
   public class InelasticShell extends Shell
   {
      
      protected static const _rayCastDirection:Vector3 = new Vector3();
      
      public function InelasticShell(param1:Pool)
      {
         super(param1);
      }
      
      override protected function update(param1:Number) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:Body = null;
         var _loc7_:Vector3 = null;
         this.updatePosition(param1);
         _rayCastDirection.diff(currPosition,prevPosition);
         var _loc2_:Number = _rayCastDirection.length();
         _rayCastDirection.normalize();
         var _loc3_:CollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         if(_loc3_.raycast(prevPosition,_rayCastDirection,CollisionGroup.WEAPON,_loc2_,this,_rayHit))
         {
            _loc5_ = BattleUtils.isTankBody(_rayHit.shape.body) && !MarginalCollider.segmentWithStaticIntersection(prevPosition,_rayHit.position);
            _hitPoint.copy(_rayHit.position);
            if(_loc5_)
            {
               _loc6_ = _rayHit.shape.body;
            }
            else
            {
               _loc6_ = null;
               _hitPoint.subtract(_rayCastDirection);
            }
            processHit(_loc6_,_hitPoint,_rayCastDirection,_loc2_);
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < getNumRadialRays())
         {
            _loc7_ = radialPoints[_loc4_];
            if(_loc3_.raycast(_loc7_,_rayCastDirection,CollisionGroup.WEAPON,_loc2_,this,_rayHit))
            {
               if(BattleUtils.isTankBody(_rayHit.shape.body))
               {
                  if(!MarginalCollider.segmentWithStaticIntersection(prevPosition,_rayHit.position))
                  {
                     _hitPoint.copy(prevPosition).addScaled(_rayHit.t,_rayCastDirection);
                     processHit(_rayHit.shape.body,_hitPoint,_rayCastDirection,_loc2_);
                     return;
                  }
               }
            }
            _loc7_.addScaled(_loc2_,_rayCastDirection);
            _loc4_++;
         }
         shellStates.updateState(currPosition,flightDirection);
         this.updateTotalDistance(param1);
         if(this.isFlightFinished())
         {
            this.handleFlightFinish();
         }
      }
      
      override protected function processHitImpl(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:int) : void
      {
         shellStates.updateState(param2,param3,param5);
      }
      
      protected function updateTotalDistance(param1:Number) : void
      {
         totalDistance += param1 * this.getSpeed();
      }
      
      protected function handleFlightFinish() : void
      {
         destroy();
      }
      
      protected function isFlightFinished() : Boolean
      {
         return totalDistance > this.getMaxDistance();
      }
      
      protected function getMaxDistance() : Number
      {
         return Number.MAX_VALUE;
      }
      
      protected function getSpeed() : Number
      {
         throw new IllegalOperationError();
      }
      
      protected function updatePosition(param1:Number) : void
      {
         prevPosition.copy(currPosition);
         currPosition.addScaled(this.getSpeed() * param1,flightDirection);
      }
   }
}

