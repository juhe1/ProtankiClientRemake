package com.hurlant.util.asn1.type
{
   import com.hurlant.math.BigInteger;
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class IntegerType extends ASN1Type
   {
      
      registerClassAlias("com.hurlant.util.asn1.IntegerType",IntegerType);
      
      public function IntegerType()
      {
         super(ASN1Type.INTEGER);
      }
      
      override protected function fromDERContent(param1:ByteArray, param2:int) : *
      {
         var _loc3_:int = int(param1.position);
         var _loc4_:int = param2;
         var _loc5_:ByteArray = new ByteArray();
         param1.readBytes(_loc5_,0,param2);
         _loc5_.position = 0;
         var _loc6_:BigInteger = new BigInteger(_loc5_);
         if(_loc6_.bitLength() < 31)
         {
            return _loc6_.intValue();
         }
         return _loc6_;
      }
   }
}

