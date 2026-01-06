package alternativa.tanks.models.tank.codec
{
   import alternativa.protocol.ICodec;
   import alternativa.protocol.IProtocol;
   import alternativa.protocol.ProtocolBuffer;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
   import projects.tanks.client.battlefield.types.Vector3d;
   
   public class MoveCommandCodec implements ICodec
   {
      
      private static const ANGLE_FACTOR:Number = Math.PI / 4096;
      
      private static const ANGULAR_VELOCITY_FACTOR:Number = 0.005;
      
      private static const CONTROL_MASK:int = 31;
      
      private static const POSITION_COMPONENT_BITSIZE:int = 17;
      
      private static const ORIENTATION_COMPONENT_BITSIZE:int = 13;
      
      private static const LINEAR_VELOCITY_COMPONENT_BITSIZE:int = 13;
      
      private static const ANGULAR_VELOCITY_COMPONENT_BITSIZE:int = 13;
      
      private static const BIT_AREA_SIZE:int = 21;
      
      public function MoveCommandCodec()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function init(param1:IProtocol) : void
      {
      }
      
      [Obfuscation(rename="false")]
      public function encode(param1:ProtocolBuffer, param2:Object) : void
      {
         var _loc3_:MoveCommand = MoveCommand(param2);
         var _loc4_:int = _loc3_.control & CONTROL_MASK;
         var _loc5_:int = (_loc3_.turnSpeedNumber & 7) << 5;
         param1.writer.writeByte(_loc4_ | _loc5_);
         var _loc6_:BitArea = new BitArea([],BIT_AREA_SIZE);
         this.writeVector3d(_loc6_,_loc3_.position,POSITION_COMPONENT_BITSIZE,1);
         this.writeVector3d(_loc6_,_loc3_.orientation,ORIENTATION_COMPONENT_BITSIZE,ANGLE_FACTOR);
         this.writeVector3d(_loc6_,_loc3_.linearVelocity,LINEAR_VELOCITY_COMPONENT_BITSIZE,1);
         this.writeVector3d(_loc6_,_loc3_.angularVelocity,ANGULAR_VELOCITY_COMPONENT_BITSIZE,ANGULAR_VELOCITY_FACTOR);
         this.writeArray(param1.writer,_loc6_.getData(),BIT_AREA_SIZE);
      }
      
      private function writeArray(param1:IDataOutput, param2:Array, param3:int) : void
      {
         var _loc4_:int = 0;
         while(_loc4_ < param3)
         {
            param1.writeByte(param2[_loc4_]);
            _loc4_++;
         }
      }
      
      [Obfuscation(rename="false")]
      public function decode(param1:ProtocolBuffer) : Object
      {
         var _loc2_:int = int(param1.reader.readByte());
         var _loc3_:int = _loc2_ & CONTROL_MASK;
         var _loc4_:int = _loc2_ >> 5 & 7;
         var _loc5_:BitArea = new BitArea(this.bytesToArray(param1.reader,BIT_AREA_SIZE),BIT_AREA_SIZE);
         var _loc6_:Vector3d = this.readVector3d(_loc5_,POSITION_COMPONENT_BITSIZE,1);
         var _loc7_:Vector3d = this.readVector3d(_loc5_,ORIENTATION_COMPONENT_BITSIZE,ANGLE_FACTOR);
         var _loc8_:Vector3d = this.readVector3d(_loc5_,LINEAR_VELOCITY_COMPONENT_BITSIZE,1);
         var _loc9_:Vector3d = this.readVector3d(_loc5_,ANGULAR_VELOCITY_COMPONENT_BITSIZE,ANGULAR_VELOCITY_FACTOR);
         return new MoveCommand(_loc9_,_loc3_,_loc8_,_loc7_,_loc6_,_loc4_);
      }
      
      private function bytesToArray(param1:IDataInput, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc3_[_loc4_] = param1.readByte();
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function readVector3d(param1:BitArea, param2:int, param3:Number) : Vector3d
      {
         var _loc4_:Number = (param1.read(param2) - (1 << param2 - 1)) * param3;
         var _loc5_:Number = (param1.read(param2) - (1 << param2 - 1)) * param3;
         var _loc6_:Number = (param1.read(param2) - (1 << param2 - 1)) * param3;
         return new Vector3d(_loc4_,_loc5_,_loc6_);
      }
      
      private function writeVector3d(param1:BitArea, param2:Vector3d, param3:int, param4:Number) : void
      {
         var _loc5_:int = 1 << param3 - 1;
         param1.write(param3,this.prepareValue(param2.x,_loc5_,param4));
         param1.write(param3,this.prepareValue(param2.y,_loc5_,param4));
         param1.write(param3,this.prepareValue(param2.z,_loc5_,param4));
      }
      
      private function prepareValue(param1:Number, param2:int, param3:Number) : int
      {
         var _loc4_:int = int(param1 / param3);
         var _loc5_:int = _loc4_ < -param2 ? 0 : _loc4_ - param2;
         return int(Math.min(param2,_loc5_));
      }
   }
}

