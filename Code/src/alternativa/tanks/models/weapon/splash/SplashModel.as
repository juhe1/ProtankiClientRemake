package alternativa.tanks.models.weapon.splash
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.weapon.WeaponConst;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.physics.TankBody;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.battlefield.models.tankparts.weapon.splash.ISplashModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashCC;
   import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashModelBase;
   
   [ModelInfo]
   public class SplashModel extends SplashModelBase implements ISplashModelBase, ObjectLoadListener, Splash
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      private static const vectorToTarget:Vector3 = new Vector3();
      
      private static const forceDirection:Vector3 = new Vector3();
      
      private static const vector:Vector3 = new Vector3();
      
      private static const rayHit:RayHit = new RayHit();
      
      public function SplashModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc1_:SplashCC = getInitParam();
         var _loc2_:SplashParams = null;
         if(_loc1_ != null)
         {
            _loc2_ = new SplashParams(BattleUtils.toClientScale(_loc1_.radiusOfMaxSplashDamage),BattleUtils.toClientScale(_loc1_.splashDamageRadius),_loc1_.minSplashDamagePercent,_loc1_.impactForce * WeaponConst.BASE_IMPACT_FORCE.getNumber());
         }
         putData(SplashParams,_loc2_);
      }
      
      public function applySplashForce(param1:Vector3, param2:Number, param3:Body) : Boolean
      {
         var _loc7_:TankBody = null;
         var _loc8_:Body = null;
         var _loc9_:Tank = null;
         var _loc10_:Vector3 = null;
         var _loc11_:Number = NaN;
         var _loc4_:SplashParams = SplashParams(getData(SplashParams));
         if(_loc4_ == null)
         {
            return false;
         }
         var _loc5_:Number = _loc4_.getSplashRadius() * _loc4_.getSplashRadius();
         var _loc6_:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         for each(_loc7_ in _loc6_.getTankBodies())
         {
            _loc8_ = _loc7_.body;
            _loc9_ = _loc8_.tank;
            if(_loc9_.state == ClientTankState.ACTIVE && _loc8_ != param3)
            {
               _loc10_ = _loc9_.getBody().state.position;
               vectorToTarget.diff(_loc10_,param1);
               _loc11_ = vectorToTarget.lengthSqr();
               if(_loc11_ <= _loc5_)
               {
                  if(!this.isTankOccluded(_loc9_,param1))
                  {
                     forceDirection.copy(vectorToTarget);
                     forceDirection.normalize();
                     _loc9_.applyWeaponHit(_loc9_.getBody().state.position,forceDirection,param2 * _loc4_.getImpactForce(Math.sqrt(_loc11_)));
                  }
               }
            }
         }
         return true;
      }
      
      private function isTankOccluded(param1:Tank, param2:Vector3) : Boolean
      {
         var _loc3_:Body = param1.getBody();
         var _loc4_:Number = 0.75 * param1.getHalfLength();
         return this.isPointOccluded(param2,_loc3_,0) && this.isPointOccluded(param2,_loc3_,-_loc4_) && this.isPointOccluded(param2,_loc3_,_loc4_);
      }
      
      private function isPointOccluded(param1:Vector3, param2:Body, param3:Number) : Boolean
      {
         vector.reset(0,param3,0);
         vector.transform3(param2.baseMatrix);
         vector.add(param2.state.position);
         vector.subtract(param1);
         var _loc4_:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
         return _loc4_.raycastStatic(param1,vector,CollisionGroup.STATIC,1,null,rayHit);
      }
   }
}

