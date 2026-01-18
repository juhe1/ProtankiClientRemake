package scpacker.networking.protocol
{
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class AbstractPacket
   {
      public static var protocolInitializer:ProtocolInitializer;
      
      private static var payloadBuffer:ByteArray = new ByteArray();
      
      private var packetLength:int = 8;
      
      private var propertyCodecs:Vector.<ICodec> = new Vector.<ICodec>();
      
      private var propertyValues:Vector.<Object>;
      
      public function AbstractPacket()
      {
         super();
      }
      
      public function wrap(param1:ByteArray) : void
      {
         var _loc3_:int = 0;
         param1.position = 4;
         param1.writeInt(this.getId());
         var _loc2_:int = int(this.propertyCodecs.length);
         while(_loc3_ < _loc2_)
         {
            var codec:ICodec = this.propertyCodecs[_loc3_];
            if(codec == null)
            {
               throw new Error("Codec is not registered for property index " + _loc3_);
            }
            codec.encode(payloadBuffer,this.propertyValues[_loc3_]);
            _loc3_++;
         }
         protocolInitializer.getProtection().encrypt(payloadBuffer);
         param1.writeBytes(payloadBuffer);
         this.packetLength = 8 + payloadBuffer.length;
         payloadBuffer.clear();
         param1.position = 0;
         param1.writeInt(packetLength);
      }
      
      public function unwrap(param1:ByteArray) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         param1.position = 0;
         var _loc2_:int = int(this.propertyCodecs.length);
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.propertyCodecs[_loc3_].decode(param1);
            this.writeToPropertyByIndex(_loc4_,_loc3_);
            _loc3_++;
         }
      }
      
      public function registerProperty(param1:Object) : void
      {
         if(propertyValues == null)
         {
            propertyValues = new Vector.<Object>();
         }
         this.propertyValues[propertyValues.length] = param1;
      }
      
      public function registerPropertyCodec(param1:String) : void
      {
         this.propertyCodecs[propertyCodecs.length] = protocolInitializer.getCodec(param1);
      }
      
      public function getPacketLength() : int
      {
         return this.packetLength;
      }
      
      public function initializeSelf() : AbstractPacket
      {
         throw new Error("AbstractPacket::getReference must be overrided!");
      }
      
      public function writeToPropertyByIndex(param1:Object, param2:int) : void
      {
         throw new Error("Not implemented");
      }
      
      public function getPacketHandlerId() : int
      {
         return 0;
      }
      
      public function getId() : int
      {
         return 0;
      }
      
      public function toString() : String
      {
         return "";
      }
   }
}

