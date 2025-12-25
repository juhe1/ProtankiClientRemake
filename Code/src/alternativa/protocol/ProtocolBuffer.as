package alternativa.protocol
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ProtocolBuffer
   {
      private var newname_614__END:IDataOutput;
      
      private var newname_615__END:IDataInput;
      
      private var newname_616__END:OptionalMap;
      
      public function ProtocolBuffer(param1:IDataOutput, param2:IDataInput, param3:OptionalMap)
      {
         super();
         this.newname_614__END = param1;
         this.newname_615__END = param2;
         this.newname_616__END = param3;
      }
      
      public function get writer() : IDataOutput
      {
         return this.newname_614__END;
      }
      
      public function set writer(param1:IDataOutput) : void
      {
         this.newname_614__END = param1;
      }
      
      public function get reader() : IDataInput
      {
         return this.newname_615__END;
      }
      
      public function set reader(param1:IDataInput) : void
      {
         this.newname_615__END = param1;
      }
      
      public function get optionalMap() : OptionalMap
      {
         return this.newname_616__END;
      }
      
      public function set optionalMap(param1:OptionalMap) : void
      {
         this.newname_616__END = param1;
      }
      
      public function toString() : String
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         return "";
      }
   }
}

