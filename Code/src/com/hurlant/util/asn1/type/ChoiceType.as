package com.hurlant.util.asn1.type
{
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class ChoiceType extends ASN1Type
   {
      
      registerClassAlias("com.hurlant.util.asn1.ChoiceType",ChoiceType);
      
      public var choices:Array;
      
      public function ChoiceType(param1:Array = null)
      {
         super(ASN1Type.CHOICE);
         this.choices = param1;
      }
      
      override public function fromDER(param1:ByteArray, param2:int) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:ASN1Type = null;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc3_:int = 0;
         while(_loc3_ < this.choices.length)
         {
            _loc4_ = this.choices[_loc3_];
            for(_loc5_ in _loc4_)
            {
               _loc6_ = _loc4_[_loc5_];
               _loc7_ = _loc6_.fromDER(param1,param2);
               if(_loc7_ != null)
               {
                  _loc8_ = {};
                  _loc8_[_loc5_] = _loc7_;
                  return _loc8_;
               }
            }
            _loc3_++;
         }
         return null;
      }
   }
}

