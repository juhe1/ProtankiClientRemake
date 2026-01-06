package alternativa.tanks.models.controlpoints.sound
{
   import alternativa.tanks.models.tank.LocalTankParams;
   import alternativa.tanks.sound.ISoundManager;
   import flash.media.Sound;
   import platform.client.fp10.core.resource.types.SoundResource;
   import projects.tanks.client.battlefield.models.battle.cp.resources.DominationSounds;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class Sounds
   {
      
      private var soundManager:ISoundManager;
      
      private var sounds:DominationSounds;
      
      public function Sounds(param1:ISoundManager, param2:DominationSounds)
      {
         super();
         this.soundManager = param1;
         this.sounds = param2;
      }
      
      private static function getSound(param1:SoundResource) : Sound
      {
         if(param1 == null)
         {
            return null;
         }
         return param1.sound;
      }
      
      public function playCaptureStartSound(param1:BattleTeam) : void
      {
         var _loc2_:Sound = null;
         if(param1 == LocalTankParams.teamType)
         {
            _loc2_ = getSound(this.sounds.pointCaptureStartPositiveSound);
         }
         else
         {
            _loc2_ = getSound(this.sounds.pointCaptureStartNegativeSound);
         }
         this.soundManager.playSound(_loc2_);
      }
      
      public function playCaptureStopSound(param1:BattleTeam) : void
      {
         var _loc2_:Sound = null;
         if(param1 == LocalTankParams.teamType)
         {
            _loc2_ = getSound(this.sounds.pointCaptureStopNegativeSound);
         }
         else
         {
            _loc2_ = getSound(this.sounds.pointCaptureStopPositiveSound);
         }
         this.soundManager.playSound(_loc2_);
      }
      
      public function playCapturingSound(param1:BattleTeam) : void
      {
         var _loc2_:Sound = null;
         if(param1 == LocalTankParams.teamType)
         {
            _loc2_ = getSound(this.sounds.pointCapturedPositiveSound);
         }
         else
         {
            _loc2_ = getSound(this.sounds.pointCapturedNegativeSound);
         }
         this.soundManager.playSound(_loc2_);
      }
      
      public function playNeutralizedSound(param1:BattleTeam) : void
      {
         var _loc2_:Sound = null;
         if(param1 == LocalTankParams.teamType)
         {
            _loc2_ = getSound(this.sounds.pointNeutralizedNegativeSound);
         }
         else
         {
            _loc2_ = getSound(this.sounds.pointNeutralizedPositiveSound);
         }
         this.soundManager.playSound(_loc2_);
      }
   }
}

