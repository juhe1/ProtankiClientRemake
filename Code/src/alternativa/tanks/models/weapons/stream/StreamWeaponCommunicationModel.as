package alternativa.tanks.models.weapons.stream
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleUtils;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.battle.events.StateCorrectionEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.stream.IStreamWeaponCommunicationModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapons.common.stream.StreamWeaponCommunicationModelBase;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   [ModelInfo]
   public class StreamWeaponCommunicationModel extends StreamWeaponCommunicationModelBase implements IStreamWeaponCommunicationModelBase, StreamWeaponCommunication
   {
      
      [Inject] // added
      public static var battleEventDispatcher:BattleEventDispatcher;
      
      public function StreamWeaponCommunicationModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function startFire() : void
      {
         this.streamWeaponListeners().onStart();
      }
      
      [Obfuscation(rename="false")]
      public function stopFire() : void
      {
         this.streamWeaponListeners().onStop();
      }
      
      [Obfuscation(rename="false")]
      public function updateTargets(param1:Vector3d, param2:Vector.<TargetHit>) : void
      {
         this.streamWeaponListeners().onTargetsUpdated(BattleUtils.getVector3(param1),param2);
      }
      
      public function fireStarted(param1:int) : void
      {
         server.startFire(param1);
      }
      
      public function targetUpdate(param1:int, param2:Vector3, param3:Tank, position:Vector3) : void
      {
         this.targetsUpdated(param1,param2,this.asList(param3,position));
      }
      
      public function targetsUpdated(param1:int, param2:Vector3, param3:Vector.<TargetPosition>) : void
      {
         battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         server.updateTargets(param1,BattleUtils.getVector3d(param2),param3);
      }
      
      public function targetsUpdateDummy(param1:int, param2:Vector3) : void
      {
         battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
         server.updateTargetsDummy(param1,BattleUtils.getVector3d(param2));
      }
      
      public function fireStopped(param1:int) : void
      {
         server.stopFire(param1);
      }
      
      private function streamWeaponListeners() : StreamWeaponListener
      {
         return StreamWeaponListener(object.event(StreamWeaponListener));
      }
      
      private function asList(param1:Tank, position:Vector3) : Vector.<TargetPosition>
      {
         var _loc2_:Vector.<TargetPosition> = new Vector.<TargetPosition>();
         var _loc3_:TargetPosition = null;
         if(param1 != null)
         {
            _loc3_ = BattleUtils.getTargetPosition(param1);
            _loc3_.localHitPoint = BattleUtils.getVector3dOrNull(position);
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
   }
}

