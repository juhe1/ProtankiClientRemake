package com.hurlant.crypto.tests
{
   import com.hurlant.crypto.prng.TLSPRF;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class TLSPRFTest extends TestCase
   {
      
      public function TLSPRFTest(param1:ITestHarness)
      {
         super(param1,"TLS-PRF Testing");
         runTest(this.testVector,"TLF-PRF Test Vector");
         param1.endTestCase();
      }
      
      private function testVector() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:uint = 0;
         while(_loc2_ < 48)
         {
            _loc1_[_loc2_] = 171;
            _loc2_++;
         }
         var _loc3_:String = "PRF Testvector";
         var _loc4_:ByteArray = new ByteArray();
         _loc2_ = 0;
         while(_loc2_ < 64)
         {
            _loc4_[_loc2_] = 205;
            _loc2_++;
         }
         var _loc5_:TLSPRF = new TLSPRF(_loc1_,_loc3_,_loc4_);
         var _loc6_:ByteArray = new ByteArray();
         _loc5_.nextBytes(_loc6_,104);
         var _loc7_:String = "D3 D4 D1 E3 49 B5 D5 15 04 46 66 D5 1D E3 2B AB" + "25 8C B5 21 B6 B0 53 46 3E 35 48 32 FD 97 67 54" + "44 3B CF 9A 29 65 19 BC 28 9A BC BC 11 87 E4 EB" + "D3 1E 60 23 53 77 6C 40 8A AF B7 4C BC 85 EF F6" + "92 55 F9 78 8F AA 18 4C BB 95 7A 98 19 D8 4A 5D" + "7E B0 06 EB 45 9D 3A E8 DE 98 10 45 4B 8B 2D 8F" + "1A FB C6 55 A8 C9 A0 13";
         var _loc8_:String = Hex.fromArray(Hex.toArray(_loc7_));
         assert("out == expected",Hex.fromArray(_loc6_) == _loc8_);
      }
   }
}

