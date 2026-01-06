package alternativa.tanks.battle.objects.tank
{
   import alternativa.math.Matrix3;
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.BodyState;
   import alternativa.tanks.utils.EncryptedNumber;
   import alternativa.tanks.utils.EncryptedNumberImpl;
   
   public class RemoteHullTransformUpdater implements HullTransformUpdater
   {
      
      private static const position:Vector3 = new Vector3();
      
      private static const m3:Matrix3 = new Matrix3();
      
      private static const SMOOTHING_COEFF:EncryptedNumber = new EncryptedNumberImpl(Math.PI / 10.4719);
      
      private static const smoothedEulerAngles:Vector3 = new Vector3();
      
      private const smoothedPosition:Vector3 = new Vector3();
      
      private const smoothedOrientation:Quaternion = new Quaternion();
      
      private var tank:Tank;
      
      public function RemoteHullTransformUpdater(param1:Tank)
      {
         super();
         this.tank = param1;
      }
      
      private static function smoothValue(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         param1 += param2 * param3;
         return param1 + (param4 - param1) * param5;
      }
      
      public function reset() : void
      {
         var _loc1_:BodyState = this.tank.getBody().prevState;
         this.smoothedPosition.copy(_loc1_.position);
         this.smoothedOrientation.copy(_loc1_.orientation);
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Body = this.tank.getBody();
         var _loc3_:BodyState = _loc2_.prevState;
         var _loc4_:Vector3 = _loc3_.velocity;
         var _loc5_:Vector3 = this.tank.interpolatedPosition;
         var _loc6_:Number = Number(SMOOTHING_COEFF.getNumber());
         this.smoothedPosition.x = smoothValue(this.smoothedPosition.x,_loc4_.x,param1,_loc5_.x,_loc6_);
         this.smoothedPosition.y = smoothValue(this.smoothedPosition.y,_loc4_.y,param1,_loc5_.y,_loc6_);
         this.smoothedPosition.z = smoothValue(this.smoothedPosition.z,_loc4_.z,param1,_loc5_.z,_loc6_);
         var _loc7_:Vector3 = _loc3_.angularVelocity;
         this.smoothedOrientation.addScaledVector(_loc7_,param1);
         this.smoothedOrientation.slerp(this.smoothedOrientation,this.tank.interpolatedOrientation,_loc6_);
         this.smoothedOrientation.getEulerAngles(smoothedEulerAngles);
         this.smoothedOrientation.toMatrix3(m3);
         position.copy(this.tank.skinCenterOffset);
         position.transform3(m3);
         position.add(this.smoothedPosition);
         this.tank.getSkin().updateHullTransform(position,smoothedEulerAngles);
      }
   }
}

