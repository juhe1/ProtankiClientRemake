package com.hurlant.util.asn1.type
{
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class BitStringType extends ASN1Type
   {
      
      registerClassAlias("com.hurlant.util.asn1.BitStringType",BitStringType);
      
      public function BitStringType()
      {
         super(ASN1Type.BIT_STRING);
      }
      
      override protected function fromDERContent(param1:ByteArray, param2:int) : *
      {
         param1.readUnsignedByte();
         var _loc3_:ByteArray = new ByteArray();
         param1.readBytes(_loc3_,0,param2 - 1);
         return _loc3_;
      }
   }
}

