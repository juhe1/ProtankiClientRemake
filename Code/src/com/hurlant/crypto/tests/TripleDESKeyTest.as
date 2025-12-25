package com.hurlant.crypto.tests
{
   import com.hurlant.crypto.symmetric.TripleDESKey;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class TripleDESKeyTest extends TestCase
   {
      
      public function TripleDESKeyTest(param1:ITestHarness)
      {
         super(param1,"Triped Des Test");
         runTest(this.testECB,"Triple DES ECB Test Vectors");
         param1.endTestCase();
      }
      
      public function testECB() : void
      {
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:TripleDESKey = null;
         var _loc8_:String = null;
         var _loc1_:Array = ["010101010101010101010101010101010101010101010101","dd24b3aafcc69278d650dad234956b01e371384619492ac4"];
         var _loc2_:Array = ["8000000000000000","F36B21045A030303"];
         var _loc3_:Array = ["95F8A5E5DD31D900","E823A43DEEA4D0A4"];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = Hex.toArray(_loc1_[_loc4_]);
            _loc6_ = Hex.toArray(_loc2_[_loc4_]);
            _loc7_ = new TripleDESKey(_loc5_);
            _loc7_.encrypt(_loc6_);
            _loc8_ = Hex.fromArray(_loc6_).toUpperCase();
            assert("comparing " + _loc3_[_loc4_] + " to " + _loc8_,_loc3_[_loc4_] == _loc8_);
            _loc7_.decrypt(_loc6_);
            _loc8_ = Hex.fromArray(_loc6_).toUpperCase();
            assert("comparing " + _loc2_[_loc4_] + " to " + _loc8_,_loc2_[_loc4_] == _loc8_);
            _loc4_++;
         }
      }
   }
}

