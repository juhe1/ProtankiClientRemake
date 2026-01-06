package alternativa.tanks.sfx
{
   import alternativa.engine3d.core.Light3D;
   import alternativa.engine3d.lights.OmniLight;
   import alternativa.engine3d.lights.SpotLight;
   import alternativa.engine3d.lights.TubeLight;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightEffectItem;
   
   public final class LightAnimation
   {
      
      private var frames:int;
      
      private var time:Vector.<uint>;
      
      private var intensity:Vector.<Number>;
      
      private var color:Vector.<uint>;
      
      private var attenuationBegin:Vector.<Number>;
      
      private var attenuationEnd:Vector.<Number>;
      
      public function LightAnimation(param1:Vector.<LightEffectItem>)
      {
         var _loc3_:LightEffectItem = null;
         super();
         this.frames = param1.length;
         this.intensity = new Vector.<Number>(this.frames,true);
         this.color = new Vector.<uint>(this.frames,true);
         this.attenuationBegin = new Vector.<Number>(this.frames,true);
         this.attenuationEnd = new Vector.<Number>(this.frames,true);
         this.time = new Vector.<uint>(this.frames,true);
         var _loc2_:int = 0;
         while(_loc2_ < this.frames)
         {
            _loc3_ = param1[_loc2_];
            this.intensity[_loc2_] = Number(_loc3_.intensity);
            this.color[_loc2_] = uint(_loc3_.color);
            this.attenuationBegin[_loc2_] = Number(_loc3_.attenuationBegin);
            this.attenuationEnd[_loc2_] = Number(_loc3_.attenuationEnd);
            this.time[_loc2_] = uint(_loc3_.time);
            _loc2_++;
         }
      }
      
      private static function lerpNumber(param1:Number, param2:Number, param3:Number) : Number
      {
         return param1 + (param2 - param1) * param3;
      }
      
      private static function lerpColor(param1:uint, param2:uint, param3:Number) : uint
      {
         var _loc4_:Number = (param1 >> 16 & 0xFF) / 255;
         var _loc5_:Number = (param1 >> 8 & 0xFF) / 255;
         var _loc6_:Number = (param1 & 0xFF) / 255;
         var _loc7_:Number = (param2 >> 16 & 0xFF) / 255;
         var _loc8_:Number = (param2 >> 8 & 0xFF) / 255;
         var _loc9_:Number = (param2 & 0xFF) / 255;
         var _loc10_:int = lerpNumber(_loc4_,_loc7_,param3) * 255;
         var _loc11_:int = lerpNumber(_loc5_,_loc8_,param3) * 255;
         var _loc12_:int = lerpNumber(_loc6_,_loc9_,param3) * 255;
         return _loc10_ << 16 | _loc11_ << 8 | _loc12_;
      }
      
      private function getFrameByTime(param1:Number) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Number = 0;
         if(param1 < this.time[this.frames - 1])
         {
            _loc3_ = 0;
            while(_loc3_ < this.frames - 1)
            {
               _loc4_ = this.time[_loc3_];
               _loc5_ = this.time[_loc3_ + 1];
               if(param1 >= _loc4_ && param1 < _loc5_)
               {
                  _loc6_ = (param1 - _loc4_) / (_loc5_ - _loc4_);
                  _loc2_ = _loc3_ + _loc6_;
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc2_ = this.frames - 1;
         }
         return _loc2_;
      }
      
      public function getFramesCount() : int
      {
         return this.frames;
      }
      
      private function limitFrame(param1:int) : int
      {
         return param1 < this.frames ? param1 : this.frames - 1;
      }
      
      private function updateSpotLight(param1:Number, param2:SpotLight) : void
      {
         var _loc3_:int = this.limitFrame(Math.floor(param1));
         var _loc4_:int = this.limitFrame(Math.ceil(param1));
         var _loc5_:Number = param1 - _loc3_;
         var _loc6_:Number = this.intensity[_loc3_];
         var _loc7_:Number = this.intensity[_loc4_];
         var _loc8_:uint = this.color[_loc3_];
         var _loc9_:uint = this.color[_loc4_];
         var _loc10_:Number = this.attenuationBegin[_loc3_];
         var _loc11_:Number = this.attenuationBegin[_loc4_];
         var _loc12_:Number = this.attenuationEnd[_loc3_];
         var _loc13_:Number = this.attenuationEnd[_loc4_];
         param2.intensity = lerpNumber(_loc6_,_loc7_,_loc5_);
         param2.color = lerpColor(_loc8_,_loc9_,_loc5_);
         param2.attenuationBegin = lerpNumber(_loc10_,_loc11_,_loc5_);
         param2.attenuationEnd = lerpNumber(_loc12_,_loc13_,_loc5_);
      }
      
      private function updateOmniLight(param1:Number, param2:OmniLight) : void
      {
         var _loc3_:int = this.limitFrame(Math.floor(param1));
         var _loc4_:int = this.limitFrame(Math.ceil(param1));
         var _loc5_:Number = param1 - _loc3_;
         var _loc6_:Number = this.intensity[_loc3_];
         var _loc7_:Number = this.intensity[_loc4_];
         var _loc8_:uint = this.color[_loc3_];
         var _loc9_:uint = this.color[_loc4_];
         var _loc10_:Number = this.attenuationBegin[_loc3_];
         var _loc11_:Number = this.attenuationBegin[_loc4_];
         var _loc12_:Number = this.attenuationEnd[_loc3_];
         var _loc13_:Number = this.attenuationEnd[_loc4_];
         param2.intensity = lerpNumber(_loc6_,_loc7_,_loc5_);
         param2.color = lerpColor(_loc8_,_loc9_,_loc5_);
         param2.attenuationBegin = lerpNumber(_loc10_,_loc11_,_loc5_);
         param2.attenuationEnd = lerpNumber(_loc12_,_loc13_,_loc5_);
      }
      
      private function updateTubeLight(param1:Number, param2:TubeLight) : void
      {
         var _loc3_:int = this.limitFrame(Math.floor(param1));
         var _loc4_:int = this.limitFrame(Math.ceil(param1));
         var _loc5_:Number = param1 - _loc3_;
         var _loc6_:Number = this.intensity[_loc3_];
         var _loc7_:Number = this.intensity[_loc4_];
         var _loc8_:uint = this.color[_loc3_];
         var _loc9_:uint = this.color[_loc4_];
         var _loc10_:Number = this.attenuationBegin[_loc3_];
         var _loc11_:Number = this.attenuationBegin[_loc4_];
         var _loc12_:Number = this.attenuationEnd[_loc3_];
         var _loc13_:Number = this.attenuationEnd[_loc4_];
         param2.intensity = lerpNumber(_loc6_,_loc7_,_loc5_);
         param2.color = lerpColor(_loc8_,_loc9_,_loc5_);
         param2.attenuationBegin = lerpNumber(_loc10_,_loc11_,_loc5_);
         param2.attenuationEnd = lerpNumber(_loc12_,_loc13_,_loc5_);
      }
      
      public function updateByTime(param1:Light3D, param2:int, param3:int = -1) : void
      {
         var _loc4_:Number = 1;
         if(param3 > 0 && this.frames > 0)
         {
            _loc4_ = this.time[this.frames - 1] / param3;
         }
         var _loc5_:Number = this.getFrameByTime(param2 * _loc4_);
         this.updateByFrame(param1,_loc5_);
      }
      
      private function updateByFrame(param1:Light3D, param2:Number) : void
      {
         if(param1 is OmniLight)
         {
            this.updateOmniLight(param2,OmniLight(param1));
         }
         else if(param1 is SpotLight)
         {
            this.updateSpotLight(param2,SpotLight(param1));
         }
         else if(param1 is TubeLight)
         {
            this.updateTubeLight(param2,TubeLight(param1));
         }
         param1.calculateBounds();
      }
      
      public function getLiveTime() : int
      {
         return this.time[this.frames - 1];
      }
   }
}

