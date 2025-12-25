package com.hurlant.util.asn1.type
{
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class OctetStringType extends ASN1Type
   {
      
      registerClassAlias("com.hurlant.util.asn1.parser.OctetStringType",OctetStringType);
      
      public function OctetStringType()
      {
         super(ASN1Type.OCTET_STRING);
      }
      
      override protected function fromDERContent(param1:ByteArray, param2:int) : *
      {
         var _loc3_:ByteArray = new ByteArray();
         param1.readBytes(_loc3_,0,param2);
         return _loc3_;
      }
   }
}

