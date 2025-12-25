package com.hurlant.crypto.tests
{
   import com.hurlant.crypto.symmetric.AESKey;
   import com.hurlant.crypto.symmetric.CBCMode;
   import com.hurlant.crypto.symmetric.NullPad;
   import com.hurlant.crypto.symmetric.XTeaKey;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class CBCModeTest extends TestCase
   {
      
      public function CBCModeTest(param1:ITestHarness)
      {
         super(param1,"CBCMode Test");
         runTest(this.testAES,"CBC AES Test Vectors");
         runTest(this.testXTea,"CBC XTea Test Vectors");
         runTest(this.testCBC_AES128,"CBC AES-128 Test Vectors");
         runTest(this.testCBC_AES192,"CBC AES-192 Test Vectors");
         runTest(this.testCBC_AES256,"CBC AES-256 Test Vectors");
         param1.endTestCase();
      }
      
      public function testCBC_AES128() : void
      {
         var _loc1_:ByteArray = Hex.toArray("2b7e151628aed2a6abf7158809cf4f3c");
         var _loc2_:ByteArray = Hex.toArray("6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" + "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710");
         var _loc3_:ByteArray = Hex.toArray("7649abac8119b246cee98e9b12e9197d" + "5086cb9b507219ee95db113a917678b2" + "73bed6b8e3c1743b7116e69e22229516" + "3ff1caa1681fac09120eca307586e1a7");
         var _loc4_:CBCMode = new CBCMode(new AESKey(_loc1_),new NullPad());
         _loc4_.IV = Hex.toArray("000102030405060708090a0b0c0d0e0f");
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeBytes(_loc2_);
         _loc4_.encrypt(_loc5_);
         assert("CBC_AES128 test 1",Hex.fromArray(_loc5_) == Hex.fromArray(_loc3_));
         _loc4_.decrypt(_loc5_);
         assert("CBC_AES128 test 2",Hex.fromArray(_loc5_) == Hex.fromArray(_loc2_));
      }
      
      public function testCBC_AES192() : void
      {
         var _loc1_:ByteArray = Hex.toArray("8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b");
         var _loc2_:ByteArray = Hex.toArray("6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" + "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710");
         var _loc3_:ByteArray = Hex.toArray("4f021db243bc633d7178183a9fa071e8" + "b4d9ada9ad7dedf4e5e738763f69145a" + "571b242012fb7ae07fa9baac3df102e0" + "08b0e27988598881d920a9e64f5615cd");
         var _loc4_:CBCMode = new CBCMode(new AESKey(_loc1_),new NullPad());
         _loc4_.IV = Hex.toArray("000102030405060708090a0b0c0d0e0f");
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeBytes(_loc2_);
         _loc4_.encrypt(_loc5_);
         assert("CBC_AES192 test 1",Hex.fromArray(_loc5_) == Hex.fromArray(_loc3_));
         _loc4_.decrypt(_loc5_);
         assert("CBC_AES192 test 2",Hex.fromArray(_loc5_) == Hex.fromArray(_loc2_));
      }
      
      public function testCBC_AES256() : void
      {
         var _loc1_:ByteArray = Hex.toArray("603deb1015ca71be2b73aef0857d7781" + "1f352c073b6108d72d9810a30914dff4");
         var _loc2_:ByteArray = Hex.toArray("6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" + "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710");
         var _loc3_:ByteArray = Hex.toArray("f58c4c04d6e5f1ba779eabfb5f7bfbd6" + "9cfc4e967edb808d679f777bc6702c7d" + "39f23369a9d9bacfa530e26304231461" + "b2eb05e2c39be9fcda6c19078c6a9d1b");
         var _loc4_:CBCMode = new CBCMode(new AESKey(_loc1_),new NullPad());
         _loc4_.IV = Hex.toArray("000102030405060708090a0b0c0d0e0f");
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeBytes(_loc2_);
         _loc4_.encrypt(_loc5_);
         assert("CBC_AES256 test 1",Hex.fromArray(_loc5_) == Hex.fromArray(_loc3_));
         _loc4_.decrypt(_loc5_);
         assert("CBC_AES256 test 2",Hex.fromArray(_loc5_) == Hex.fromArray(_loc2_));
      }
      
      public function testAES() : void
      {
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:AESKey = null;
         var _loc8_:CBCMode = null;
         var _loc9_:String = null;
         var _loc1_:Array = ["00010203050607080A0B0C0D0F101112","14151617191A1B1C1E1F202123242526"];
         var _loc2_:Array = ["D8F532538289EF7D06B506A4FD5BE9C94894C5508A8D8E29AB600DB0261F0555A8FA287B89E65C0973F1F8283E70C72863FE1C8F1F782084CE05626E961A67B3","59AB30F4D4EE6E4FF9907EF65B1FB68C96890CE217689B1BE0C93ED51CF21BB5A0101A8C30714EC4F52DBC9C6F4126067D363F67ABE58463005E679B68F0B496"];
         var _loc3_:Array = ["506812A45F08C889B97F5980038B8359506812A45F08C889B97F5980038B8359506812A45F08C889B97F5980038B8359","5C6D71CA30DE8B8B00549984D2EC7D4B5C6D71CA30DE8B8B00549984D2EC7D4B5C6D71CA30DE8B8B00549984D2EC7D4B"];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = Hex.toArray(_loc1_[_loc4_]);
            _loc6_ = Hex.toArray(_loc3_[_loc4_]);
            _loc7_ = new AESKey(_loc5_);
            _loc8_ = new CBCMode(_loc7_);
            _loc8_.IV = Hex.toArray("00000000000000000000000000000000");
            _loc8_.encrypt(_loc6_);
            _loc9_ = Hex.fromArray(_loc6_).toUpperCase();
            assert("comparing " + _loc2_[_loc4_] + " to " + _loc9_,_loc2_[_loc4_] == _loc9_);
            _loc8_.decrypt(_loc6_);
            _loc9_ = Hex.fromArray(_loc6_).toUpperCase();
            assert("comparing " + _loc3_[_loc4_] + " to " + _loc9_,_loc3_[_loc4_] == _loc9_);
            _loc4_++;
         }
      }
      
      public function testXTea() : void
      {
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:XTeaKey = null;
         var _loc8_:CBCMode = null;
         var _loc9_:String = null;
         var _loc1_:Array = ["00000000000000000000000000000000","2b02056806144976775d0e266c287843"];
         var _loc2_:Array = ["2dc7e8d3695b0538d8f1640d46dca717790af2ab545e11f3b08e798eb3f17b1744299d4d20b534aa","790958213819878370eb8251ffdac371081c5a457fc42502c63910306fea150be8674c3b8e675516"];
         var _loc3_:Array = ["0000000000000000000000000000000000000000000000000000000000000000","74657374206d652e74657374206d652e74657374206d652e74657374206d652e"];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = Hex.toArray(_loc1_[_loc4_]);
            _loc6_ = Hex.toArray(_loc3_[_loc4_]);
            _loc7_ = new XTeaKey(_loc5_);
            _loc8_ = new CBCMode(_loc7_);
            _loc8_.IV = Hex.toArray("0000000000000000");
            _loc8_.encrypt(_loc6_);
            _loc9_ = Hex.fromArray(_loc6_);
            assert("comparing " + _loc2_[_loc4_] + " to " + _loc9_,_loc2_[_loc4_] == _loc9_);
            _loc8_.decrypt(_loc6_);
            _loc9_ = Hex.fromArray(_loc6_);
            assert("comparing " + _loc3_[_loc4_] + " to " + _loc9_,_loc3_[_loc4_] == _loc9_);
            _loc4_++;
         }
      }
   }
}

