package scpacker.networking.protocol.codec.custom
{
   import flash.utils.ByteArray;
   import projects.tanks.client.panel.model.premiumaccount.alert.PremiumAccountAlertCC;
   import scpacker.networking.protocol.ProtocolInitializer;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecPremiumAccountAlertCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = PremiumAccountAlertCC;
      
      private var newname_4423__END:ICodec;
      
      private var newname_4424__END:ICodec;
      
      private var newname_4425__END:ICodec;
      
      private var newname_4426__END:ICodec;
      
      private var newname_4427__END:ICodec;
      
      public function CodecPremiumAccountAlertCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4423__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4424__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4425__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4426__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
         this.newname_4427__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.BooleanCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:PremiumAccountAlertCC = new PremiumAccountAlertCC();
         _loc2_.needShowNotificationCompletionPremium = this.newname_4423__END.decode(param1) as Boolean;
         _loc2_.needShowWelcomeAlert = this.newname_4424__END.decode(param1) as Boolean;
         _loc2_.reminderCompletionPremiumTime = this.newname_4425__END.decode(param1) as Number;
         _loc2_.wasShowAlertForFirstPurchasePremium = this.newname_4426__END.decode(param1) as Boolean;
         _loc2_.wasShowReminderCompletionPremium = this.newname_4427__END.decode(param1) as Boolean;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:PremiumAccountAlertCC = PremiumAccountAlertCC(param2);
         this.newname_4423__END.encode(param1,_loc3_.needShowNotificationCompletionPremium);
         this.newname_4424__END.encode(param1,_loc3_.needShowWelcomeAlert);
         this.newname_4425__END.encode(param1,_loc3_.reminderCompletionPremiumTime);
         this.newname_4426__END.encode(param1,_loc3_.wasShowAlertForFirstPurchasePremium);
         this.newname_4427__END.encode(param1,_loc3_.wasShowReminderCompletionPremium);
         return 4;
      }
   }
}

