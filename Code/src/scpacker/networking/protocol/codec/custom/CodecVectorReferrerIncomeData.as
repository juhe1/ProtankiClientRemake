package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.panel.model.referrals.ReferralIncomeData;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecVectorReferrerIncomeData implements ICodec
   {
      private var elementCodec:ICodec;
      
      public function CodecVectorReferrerIncomeData(param1:ProtocolInitializer)
      {
         super();
         this.elementCodec = param1.getCodec("scpacker.networking.protocol.codec.custom.CodecReferrerIncomeData");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:int = param1.readInt();
         var _loc3_:Vector.<ReferralIncomeData> = new Vector.<ReferralIncomeData>(_loc2_,true);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = ReferralIncomeData(this.elementCodec.decode(param1));
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc5_:Vector.<ReferralIncomeData> = Vector.<ReferralIncomeData>(param2);
         var _loc6_:int = int(_loc5_.length);
         param1.writeInt(_loc6_);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc6_)
         {
            _loc3_ += this.elementCodec.encode(param1,_loc5_[_loc4_]);
            _loc4_++;
         }
         return _loc3_;
      }
   }
}

