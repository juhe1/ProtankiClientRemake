package com.hurlant.util.asn1.parser
{
   import com.hurlant.util.asn1.type.ASN1Type;
   import com.hurlant.util.asn1.type.ChoiceType;
   
   public function choice(... rest) : ASN1Type
   {
      var _loc2_:Array = [];
      var _loc3_:int = 0;
      while(_loc3_ < rest.length)
      {
         _loc2_[_loc3_] = rest[_loc3_];
         _loc3_++;
      }
      return new ChoiceType(_loc2_);
   }
}

