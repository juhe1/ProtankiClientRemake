package alternativa.tanks.models.tank.rankup
{
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.tank.ITankModel;
   import alternativa.tanks.sfx.LevelUpEffectFactory;
   import alternativa.tanks.sfx.Sound3D;
   import alternativa.tanks.sfx.Sound3DEffect;
   import flash.media.Sound;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.ObjectUnloadListener;
   import platform.client.fp10.core.resource.types.SoundResource;
   import projects.tanks.client.battlefield.models.tankparts.armor.rankup.ITankRankUpEffectModelBase;
   import projects.tanks.client.battlefield.models.tankparts.armor.rankup.TankRankUpEffectModelBase;
   
   [ModelInfo]
   public class TankRankUpEffectModel extends TankRankUpEffectModelBase implements ITankRankUpEffectModelBase, ObjectLoadListener, ObjectUnloadListener, ITankRankUpEffectModel
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private var listener:RankChangeListener;
      
      private var usersCount:int;
      
      public function TankRankUpEffectModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         if(this.listener == null)
         {
            this.listener = new RankChangeListener(object.space);
         }
         ++this.usersCount;
      }
      
      [Obfuscation(rename="false")]
      public function objectUnloaded() : void
      {
         --this.usersCount;
         if(this.usersCount == 0)
         {
            this.listener.close();
            this.listener = null;
         }
      }
      
      public function showRankUpEffect(param1:int) : void
      {
         var _loc2_:ITankModel = ITankModel(object.adapt(ITankModel));
         var _loc3_:Tank = _loc2_.getTank();
         if(_loc3_.state == ClientTankState.DEAD)
         {
            this.scheduleRankUpEffect(param1);
         }
         else
         {
            this.showEffect(_loc3_,param1);
         }
      }
      
      private function scheduleRankUpEffect(param1:int) : void
      {
         var _loc2_:ScheduledTankRankChangeEffect = new ScheduledTankRankChangeEffect(object,param1);
         putData(ScheduledTankRankChangeEffect,_loc2_);
      }
      
      private function showEffect(param1:Tank, param2:int) : void
      {
         var _loc3_:LevelUpEffectFactory = new LevelUpEffectFactory();
         _loc3_.createEffect(param1,param2);
         this.createSoundEffect(param1);
      }
      
      private function createSoundEffect(param1:Tank) : void
      {
         var _loc3_:Sound = null;
         var _loc4_:Sound3D = null;
         var _loc5_:Body = null;
         var _loc6_:Vector3 = null;
         var _loc7_:Sound3DEffect = null;
         var _loc2_:SoundResource = getInitParam().rankUpSound;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.sound;
            _loc4_ = Sound3D.create(_loc3_);
            _loc5_ = param1.getBody();
            _loc6_ = _loc5_.state.position.clone();
            _loc7_ = Sound3DEffect.create(_loc6_,_loc4_,0,0);
            battleService.addSound3DEffect(_loc7_);
         }
      }
   }
}

