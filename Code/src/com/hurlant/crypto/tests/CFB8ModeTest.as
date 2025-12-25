package com.hurlant.crypto.tests
{
   import com.hurlant.crypto.symmetric.AESKey;
   import com.hurlant.crypto.symmetric.CFB8Mode;
   import com.hurlant.crypto.symmetric.NullPad;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class CFB8ModeTest extends TestCase
   {
      
      public function CFB8ModeTest(param1:ITestHarness)
      {
         super(param1,"CBF8Mode Test");
         runTest(this.testCFB8_AES128,"CFB-8 AES-128 Test Vectors");
         runTest(this.testCFB8_AES192,"CFB-8 AES-192 Test Vectors");
         runTest(this.testCFB8_AES256,"CFB-8 AES-192 Test Vectors");
         param1.endTestCase();
      }
      
      public function testCFB8_AES128() : void
      {
         var _loc1_:ByteArray = Hex.toArray("2b7e151628aed2a6abf7158809cf4f3c");
         var _loc2_:ByteArray = Hex.toArray("6bc1bee22e409f96e93d7e117393172aae2d");
         var _loc3_:ByteArray = Hex.toArray("3b79424c9c0dd436bace9e0ed4586a4f32b9");
         var _loc4_:CFB8Mode = new CFB8Mode(new AESKey(_loc1_),new NullPad());
         _loc4_.IV = Hex.toArray("000102030405060708090a0b0c0d0e0f");
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeBytes(_loc2_);
         _loc4_.encrypt(_loc5_);
         assert("CFB8_AES128 test 1",Hex.fromArray(_loc5_) == Hex.fromArray(_loc3_));
         _loc4_.decrypt(_loc5_);
         assert("CFB8_AES128 test 2",Hex.fromArray(_loc5_) == Hex.fromArray(_loc2_));
      }
      
      public function testCFB8_AES192() : void
      {
         var _loc1_:ByteArray = Hex.toArray("8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b");
         var _loc2_:ByteArray = Hex.toArray("6bc1bee22e409f96e93d7e117393172aae2d");
         var _loc3_:ByteArray = Hex.toArray("cda2521ef0a905ca44cd057cbf0d47a0678a");
         var _loc4_:CFB8Mode = new CFB8Mode(new AESKey(_loc1_),new NullPad());
         _loc4_.IV = Hex.toArray("000102030405060708090a0b0c0d0e0f");
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeBytes(_loc2_);
         _loc4_.encrypt(_loc5_);
         assert("CFB8_AES128 test 1",Hex.fromArray(_loc5_) == Hex.fromArray(_loc3_));
         _loc4_.decrypt(_loc5_);
         assert("CFB8_AES128 test 2",Hex.fromArray(_loc5_) == Hex.fromArray(_loc2_));
      }
      
      public function testCFB8_AES256() : void
      {
         var _loc1_:ByteArray = Hex.toArray("603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4");
         var _loc2_:ByteArray = Hex.toArray("6bc1bee22e409f96e93d7e117393172aae2d");
         var _loc3_:ByteArray = Hex.toArray("dc1f1a8520a64db55fcc8ac554844e889700");
         var _loc4_:CFB8Mode = new CFB8Mode(new AESKey(_loc1_),new NullPad());
         _loc4_.IV = Hex.toArray("000102030405060708090a0b0c0d0e0f");
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeBytes(_loc2_);
         _loc4_.encrypt(_loc5_);
         assert("CFB8_AES128 test 1",Hex.fromArray(_loc5_) == Hex.fromArray(_loc3_));
         _loc4_.decrypt(_loc5_);
         assert("CFB8_AES128 test 2",Hex.fromArray(_loc5_) == Hex.fromArray(_loc2_));
      }
   }
}

