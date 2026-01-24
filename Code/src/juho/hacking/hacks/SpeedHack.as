package juho.hacking.hacks {
   import juho.hacking.Hack;
   import juho.hacking.event.HackEventDispatcher;
   import juho.hacking.event.LocalTankUnloadedEvent;
   import juho.hacking.event.LocalTankInitedEvent;
   import juho.hacking.event.TankSpecificationsChangedEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   
   public class SpeedHack extends Hack {
  
      private static const NAME:String = "Speed Hack";
      
      // ID is used in saving to disk
      private static const ID:String = "SPEED_HACK";
      
      private var localTank:Tank;
      
      public function SpeedHack() {
         super(NAME, ID);
         
         this.addProperty("Speed", 1000.0, "Number", speedChanged);
         this.addProperty("Turn speed", 1000.0, "Number", speedChanged);
         this.addProperty("Turret rotation speed", 3.0, "Number", speedChanged);
         this.addProperty("Turret accelaration", 2.0, "Number", speedChanged);
         this.addProperty("Accelaration", 1000.0, "Number", speedChanged);
         this.addProperty("Turn accelaration", 1000.0, "Number", speedChanged);
         HackEventDispatcher.singleton.addEventListener(LocalTankInitedEvent.LOCAL_TANK_INITED, this.localTankInited);
         HackEventDispatcher.singleton.addEventListener(LocalTankUnloadedEvent.LOCAL_TANK_UNLOADED_EVENT, this.localTankDestroyed);
         HackEventDispatcher.singleton.addEventListener(TankSpecificationsChangedEvent.TANK_SPECIFICATIONS_CHANGED_EVENT, this.tankSpecificationsChanged);
      }
      
      override public function enable():void {
         super.enable();
         this.setSpeed();
      }
      
      override public function disable():void {
         super.disable();
      }
      
      private function speedChanged(value:*):void {
         this.setSpeed();
      }
      
      private function localTankInited(e:LocalTankInitedEvent) : void {
         this.localTank = e.localTank;
      }
      
      private function localTankDestroyed(e:LocalTankUnloadedEvent) : void {
         this.localTank = null;
      }
      
      public function tankSpecificationsChanged(e:TankSpecificationsChangedEvent) : void {
         if (e.tank == this.localTank) {
            this.setSpeed();
         }
      }
      
      private function setSpeed() : void {
         if (this.localTank == null || !this.isEnabled) {
            return;
         }
         
         var speed:Number = this.getProperty("Speed").value;
         var turnSpeed:Number = this.getProperty("Turn speed").value;
         var accelaration:Number = this.getProperty("Accelaration").value;
         var turnAccelaration:Number = this.getProperty("Turn accelaration").value;
         var turretRotationSpeed:Number = this.getProperty("Turret rotation speed").value;
         var turretAccelaration:Number = this.getProperty("Turret accelaration").value;
         
         this.localTank.setMaxSpeed(speed, true);
         this.localTank.setMaxTurnSpeed(turnSpeed, true);
         this.localTank.setAcceleration(accelaration)
         //this.localTank.setTurnAccelaration(turnAccelaration)
         //this.localTank.setMaxTurretTurnSpeed(turretRotationSpeed, true);
         //this.localTank.setTurretTurnAcceleration(turretAccelaration);
      }
   
   }
}