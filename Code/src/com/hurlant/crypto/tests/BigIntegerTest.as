package com.hurlant.crypto.tests
{
   import com.hurlant.math.BigInteger;
   import flash.utils.ByteArray;
   
   public class BigIntegerTest extends TestCase
   {
      
      public function BigIntegerTest(param1:ITestHarness)
      {
         super(param1,"BigInteger Tests");
         runTest(this.testAdd,"BigInteger Addition");
         runTest(this.testSigned,"BigInteger Signed number conversion");
         runTest(this.testSigned2,"BigInteger to Number: signed numbers");
         param1.endTestCase();
      }
      
      public function testAdd() : void
      {
         var _loc1_:BigInteger = BigInteger.nbv(25);
         var _loc2_:BigInteger = BigInteger.nbv(1002);
         var _loc3_:BigInteger = _loc1_.add(_loc2_);
         var _loc4_:int = _loc3_.valueOf();
         assert("25+1002 = " + _loc4_,25 + 1002 == _loc4_);
         var _loc5_:BigInteger = new BigInteger("e564d8b801a61f47",16,true);
         var _loc6_:BigInteger = new BigInteger("99246db2a3507fa",16,true);
         _loc6_ = _loc6_.add(_loc5_);
         assert("xp==eef71f932bdb2741",_loc6_.toString(16) == "eef71f932bdb2741");
      }
      
      public function testSigned() : void
      {
         var _loc1_:BigInteger = new BigInteger("1");
         var _loc2_:BigInteger = new BigInteger("2");
         var _loc3_:BigInteger = _loc1_.subtract(_loc2_);
         var _loc4_:ByteArray = _loc3_.toByteArray();
         var _loc5_:BigInteger = new BigInteger(_loc4_);
         var _loc6_:ByteArray = _loc5_.toByteArray();
         var _loc7_:Boolean = _loc3_.equals(_loc5_);
         assert("arr_i3.length==1",_loc4_.length == 1);
         assert("arr_i4.length==1",_loc6_.length == 1);
         assert("-1 == BigInteger(ByteArray(-1))",_loc3_.equals(_loc5_));
      }
      
      public function testSigned2() : void
      {
         var _loc1_:BigInteger = BigInteger.nbv(-13);
         assert("i1==-13",_loc1_.valueOf() == -13);
      }
   }
}

