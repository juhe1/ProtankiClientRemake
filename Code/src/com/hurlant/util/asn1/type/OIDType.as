package com.hurlant.util.asn1.type
{
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class OIDType extends ASN1Type
   {
      
      registerClassAlias("com.hurlant.util.asn1.OIDType",OIDType);
      
      public var oid:String = null;
      
      public function OIDType(param1:String = null)
      {
         super(ASN1Type.OID);
         this.oid = param1;
      }
      
      public function toString() : String
      {
         return this.oid;
      }
      
      override protected function fromDERContent(param1:ByteArray, param2:int) : *
      {
         var _loc9_:Boolean = false;
         var _loc3_:int = int(param1.position);
         var _loc4_:uint = param1.readUnsignedByte();
         var _loc5_:int = param2 - 1;
         var _loc6_:Array = [];
         _loc6_.push(uint(_loc4_ / 40));
         _loc6_.push(uint(_loc4_ % 40));
         var _loc7_:uint = 0;
         while(_loc5_-- > 0)
         {
            _loc4_ = param1.readUnsignedByte();
            _loc9_ = (_loc4_ & 0x80) == 0;
            _loc4_ &= 127;
            _loc7_ = _loc7_ * 128 + _loc4_;
            if(_loc9_)
            {
               _loc6_.push(_loc7_);
               _loc7_ = 0;
            }
         }
         var _loc8_:String = _loc6_.join(".");
         if(this.oid != null)
         {
            if(this.oid == _loc8_)
            {
               return this.clone();
            }
            param1.position = _loc3_;
            return null;
         }
         return new OIDType(_loc8_);
      }
   }
}

