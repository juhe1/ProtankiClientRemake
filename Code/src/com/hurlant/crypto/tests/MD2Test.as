package com.hurlant.crypto.tests
{
   import com.hurlant.crypto.hash.MD2;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class MD2Test extends TestCase
   {
      
      public function MD2Test(param1:ITestHarness)
      {
         super(param1,"MD2 Test");
         runTest(this.testMd2,"MD2 Test Vectors");
         param1.endTestCase();
      }
      
      public function testMd2() : void
      {
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc1_:Array = ["",Hex.fromString("a"),Hex.fromString("abc"),Hex.fromString("message digest"),Hex.fromString("abcdefghijklmnopqrstuvwxyz"),Hex.fromString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"),Hex.fromString("12345678901234567890123456789012345678901234567890123456789012345678901234567890")];
         var _loc2_:Array = ["8350e5a3e24c153df2275c9f80692773","32ec01ec4a6dac72c0ab96fb34c0b5d1","da853b0d3f88d99b30283a69e6ded6bb","ab4f496bfb2a530b219ff33031fe06b0","4e8ddff3650292ab5a4108c3aa47940b","da33def2a42df13975352846c30338cd","d5976f79d83d3a0dc9806c3c66f3efd8"];
         var _loc3_:MD2 = new MD2();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = Hex.toArray(_loc1_[_loc4_]);
            _loc6_ = _loc3_.hash(_loc5_);
            assert("MD2 Test " + _loc4_,Hex.fromArray(_loc6_) == _loc2_[_loc4_]);
            _loc4_++;
         }
      }
   }
}

