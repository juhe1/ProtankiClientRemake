package alternativa.tanks.battle.objects.tank
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   
   public class LocalHullTransformUpdater implements HullTransformUpdater
   {
      
      private static const position:Vector3 = new Vector3();
      
      private static const eulerAngles:Vector3 = new Vector3();
      
      private static const m3:Matrix3 = new Matrix3();
      
      public var tank:Tank;
      
      public function LocalHullTransformUpdater(param1:Tank)
      {
         super();
         this.tank = param1;
      }
      
      public function reset() : void
      {
      }
      
      public function update(param1:Number) : void
      {
         this.tank.interpolatedOrientation.toMatrix3(m3);
         position.copy(this.tank.skinCenterOffset);
         position.transform3(m3);
         position.add(this.tank.interpolatedPosition);
         this.tank.interpolatedOrientation.getEulerAngles(eulerAngles);
         this.tank.getSkin().updateHullTransform(position,eulerAngles);
      }
   }
}

