package com.hurlant.crypto.tests
{
   import com.hurlant.crypto.rsa.RSAKey;
   import com.hurlant.util.Hex;
   import com.hurlant.util.der.PEM;
   import flash.utils.ByteArray;
   
   public class RSAKeyTest extends TestCase
   {
      
      public function RSAKeyTest(param1:ITestHarness)
      {
         super(param1,"RSA Testing");
         runTest(this.testSmoke,"RSA smoke test");
         runTest(this.testGenerate,"RSA Key Generation test");
         runTest(this.testPEM,"RSA Private Key PEM parsing");
         runTest(this.testPEM2,"RSA Public Key PEM parsing");
         runTest(this.testAdobeSample,"RSA sample code from Adobe article");
         runTest(this.testLongText,"RSA long text encryption/decryption");
         param1.endTestCase();
      }
      
      public function testSmoke() : void
      {
         var _loc1_:String = "C4E3F7212602E1E396C0B6623CF11D26204ACE3E7D26685E037AD2507DCE82FC" + "28F2D5F8A67FC3AFAB89A6D818D1F4C28CFA548418BD9F8E7426789A67E73E41";
         var _loc2_:String = "10001";
         var _loc3_:String = "7cd1745aec69096129b1f42da52ac9eae0afebbe0bc2ec89253598dcf454960e" + "3e5e4ec9f8c87202b986601dd167253ee3fb3fa047e14f1dfd5ccd37e931b29d";
         var _loc4_:String = "f0e4dd1eac5622bd3932860fc749bbc48662edabdf3d2826059acc0251ac0d3b";
         var _loc5_:String = "d13cb38fbcd06ee9bca330b4000b3dae5dae12b27e5173e4d888c325cda61ab3";
         var _loc6_:String = "b3d5571197fc31b0eb6b4153b425e24c033b054d22b9c8282254fe69d8c8c593";
         var _loc7_:String = "968ffe89e50d7b72585a79b65cfdb9c1da0963cceb56c3759e57334de5a0ac3f";
         var _loc8_:String = "d9bc4f420e93adad9f007d0e5744c2fe051c9ed9d3c9b65f439a18e13d6e3908";
         var _loc9_:RSAKey = RSAKey.parsePrivateKey(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
         var _loc10_:String = "hello";
         var _loc11_:ByteArray = Hex.toArray(Hex.fromString(_loc10_));
         var _loc12_:ByteArray = new ByteArray();
         var _loc13_:ByteArray = new ByteArray();
         _loc9_.encrypt(_loc11_,_loc12_,_loc11_.length);
         _loc9_.decrypt(_loc12_,_loc13_,_loc12_.length);
         var _loc14_:String = Hex.toString(Hex.fromArray(_loc13_));
         assert("rsa encrypt+decrypt",_loc10_ == _loc14_);
      }
      
      public function testGenerate() : void
      {
         var _loc1_:RSAKey = RSAKey.generate(256,"10001");
         var _loc2_:String = "hello";
         var _loc3_:ByteArray = Hex.toArray(Hex.fromString(_loc2_));
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:ByteArray = new ByteArray();
         _loc1_.encrypt(_loc3_,_loc4_,_loc3_.length);
         _loc1_.decrypt(_loc4_,_loc5_,_loc4_.length);
         var _loc6_:String = Hex.toString(Hex.fromArray(_loc5_));
         assert("rsa encrypt+decrypt",_loc2_ == _loc6_);
      }
      
      public function testPEM() : void
      {
         var _loc1_:String = "-----BEGIN RSA PRIVATE KEY-----\n" + "MGQCAQACEQDJG3bkuB9Ie7jOldQTVdzPAgMBAAECEQCOGqcPhP8t8mX8cb4cQEaR\n" + "AgkA5WTYuAGmH0cCCQDgbrto0i7qOQIINYr5btGrtccCCQCYy4qX4JDEMQIJAJll\n" + "OnLVtCWk\n" + "-----END RSA PRIVATE KEY-----";
         var _loc2_:RSAKey = PEM.readRSAPrivateKey(_loc1_);
         var _loc3_:String = "hello";
         var _loc4_:ByteArray = Hex.toArray(Hex.fromString(_loc3_));
         var _loc5_:ByteArray = new ByteArray();
         var _loc6_:ByteArray = new ByteArray();
         _loc2_.encrypt(_loc4_,_loc5_,_loc4_.length);
         _loc2_.decrypt(_loc5_,_loc6_,_loc5_.length);
         var _loc7_:String = Hex.toString(Hex.fromArray(_loc6_));
         assert("rsa encrypt+decrypt",_loc3_ == _loc7_);
      }
      
      public function testPEM2() : void
      {
         var _loc1_:String = "-----BEGIN PUBLIC KEY-----\n" + "MCwwDQYJKoZIhvcNAQEBBQADGwAwGAIRAMkbduS4H0h7uM6V1BNV3M8CAwEAAQ==\n" + "-----END PUBLIC KEY-----";
         var _loc2_:RSAKey = PEM.readRSAPublicKey(_loc1_);
         assert("rsa!=null",_loc2_ != null);
      }
      
      public function testAdobeSample() : void
      {
         var _loc1_:String = "-----BEGIN PUBLIC KEY-----" + "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBALHpyYTN96rMbkQB" + "gIoB9vH2AN47NN1YXoKxAaqpEkafQdPUw41p4gTrA0r04acE" + "m3GaWUA4YROCSKgJnvii0UsCAwEAAQ==" + "-----END PUBLIC KEY-----";
         var _loc2_:ByteArray = Hex.toArray(Hex.fromString("MyInputString"));
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:RSAKey = PEM.readRSAPublicKey(_loc1_);
         _loc4_.encrypt(_loc2_,_loc3_,_loc2_.length);
         var _loc5_:String = Hex.fromArray(_loc3_);
         assert("encrypted some stuff",_loc5_.length > 5);
      }
      
      public function testLongText() : void
      {
         var _loc1_:String = "-----BEGIN RSA PRIVATE KEY-----\n" + "MGQCAQACEQDJG3bkuB9Ie7jOldQTVdzPAgMBAAECEQCOGqcPhP8t8mX8cb4cQEaR\n" + "AgkA5WTYuAGmH0cCCQDgbrto0i7qOQIINYr5btGrtccCCQCYy4qX4JDEMQIJAJll\n" + "OnLVtCWk\n" + "-----END RSA PRIVATE KEY-----";
         var _loc2_:RSAKey = PEM.readRSAPrivateKey(_loc1_);
         var _loc3_:String = "With each new release" + "of Flash Player, Adobe strives to introduce a stronger platform with" + "more robust security controls and tools for creating secure" + "applications. By leveraging those tools, compiling for recent" + "versions, performing data validation, and leveraging available SDKs," + "developers can produce more secure applications that run in Flash" + "Player.";
         var _loc4_:ByteArray = Hex.toArray(Hex.fromString(_loc3_));
         var _loc5_:ByteArray = new ByteArray();
         var _loc6_:ByteArray = new ByteArray();
         _loc2_.encrypt(_loc4_,_loc5_,_loc4_.length);
         _loc2_.decrypt(_loc5_,_loc6_,_loc5_.length);
         var _loc7_:String = Hex.toString(Hex.fromArray(_loc6_));
         assert("rsa long text encrypt+decrypt",_loc3_ == _loc7_);
      }
   }
}

