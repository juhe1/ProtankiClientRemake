package com.hurlant.crypto.tests
{
   import com.hurlant.crypto.hash.SHA224;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class SHA224Test extends TestCase
   {
      
      public function SHA224Test(param1:ITestHarness)
      {
         super(param1,"SHA-224 Test");
         runTest(this.testSha224,"SHA-224 Test Vectors");
         param1.endTestCase();
      }
      
      public function testSha224() : void
      {
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc1_:Array = [Hex.fromString("abc"),Hex.fromString("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq")];
         var _loc2_:Array = ["23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7","75388b16512776cc5dba5da1fd890150b0c6455cb4f58b1952522525"];
         var _loc3_:SHA224 = new SHA224();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = Hex.toArray(_loc1_[_loc4_]);
            _loc6_ = _loc3_.hash(_loc5_);
            assert("SHA224 Test " + _loc4_,Hex.fromArray(_loc6_) == _loc2_[_loc4_]);
            _loc4_++;
         }
      }
      
      public function testLongSha224() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:uint = uint("a".charCodeAt(0));
         var _loc3_:uint = 0;
         while(_loc3_ < 1000000)
         {
            _loc1_[_loc3_] = _loc2_;
            _loc3_++;
         }
         var _loc4_:SHA224 = new SHA224();
         var _loc5_:ByteArray = _loc4_.hash(_loc1_);
         var _loc6_:String = "20794655980c91d8bbb4c1ea97618a4bf03f42581948b2ee4ee7ad67";
         assert("SHA224 Long Test",Hex.fromArray(_loc5_) == _loc6_);
      }
   }
}

