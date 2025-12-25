package com.hurlant.crypto.tests
{
   import com.hurlant.crypto.hash.HMAC;
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.crypto.hash.SHA1;
   import com.hurlant.crypto.hash.SHA224;
   import com.hurlant.crypto.hash.SHA256;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class HMACTest extends TestCase
   {
      
      public function HMACTest(param1:ITestHarness)
      {
         super(param1,"HMAC Test");
         runTest(this.testHMAC_MD5,"HMAC MD5 Test Vectors");
         runTest(this.testHMAC_SHA_1,"HMAC SHA-1 Test Vectors");
         runTest(this.testHMAC_SHA_2,"HMAC SHA-224/SHA-256 Test Vectors");
         runTest(this.testHMAC96_MD5,"HMAC-96 MD5 Test Vectors");
         runTest(this.testHMAC96_SHA_1,"HMAC-96 SHA-1 Test Vectors");
         runTest(this.testHMAC128_SHA_2,"HMAC-128 SHA-224/SHA-256 Test Vectors");
         param1.endTestCase();
      }
      
      public function testHMAC_SHA_1() : void
      {
         var _loc6_:ByteArray = null;
         var _loc7_:ByteArray = null;
         var _loc8_:ByteArray = null;
         var _loc1_:Array = ["0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b",Hex.fromString("Jefe"),"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","0102030405060708090a0b0c0d0e0f10111213141516171819","0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c","aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"];
         var _loc2_:Array = [Hex.fromString("Hi There"),Hex.fromString("what do ya want for nothing?"),"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","cdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd",Hex.fromString("Test With Truncation"),Hex.fromString("Test Using Larger Than Block-Size Key - Hash Key First"),Hex.fromString("Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data")];
         var _loc3_:Array = ["b617318655057264e28bc0b6fb378c8ef146be00","effcdf6ae5eb2fa2d27416d5f184df9c259a7c79","125d7342b9ac11cd91a39af48aa17b4f63f175d3","4c9007f4026250c6bc8414f9bf50c86c2d7235da","4c1a03424b55e07fe7f27be1d58bb9324a9a5a04","aa4ae5e15272d00e95705637ce8a3b55ed402112","e8e99d0f45237d786d6bbaa7965c7808bbff1a91"];
         var _loc4_:HMAC = new HMAC(new SHA1());
         var _loc5_:uint = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc6_ = Hex.toArray(_loc1_[_loc5_]);
            _loc7_ = Hex.toArray(_loc2_[_loc5_]);
            _loc8_ = _loc4_.compute(_loc6_,_loc7_);
            assert("HMAC-SHA-1 test " + _loc5_,Hex.fromArray(_loc8_) == _loc3_[_loc5_]);
            _loc5_++;
         }
      }
      
      public function testHMAC96_SHA_1() : void
      {
         var _loc1_:HMAC = new HMAC(new SHA1(),96);
         var _loc2_:ByteArray = Hex.toArray("0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c");
         var _loc3_:ByteArray = Hex.toArray(Hex.fromString("Test With Truncation"));
         var _loc4_:String = "4c1a03424b55e07fe7f27be1";
         var _loc5_:ByteArray = _loc1_.compute(_loc2_,_loc3_);
         assert("HMAC96-SHA-1 test",Hex.fromArray(_loc5_) == _loc4_);
      }
      
      public function testHMAC_MD5() : void
      {
         var _loc6_:ByteArray = null;
         var _loc7_:ByteArray = null;
         var _loc8_:ByteArray = null;
         var _loc1_:Array = [Hex.fromString("Jefe"),"0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b","aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","0102030405060708090a0b0c0d0e0f10111213141516171819","0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c","aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"];
         var _loc2_:Array = [Hex.fromString("what do ya want for nothing?"),Hex.fromString("Hi There"),"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","cdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd",Hex.fromString("Test With Truncation"),Hex.fromString("Test Using Larger Than Block-Size Key - Hash Key First"),Hex.fromString("Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data")];
         var _loc3_:Array = ["750c783e6ab0b503eaa86e310a5db738","9294727a3638bb1c13f48ef8158bfc9d","56be34521d144c88dbb8c733f0e8b3f6","697eaf0aca3a3aea3a75164746ffaa79","56461ef2342edc00f9bab995690efd4c","6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd","6f630fad67cda0ee1fb1f562db3aa53e"];
         var _loc4_:HMAC = new HMAC(new MD5());
         var _loc5_:uint = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc6_ = Hex.toArray(_loc1_[_loc5_]);
            _loc7_ = Hex.toArray(_loc2_[_loc5_]);
            _loc8_ = _loc4_.compute(_loc6_,_loc7_);
            assert("HMAC-MD5 test " + _loc5_,Hex.fromArray(_loc8_) == _loc3_[_loc5_]);
            _loc5_++;
         }
      }
      
      public function testHMAC96_MD5() : void
      {
         var _loc1_:HMAC = new HMAC(new MD5(),96);
         var _loc2_:ByteArray = Hex.toArray("0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c");
         var _loc3_:ByteArray = Hex.toArray(Hex.fromString("Test With Truncation"));
         var _loc4_:String = "56461ef2342edc00f9bab995";
         var _loc5_:ByteArray = _loc1_.compute(_loc2_,_loc3_);
         assert("HMAC96-MD5 test",Hex.fromArray(_loc5_) == _loc4_);
      }
      
      public function testHMAC_SHA_2() : void
      {
         var _loc8_:ByteArray = null;
         var _loc9_:ByteArray = null;
         var _loc10_:ByteArray = null;
         var _loc11_:ByteArray = null;
         var _loc1_:Array = ["0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b","4a656665","aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","0102030405060708090a0b0c0d0e0f10111213141516171819","aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"];
         var _loc2_:Array = ["4869205468657265","7768617420646f2079612077616e7420666f72206e6f7468696e673f","dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","cdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd","54657374205573696e67204c6172676572205468616e20426c6f636b2d53697a65204b6579202d2048617368204b6579204669727374","5468697320697320612074657374207573696e672061206c6172676572207468616e20626c6f636b2d73697a65206b657920616e642061206c6172676572207468616e20626c6f636b2d73697a6520646174612e20546865206b6579206e6565647320746f20626520686173686564206265666f7265206265696e6720757365642062792074686520484d414320616c676f726974686d2e"];
         var _loc3_:Array = ["896fb1128abbdf196832107cd49df33f47b4b1169912ba4f53684b22","a30e01098bc6dbbf45690f3a7e9e6d0f8bbea2a39e6148008fd05e44","7fb3cb3588c6c1f6ffa9694d7d6ad2649365b0c1f65d69d1ec8333ea","6c11506874013cac6a2abc1bb382627cec6a90d86efc012de7afec5a","95e9a0db962095adaebe9b2d6f0dbce2d499f112f2d2b7273fa6870e","3a854166ac5d9f023f54d517d0b39dbd946770db9c2b95c9f6f565d1"];
         var _loc4_:Array = ["b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7","5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843","773ea91e36800e46854db8ebd09181a72959098b3ef8c122d9635514ced565fe","82558a389a443c0ea4cc819899f2083a85f0faa3e578f8077a2e3ff46729665b","60e431591ee0b67f0d8a26aacbf5b77f8e0bc6213728c5140546040f0ee37f54","9b09ffa71b942fcb27635fbcd5b0e944bfdc63644f0713938a7f51535c3a35e2"];
         var _loc5_:HMAC = new HMAC(new SHA224());
         var _loc6_:HMAC = new HMAC(new SHA256());
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_.length)
         {
            _loc8_ = Hex.toArray(_loc1_[_loc7_]);
            _loc9_ = Hex.toArray(_loc2_[_loc7_]);
            _loc10_ = _loc5_.compute(_loc8_,_loc9_);
            assert("HMAC-SHA-224 test " + _loc7_,Hex.fromArray(_loc10_) == _loc3_[_loc7_]);
            _loc11_ = _loc6_.compute(_loc8_,_loc9_);
            assert("HMAC-SHA-256 test " + _loc7_,Hex.fromArray(_loc11_) == _loc4_[_loc7_]);
            _loc7_++;
         }
      }
      
      public function testHMAC128_SHA_2() : void
      {
         var _loc1_:HMAC = new HMAC(new SHA224(),128);
         var _loc2_:HMAC = new HMAC(new SHA256(),128);
         var _loc3_:ByteArray = Hex.toArray("0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c");
         var _loc4_:ByteArray = Hex.toArray("546573742057697468205472756e636174696f6e");
         var _loc5_:String = "0e2aea68a90c8d37c988bcdb9fca6fa8";
         var _loc6_:String = "a3b6167473100ee06e0c796c2955552b";
         var _loc7_:ByteArray = _loc1_.compute(_loc3_,_loc4_);
         assert("HMAC128-SHA-224 test",Hex.fromArray(_loc7_) == _loc5_);
         var _loc8_:ByteArray = _loc2_.compute(_loc3_,_loc4_);
         assert("HMAC128-SHA-256 test",Hex.fromArray(_loc8_) == _loc6_);
      }
   }
}

