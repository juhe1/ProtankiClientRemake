package scpacker.networking.protocol.codec
{
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class VectorCodec extends OptionalCodec implements ICodec
   {
      private static const newname_4090__END:String = getQualifiedClassName(Vector);
      
      private var elementCodec:ICodec;
      
      private var newname_4091__END:Boolean;
      
      private var newname_4092__END:Class;
      
      public function VectorCodec(param1:ICodec, param2:Class, param3:Boolean = false)
      {
         super();
         this.elementCodec = param1;
         this.newname_4091__END = param3;
         this.newname_4092__END = getDefinitionByName(newname_4090__END + ".<" + getQualifiedClassName(param2) + ">") as Class;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         var _loc4_:int = 0;
         if(this.newname_4091__END && addBool(param1,param2))
         {
            return 1;
         }
         var _loc3_:int = int(param2.length);
         var _loc5_:int = this.newname_4091__END ? 1 : 0;
         param1.writeInt(_loc3_);
         while(_loc4_ < _loc3_)
         {
            _loc5_ += this.elementCodec.encode(param1,param2[_loc4_]);
            _loc4_++;
         }
         return _loc5_ + 4;
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc4_:int = 0;
         if(this.newname_4091__END && getBool(param1))
         {
            return null;
         }
         var _loc3_:int = param1.readInt();
         var _loc2_:* = new newname_4092__END(_loc3_,true);
         while(_loc4_ < _loc3_)
         {
            _loc2_[_loc4_] = this.elementCodec.decode(param1);
            _loc4_++;
         }
         return _loc2_;
      }
   }
}

