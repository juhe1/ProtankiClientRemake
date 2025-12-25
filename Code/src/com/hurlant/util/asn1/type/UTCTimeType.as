package com.hurlant.util.asn1.type
{
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class UTCTimeType extends ASN1Type
   {
      
      registerClassAlias("com.hurlant.util.asn1.UTCTime",UTCTimeType);
      
      public function UTCTimeType()
      {
         super(ASN1Type.UTC_TIME);
      }
      
      override protected function fromDERContent(param1:ByteArray, param2:int) : *
      {
         var _loc3_:String = param1.readMultiByte(param2,"US-ASCII");
         var _loc4_:uint = parseInt(_loc3_.substr(0,2));
         if(_loc4_ < 50)
         {
            _loc4_ += 2000;
         }
         else
         {
            _loc4_ += 1900;
         }
         var _loc5_:uint = parseInt(_loc3_.substr(2,2));
         var _loc6_:uint = parseInt(_loc3_.substr(4,2));
         var _loc7_:uint = parseInt(_loc3_.substr(6,2));
         var _loc8_:uint = parseInt(_loc3_.substr(8,2));
         return new Date(_loc4_,_loc5_ - 1,_loc6_,_loc7_,_loc8_);
      }
   }
}

