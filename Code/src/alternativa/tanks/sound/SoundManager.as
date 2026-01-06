package alternativa.tanks.sound
{
   import alternativa.math.Vector3;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.ISound3DEffect;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class SoundManager implements ISoundManager
   {
      
      private static const MAX_SOUNDS:int = 10;
      
      private static const MAX_SOUNDS_3D:int = 21;
      
      private static const _position:Vector3 = new Vector3();
      
      private var effects:Vector.<SoundEffectData> = new Vector.<SoundEffectData>();
      
      private var numEffects:int;
      
      private var sounds:Dictionary = new Dictionary();
      
      private var numSounds:int;
      
      private var mute:Boolean;
      
      public function SoundManager()
      {
         super();
      }
      
      public static function createSoundManager(param1:Sound) : ISoundManager
      {
         var _loc2_:SoundChannel = param1.play(0,1,new SoundTransform(0));
         if(_loc2_ != null)
         {
            _loc2_.stop();
            return new SoundManager();
         }
         return new DummySoundManager();
      }
      
      public function setMute(param1:Boolean) : void
      {
         this.mute = param1;
      }
      
      public function playSound(param1:Sound, param2:int = 0, param3:int = 0, param4:SoundTransform = null) : SoundChannel
      {
         var _loc5_:SoundChannel = null;
         if(this.canPlaySound(param1))
         {
            _loc5_ = param1.play(param2,param3,param4);
            if(_loc5_ != null)
            {
               this.addSoundChannel(_loc5_);
            }
            return _loc5_;
         }
         return null;
      }
      
      private function canPlaySound(param1:Sound) : Boolean
      {
         return !this.mute && this.numSounds < MAX_SOUNDS && param1 != null;
      }
      
      public function stopSound(param1:SoundChannel) : void
      {
         if(param1 != null && this.sounds[param1] != null)
         {
            this.removeSoundChannel(param1);
         }
      }
      
      public function stopAllSounds() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.sounds)
         {
            this.removeSoundChannel(_loc1_ as SoundChannel);
         }
      }
      
      public function addEffect(param1:ISound3DEffect) : void
      {
         if(this.canAddEffect(param1))
         {
            param1.enabled = true;
            this.effects.push(SoundEffectData.create(0,param1));
            ++this.numEffects;
         }
      }
      
      private function canAddEffect(param1:ISound3DEffect) : Boolean
      {
         return !this.mute && param1 != null && this.getEffectIndex(param1) < 0;
      }
      
      public function removeEffect(param1:ISound3DEffect) : void
      {
         var _loc3_:SoundEffectData = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.numEffects)
         {
            _loc3_ = this.effects[_loc2_];
            if(_loc3_.effect == param1)
            {
               param1.destroy();
               SoundEffectData.destroy(_loc3_);
               this.effects.splice(_loc2_,1);
               --this.numEffects;
               return;
            }
            _loc2_++;
         }
      }
      
      public function removeAllEffects() : void
      {
         var _loc1_:SoundEffectData = null;
         while(this.effects.length > 0)
         {
            _loc1_ = this.effects.pop();
            _loc1_.effect.destroy();
            SoundEffectData.destroy(_loc1_);
         }
         this.numEffects = 0;
      }
      
      public function updateSoundEffects(param1:int, param2:GameCamera) : void
      {
         var _loc3_:int = 0;
         if(this.numEffects > 0)
         {
            this.sortEffects(param2.position);
            _loc3_ = this.processEffectsInActiveRange(param1,param2);
            this.deactivateRemainingEffects(_loc3_);
         }
      }
      
      private function processEffectsInActiveRange(param1:int, param2:GameCamera) : int
      {
         var _loc3_:SoundEffectData = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < this.numEffects)
         {
            _loc3_ = this.effects[_loc5_];
            _loc6_ = int(_loc3_.effect.numSounds);
            if(_loc6_ == 0)
            {
               _loc3_.effect.destroy();
               SoundEffectData.destroy(_loc3_);
               this.effects.splice(_loc5_,1);
               --this.numEffects;
               _loc5_--;
            }
            else if(_loc4_ + _loc6_ > MAX_SOUNDS_3D)
            {
               if(_loc4_ == MAX_SOUNDS_3D)
               {
                  break;
               }
               _loc3_.effect.enabled = false;
            }
            else
            {
               _loc3_.effect.enabled = true;
               _loc3_.effect.play(param1,param2);
               _loc4_ += _loc6_;
            }
            _loc5_++;
         }
         return _loc5_;
      }
      
      private function deactivateRemainingEffects(param1:int) : void
      {
         var _loc3_:SoundEffectData = null;
         var _loc2_:int = param1;
         while(_loc2_ < this.numEffects)
         {
            _loc3_ = this.effects[_loc2_];
            _loc3_.effect.enabled = false;
            if(_loc3_.effect.numSounds == 0)
            {
               _loc3_.effect.destroy();
               SoundEffectData.destroy(_loc3_);
               this.effects.splice(_loc2_,1);
               --this.numEffects;
               _loc2_--;
            }
            _loc2_++;
         }
      }
      
      private function addSoundChannel(param1:SoundChannel) : void
      {
         param1.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
         this.sounds[param1] = true;
         ++this.numSounds;
      }
      
      private function removeSoundChannel(param1:SoundChannel) : void
      {
         param1.stop();
         param1.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
         delete this.sounds[param1];
         --this.numSounds;
      }
      
      private function onSoundComplete(param1:Event) : void
      {
         this.stopSound(param1.target as SoundChannel);
      }
      
      private function getEffectIndex(param1:ISound3DEffect) : int
      {
         var _loc3_:SoundEffectData = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.numEffects)
         {
            _loc3_ = this.effects[_loc2_];
            if(_loc3_.effect == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function sortEffects(param1:Vector3) : void
      {
         var cameraPos:Vector3 = param1;
         this.updateDistancesToEffects(cameraPos);
         this.effects.sort(function(param1:SoundEffectData, param2:SoundEffectData):Number
         {
            return param1.distanceSqr - param2.distanceSqr;
         });
      }
      
      private function updateDistancesToEffects(param1:Vector3) : void
      {
         var _loc3_:SoundEffectData = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:int = 0;
         while(_loc2_ < this.numEffects)
         {
            _loc3_ = this.effects[_loc2_];
            _loc3_.effect.readPosition(_position);
            _loc4_ = param1.x - _position.x;
            _loc5_ = param1.y - _position.y;
            _loc6_ = param1.z - _position.z;
            _loc3_.distanceSqr = _loc4_ * _loc4_ + _loc5_ * _loc5_ + _loc6_ * _loc6_;
            _loc2_++;
         }
      }
   }
}

