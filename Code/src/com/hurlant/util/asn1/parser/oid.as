package com.hurlant.util.asn1.parser
{
   import com.hurlant.util.asn1.type.OIDType;
   
   public function oid(... rest) : OIDType
   {
      var _loc2_:String = rest.length > 0 ? rest.join(".") : null;
      return new OIDType(_loc2_);
   }
}

