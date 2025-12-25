package com.hurlant.util.asn1.type
{
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class SequenceType extends ASN1Type
   {
      
      registerClassAlias("com.hurlant.util.asn1.SequenceType",SequenceType);
      
      public var children:Array;
      
      public var childType:ASN1Type;
      
      public function SequenceType(param1:* = null)
      {
         super(ASN1Type.SEQUENCE);
         if(param1 is Array)
         {
            this.children = param1 as Array;
         }
         else
         {
            this.childType = param1 as ASN1Type;
         }
      }
      
      override protected function fromDERContent(param1:ByteArray, param2:int) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:ASN1Type = null;
         var _loc11_:ByteArray = null;
         var _loc3_:int = int(param1.position);
         var _loc4_:int = param2;
         if(this.children != null)
         {
            _loc5_ = {};
            _loc7_ = 0;
            while(_loc7_ < this.children.length)
            {
               for(_loc8_ in this.children[_loc7_])
               {
                  _loc9_ = int(param1.position);
                  _loc4_ = param2 - _loc9_ + _loc3_;
                  _loc10_ = this.children[_loc7_][_loc8_];
                  _loc6_ = _loc10_.fromDER(param1,_loc4_);
                  if(_loc6_ == null)
                  {
                     if(!_loc10_.optional)
                     {
                        param1.position = _loc3_;
                        return null;
                     }
                  }
                  else
                  {
                     _loc5_[_loc8_] = _loc6_;
                     if(_loc10_.extract)
                     {
                        _loc11_ = new ByteArray();
                        _loc11_.writeBytes(param1,_loc9_,param1.position - _loc9_);
                        _loc5_[_loc8_ + "_bin"] = _loc11_;
                     }
                  }
               }
               _loc7_++;
            }
            return _loc5_;
         }
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

