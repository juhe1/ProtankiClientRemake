package com.hurlant.crypto.tests
{
   import com.hurlant.crypto.prng.ARC4;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class ARC4Test extends TestCase
   {
      
      public function ARC4Test(param1:ITestHarness)
      {
         super(param1,"ARC4 Test");
         runTest(this.testLameVectors,"ARC4 Test Vectors");
         param1.endTestCase();
      }
      
      public function testLameVectors() : void
      {
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:ARC4 = null;
         var _loc8_:String = null;
         var _loc1_:Array = [Hex.fromString("Key"),Hex.fromString("Wiki"),Hex.fromString("Secret")];
         var _loc2_:Array = [Hex.fromString("Plaintext"),Hex.fromString("pedia"),Hex.fromString("Attack at dawn")];
         var _loc3_:Array = ["BBF316E8D940AF0AD3","1021BF0420","45A01F645FC35B383552544B9BF5"];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = Hex.toArray(_loc1_[_loc4_]);
            _loc6_ = Hex.toArray(_loc2_[_loc4_]);
            _loc7_ = new ARC4(_loc5_);
            _loc7_.encrypt(_loc6_);
            _loc8_ = Hex.fromArray(_loc6_).toUpperCase();
            assert("comparing " + _loc3_[_loc4_] + " to " + _loc8_,_loc3_[_loc4_] == _loc8_);
            _loc7_.init(_loc5_);
            _loc7_.decrypt(_loc6_);
            _loc8_ = Hex.fromArray(_loc6_);
            assert("comparing " + _loc2_[_loc4_] + " to " + _loc8_,_loc2_[_loc4_] == _loc8_);
            _loc4_++;
         }
      }
   }
}

