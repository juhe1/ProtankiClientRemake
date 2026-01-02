package projects.tanks.clients.flash.resources.resource
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class ParserWav
   {
      
      public function ParserWav()
      {
         super();
      }
      
      public function parse(param1:ByteArray, param2:int = 0, param3:Boolean = false) : Vector.<Number>
      {
         var _loc12_:int = 0;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         if(param3)
         {
         }
         param1.position = 0;
         param1.endian = Endian.LITTLE_ENDIAN;
         var _loc4_:ByteArray = new ByteArray();
         param1.readBytes(_loc4_,0,4);
         if(_loc4_.toString() != "RIFF")
         {
            throw new Error("Incorrect file header.");
         }
         param1.position = 16;
         if(param1.readUnsignedInt() != 16)
         {
            throw new Error("Incorrect file size.");
         }
         if(param1.readShort() <= 0)
         {
            throw new Error("Incorrect file format.");
         }
         var _loc5_:int = param1.readShort();
         if(param3)
         {
         }
         if(_loc5_ < 1 || _loc5_ > 2)
         {
            throw new Error("Incorrect channels count.");
         }
         var _loc6_:int = int(param1.readUnsignedInt());
         if(param3)
         {
         }
         if(_loc6_ != 22050 && _loc6_ != 44100)
         {
            throw new Error("Incorrect sample rate.");
         }
         var _loc7_:int = int(param1.readUnsignedInt());
         if(param3)
         {
         }
         var _loc8_:int = param1.readShort();
         if(param3)
         {
         }
         var _loc9_:int = param1.readShort();
         if(param3)
         {
         }
         if(_loc9_ != 16 && _loc9_ != 32)
         {
            throw new Error("Incorrect bit depth.");
         }
         if(_loc8_ <= 0)
         {
            _loc8_ = _loc5_ * _loc9_ / 8;
            if(param3)
            {
            }
         }
         param1.position += 4;
         var _loc10_:int = int(param1.readUnsignedInt());
         if(param1.bytesAvailable < _loc10_)
         {
            _loc10_ = int(param1.bytesAvailable);
         }
         param1.position = 44;
         var _loc11_:int = _loc10_ / _loc5_ / (_loc9_ / 8);
         if(param3)
         {
         }
         var _loc17_:Vector.<Number> = new Vector.<Number>();
         var _loc18_:int = 0;
         if(_loc6_ == 22050)
         {
            param2 >>= 1;
         }
         _loc12_ = 0;
         while(_loc12_ < _loc11_)
         {
            if(_loc5_ == 1)
            {
               if(_loc9_ == 16)
               {
                  _loc13_ = param1.readShort() / 32768;
               }
               else
               {
                  _loc13_ = param1.readInt() / 2147483648;
               }
               if(_loc12_ < param2)
               {
                  _loc13_ *= _loc12_ / param2;
               }
               else if(_loc12_ >= _loc11_ - param2)
               {
                  _loc13_ *= (_loc11_ - _loc12_ - 1) / param2;
               }
               _loc14_ = _loc13_;
            }
            else
            {
               if(_loc9_ == 16)
               {
                  _loc13_ = param1.readShort() / 32768;
                  _loc14_ = param1.readShort() / 32768;
               }
               else
               {
                  _loc13_ = param1.readInt() / 2147483648;
                  _loc14_ = param1.readInt() / 2147483648;
               }
               if(_loc12_ < param2)
               {
                  _loc13_ *= _loc12_ / param2;
                  _loc14_ *= _loc12_ / param2;
               }
               else if(_loc12_ >= _loc11_ - param2)
               {
                  _loc13_ *= (_loc11_ - _loc12_ - 1) / param2;
                  _loc14_ *= (_loc11_ - _loc12_ - 1) / param2;
               }
            }
            if(_loc6_ == 22050)
            {
               if(_loc12_ > 0)
               {
                  _loc17_[_loc18_] = (_loc15_ + _loc13_) * 0.5;
                  _loc18_++;
                  _loc17_[_loc18_] = (_loc16_ + _loc14_) * 0.5;
                  _loc18_++;
               }
               _loc15_ = _loc13_;
               _loc16_ = _loc14_;
            }
            _loc17_[_loc18_] = _loc13_;
            _loc18_++;
            _loc17_[_loc18_] = _loc14_;
            _loc18_++;
            _loc12_++;
         }
         if(_loc6_ == 22050)
         {
            _loc17_[_loc18_] = (_loc15_ + _loc17_[0]) * 0.5;
            _loc18_++;
            _loc17_[_loc18_] = (_loc16_ + _loc17_[1]) * 0.5;
            _loc18_++;
         }
         if(param3)
         {
         }
         return _loc17_;
      }
   }
}

