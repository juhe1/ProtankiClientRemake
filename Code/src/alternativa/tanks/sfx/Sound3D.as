package alternativa.tanks.sfx
{
   import alternativa.math.Vector3;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class Sound3D
   {
      
      private static var pool:Sound3D;
      
      public static const ETERNAL_LOOP:int = 1000000;
      
      private static const NEAR_RADIUS:Number = 1000;
      
      private static const FAR_RADIUS:Number = 5000;
      
      private static const FAR_DELIMITER:Number = 5;
      
      internal var nextInPool:Sound3D;
      
      private var nearRadius:Number;
      
      private var volumeCoefficient:Number;
      
      private var sound:Sound;
      
      private var _channel:SoundChannel;
      
      private var transform:SoundTransform = new SoundTransform(0);
      
      private var _volume:Number = 1;
      
      private var _baseVolume:Number = 1;
      
      private var effectiveVolume:Number = 1;
      
      public function Sound3D(param1:Sound, param2:Number, param3:Number, param4:Number, param5:Number)
      {
         super();
         this.init(param1,param2,param3,param4,param5);
      }
      
      public static function create(param1:Sound, param2:Number = 1, param3:Number = 1000, param4:Number = 5000, param5:Number = 5) : Sound3D
      {
         var _loc6_:Sound3D = null;
         if(pool == null)
         {
            return new Sound3D(param1,param3,param4,param5,param2);
         }
         _loc6_ = pool;
         _loc6_.init(param1,param3,param4,param5,param2);
         pool = _loc6_.nextInPool;
         _loc6_.nextInPool = null;
         return _loc6_;
      }
      
      public static function destroy(param1:Sound3D) : void
      {
         param1.clear();
         if(pool == null)
         {
            pool = param1;
         }
         else
         {
            param1.nextInPool = pool;
            pool = param1;
         }
      }
      
      public function isPlaying() : Boolean
      {
         return this._channel != null;
      }
      
      public function get channel() : SoundChannel
      {
         return this._channel;
      }
      
      public function get position() : Number
      {
         return this._channel == null ? 0 : this._channel.position;
      }
      
      public function init(param1:Sound, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         this.sound = param1;
         this.nearRadius = param2;
         this._baseVolume = param5;
         this.volumeCoefficient = (Math.sqrt(param4) - 1) / (param3 - param2);
         this.volume = 1;
      }
      
      public function clear() : void
      {
         this.stop();
         this.sound = null;
      }
      
      public function get baseVolume() : Number
      {
         return this._baseVolume;
      }
      
      public function set baseVolume(param1:Number) : void
      {
         this._baseVolume = param1;
         this.updateEffectiveVolume();
      }
      
      public function get volume() : Number
      {
         return this._volume;
      }
      
      public function set volume(param1:Number) : void
      {
         this._volume = param1;
         this.updateEffectiveVolume();
      }
      
      public function calculateSoundProperties(param1:Vector3, param2:Vector3, param3:Vector3, param4:SoundTransform) : void
      {
         var _loc9_:Number = NaN;
         var _loc5_:Number = param2.x - param1.x;
         var _loc6_:Number = param2.y - param1.y;
         var _loc7_:Number = param2.z - param1.z;
         var _loc8_:Number = Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_ + _loc7_ * _loc7_);
         if(_loc8_ < this.nearRadius)
         {
            param4.volume = 1;
            param4.pan = 0;
         }
         else
         {
            _loc9_ = 1 + this.volumeCoefficient * (_loc8_ - this.nearRadius);
            _loc9_ = 1 / (_loc9_ * _loc9_);
            param4.volume = _loc9_;
            _loc8_ = 1 / _loc8_;
            _loc5_ *= _loc8_;
            _loc6_ *= _loc8_;
            _loc7_ *= _loc8_;
            param4.pan = (_loc5_ * param3.x + _loc6_ * param3.y + _loc7_ * param3.z) * (1 - _loc9_);
         }
      }
      
      public function checkVolume(param1:Vector3, param2:Vector3, param3:Vector3) : void
      {
         if(this._channel != null)
         {
            this.calculateSoundProperties(param1,param2,param3,this.transform);
            this.transform.volume *= this.effectiveVolume;
            this._channel.soundTransform = this.transform;
         }
      }
      
      public function play(param1:int, param2:int) : SoundChannel
      {
         if(this._channel != null)
         {
            this._channel.stop();
         }
         return this._channel = this.sound.play(param1,param2);
      }
      
      public function stop() : void
      {
         if(this._channel != null)
         {
            this._channel.stop();
            this._channel = null;
         }
      }
      
      private function updateEffectiveVolume() : void
      {
         this.effectiveVolume = this._baseVolume * this._volume;
      }
   }
}

