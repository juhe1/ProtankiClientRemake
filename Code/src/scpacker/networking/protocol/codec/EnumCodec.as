package scpacker.networking.protocol.codec
{
   import avmplus.describeTypeObject;
   import flash.utils.ByteArray;
   
   public class EnumCodec implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public var element:Class;
      
      private var newname_4089__END:Array = [];
      
      public function EnumCodec(param1:Class)
      {
         super();
         var _loc3_:Object = describeTypeObject(param1,0x0100 | 8);
         for each(var _loc2_ in _loc3_.traits.variables)
         {
            this.newname_4089__END[param1[_loc2_.name].value] = param1[_loc2_.name];
         }
         this.element = param1;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         param1.writeInt(param2.value);
         return 1;
      }
      
      public function decode(param1:ByteArray) : Object
      {
         return this.newname_4089__END[param1.readInt()];
      }
   }
}

