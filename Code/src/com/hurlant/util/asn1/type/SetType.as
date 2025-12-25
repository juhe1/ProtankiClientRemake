package com.hurlant.util.asn1.type
{
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class SetType extends ASN1Type
   {
      
      registerClassAlias("com.hurlant.util.asn1.SetType",SetType);
      
      public var childType:ASN1Type;
      
      public function SetType(param1:ASN1Type = null)
      {
         super(ASN1Type.SET);
         this.childType = param1;
      }
      
      override protected function fromDERContent(param1:ByteArray, param2:int) : *
      {
         var _loc5_:Array = null;
         var _loc6_:* = undefined;
         var _loc3_:int = int(param1.position);
         var _loc4_:int = param2;
         _loc5_ = [];
         while(_loc4_ > 0)
         {
            _loc6_ = this.childType.fromDER(param1,_loc4_);
            if(_loc6_ == null)
            {
               throw new Error("couldn\'t parse DER stream.");
            }
            _loc5_.push(_loc6_);
            _loc4_ = param2 - param1.position + _loc3_;
         }
         return _loc5_;
      }
   }
}

