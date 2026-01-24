package alternativa.tanks.models.battle.meteor
{
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.engine3d.EffectsMaterialRegistry;
   import flash.utils.Dictionary;
   import platform.client.fp10.core.model.ObjectLoadPostListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import projects.tanks.client.battlefield.models.battle.battlefield.meteors.IMeteorStormModelBase;
   import projects.tanks.client.battlefield.models.battle.battlefield.meteors.MeteorDescriptor;
   import projects.tanks.client.battlefield.models.battle.battlefield.meteors.MeteorStormModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   [ModelInfo]
   public class MeteorStormModel extends MeteorStormModelBase implements IMeteorStormModelBase, ObjectUnloadListener, ObjectLoadPostListener
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      [Inject] // added
      public static var effectsMaterialRegistry:EffectsMaterialRegistry;
      
      private static const NUM_LOOPS:int = 100000;
      
      internal var meteorSFXDataPool:Vector.<MeteorSFXData> = new Vector.<MeteorSFXData>();
      
      internal var meteors:Dictionary = new Dictionary();
      
      public function MeteorStormModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function meteorNotification() : void
      {
         var _loc1_:MeteorSFXData = this.createSFXData();
         this.meteorSFXDataPool.push(_loc1_);
         _loc1_.meteorDistantSound.play(0,NUM_LOOPS);
      }
      
      private function createSFXData() : MeteorSFXData
      {
         return new MeteorSFXData(getInitParam(),effectsMaterialRegistry);
      }
      
      [Obfuscation(rename="false")]
      public function spawnMeteor(param1:Vector3d, param2:Vector3d, param3:int) : void
      {
         this.spawnMeteorImpl(param1,param2,param3,0);
      }
      
      public function objectUnloaded() : void
      {
         var _loc1_:MeteorSFXData = null;
         for each(_loc1_ in this.meteorSFXDataPool)
         {
            _loc1_.meteorDistantSound.stop();
            _loc1_.nuclearBangSound.stop();
            _loc1_.meteorArrivingSound.stop();
         }
         this.meteorSFXDataPool.length = 0;
         this.meteors = new Dictionary();
      }
      
      public function objectLoadedPost() : void
      {
         var _loc1_:MeteorDescriptor = null;
         for each(_loc1_ in getInitParam().currentMeteors)
         {
            this.spawnMeteorImpl(_loc1_.upperPosition,_loc1_.groundPosition,_loc1_.timeToFlyMs,_loc1_.lifeTimeMs);
         }
      }
      
      private function spawnMeteorImpl(param1:Vector3d, param2:Vector3d, param3:int, param4:int) : void
      {
         var _loc5_:MeteorSFXData = this.createOrPopSFXData();
         var _loc6_:Meteor = new Meteor(battleService.getObjectPool(),effectsMaterialRegistry,BattleUtils.getVector3(param1),BattleUtils.getVector3(param2),BattleUtils.getVector3(param2),param3,_loc5_);
         _loc6_.setTime(param4);
         _loc6_.addToBattle(battleService.getBattleScene3D(),battleService.getBattleRunner(),this.onMeteorFinished);
         this.meteors[_loc6_] = null;
      }
      
      private function onMeteorFinished(param1:Meteor) : void
      {
         delete this.meteors[param1];
      }
      
      private function createOrPopSFXData() : MeteorSFXData
      {
         if(this.meteorSFXDataPool.length == 0)
         {
            return this.createSFXData();
         }
         return this.meteorSFXDataPool.pop();
      }
   }
}

