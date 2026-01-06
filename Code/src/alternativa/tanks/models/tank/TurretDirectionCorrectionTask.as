package alternativa.tanks.models.tank
{
   import alternativa.tanks.battle.BattleRunnerProvider;
   import alternativa.tanks.battle.PostPhysicsController;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import alternativa.tanks.utils.MathUtils;
   import platform.client.fp10.core.type.IGameObject;
   
   public class TurretDirectionCorrectionTask extends BattleRunnerProvider implements PostPhysicsController
   {
      
      private static const MAX_INTERVAL_MS:EncryptedInt = new EncryptedIntImpl(2000);
      
      private static const MAX_DIRECTION_DIFFERENCE_ANGLE:Number = Math.PI / 6;
      
      private var tank:Tank;
      
      private var lastCorrectionTime:int;
      
      private var lastCorrectionDirection:Number;
      
      public function TurretDirectionCorrectionTask(param1:Tank)
      {
         super();
         this.tank = param1;
      }
      
      public function reset() : void
      {
         this.lastCorrectionTime = getBattleRunner().getPhysicsTime();
         this.lastCorrectionDirection = this.tank.getTurretDirection();
      }
      
      public function runAfterPhysicsUpdate(param1:Number) : void
      {
         if(this.needRegularCorrection())
         {
            this.sendCorrection(false);
         }
         else if(this.needMandatoryCorrection())
         {
            this.sendCorrection(true);
         }
      }
      
      private function needRegularCorrection() : Boolean
      {
         return this.itsTimeToUpdate();
      }
      
      private function needMandatoryCorrection() : Boolean
      {
         return this.criticalAnglePassed();
      }
      
      private function criticalAnglePassed() : Boolean
      {
         var _loc1_:Number = Math.abs(MathUtils.clampAngle(this.tank.getTurretDirection() - this.lastCorrectionDirection));
         return _loc1_ > MAX_DIRECTION_DIFFERENCE_ANGLE;
      }
      
      private function itsTimeToUpdate() : Boolean
      {
         return getBattleRunner().getPhysicsTime() - this.lastCorrectionTime > MAX_INTERVAL_MS.getInt();
      }
      
      private function sendCorrection(param1:Boolean) : void
      {
         this.reset();
         var _loc2_:IGameObject = this.tank.getUser();
         ITankModel(_loc2_.adapt(ITankModel)).onTurretDirectionCorrection(param1);
      }
   }
}

