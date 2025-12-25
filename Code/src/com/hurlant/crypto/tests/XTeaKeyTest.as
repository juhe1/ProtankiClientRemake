package com.hurlant.crypto.tests
{
   import com.hurlant.crypto.symmetric.XTeaKey;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class XTeaKeyTest extends TestCase
   {
      
      public function XTeaKeyTest(param1:ITestHarness)
      {
         super(param1,"XTeaKey Test");
         runTest(this.testGetBlockSize,"XTea Block Size");
         runTest(this.testVectors,"XTea Test Vectors");
         param1.endTestCase();
      }
      
      public function testGetBlockSize() : void
      {
         var _loc1_:XTeaKey = new XTeaKey(Hex.toArray("deadbabecafebeefdeadbabecafebeef"));
         assert("tea blocksize",_loc1_.getBlockSize() == 8);
      }
      
      public function testVectors() : void
      {
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:XTeaKey = null;
         var _loc8_:String = null;
         var _loc1_:Array = ["00000000000000000000000000000000","2b02056806144976775d0e266c287843"];
         var _loc2_:Array = ["0000000000000000","74657374206d652e"];
         var _loc3_:Array = ["2dc7e8d3695b0538","7909582138198783"];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = Hex.toArray(_loc1_[_loc4_]);
            _loc6_ = Hex.toArray(_loc2_[_loc4_]);
            _loc7_ = new XTeaKey(_loc5_);
            _loc7_.encrypt(_loc6_);
            _loc8_ = Hex.fromArray(_loc6_);
            assert("comparing " + _loc3_[_loc4_] + " to " + _loc8_,_loc3_[_loc4_] == _loc8_);
            _loc6_.position = 0;
            _loc7_.decrypt(_loc6_);
            _loc8_ = Hex.fromArray(_loc6_);
            assert("comparing " + _loc2_[_loc4_] + " to " + _loc8_,_loc2_[_loc4_] == _loc8_);
            _loc4_++;
         }
      }
   }
}

