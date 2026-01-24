package juho.hacking.hacks {
   
   import juho.hacking.Hack;
   import juho.hacking.event.HackEventDispatcher;
   import juho.hacking.event.LocalTankUnloadedEvent;
   import juho.hacking.event.LocalTankInitedEvent;
   import juho.hacking.event.TankNormalStateSettedEvent;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.models.battle.battlefield.BattlefieldModel;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.physics.CollisionGroup;
   import projects.tanks.client.battlefield.types.TankState;
   import alternativa.tanks.battle.objects.tank.ClientTankState;
   
	/**
    * ...
    * @author juhe
    */
   
   public class TankIgnoreHack extends Hack {
      private static const NAME:String = "Tank Ignore";
      
      // ID is used in saving to disk
      private static const ID:String = "TANK_IGNORE";
      
      private var localTank:Tank;
      
      private var battlefield:BattlefieldModel;
      
      public function TankIgnoreHack() {
         super(NAME, ID);
         HackEventDispatcher.singleton.addEventListener(LocalTankInitedEvent.LOCAL_TANK_INITED, this.localTankInited);
         HackEventDispatcher.singleton.addEventListener(LocalTankUnloadedEvent.LOCAL_TANK_UNLOADED_EVENT, this.localTankDestroyed);
         HackEventDispatcher.singleton.addEventListener(TankNormalStateSettedEvent.TANK_NORMAL_STATE_SETTED_EVENT, this.tankNormalStateSettedEvent);
      }
      
      override public function enable():void {
         super.enable();
         
         if (this.localTank != null) {
            this.activateIgnore();
         }
      }
      
      override public function disable():void {
         super.disable();
         
         if (this.localTank != null && this.localTank.state == ClientTankState.ACTIVE) {
            //this.localTank.setBodyCollisionGroup(CollisionGroup.TANK | CollisionGroup.ACTIVE_TRACK | CollisionGroup.WEAPON);
            this.localTank.setTracksCollisionGroup(CollisionGroup.ACTIVE_TRACK);
            this.localTank.tankBody.body.postCollisionFilter = null;
         }
      }
      
      private function localTankInited(e:LocalTankInitedEvent) : void {
         this.localTank = e.localTank;
      }
      
      private function localTankDestroyed(e:LocalTankUnloadedEvent) : void {
         this.localTank = null;
      }
      
      private function tankNormalStateSettedEvent(e:TankNormalStateSettedEvent) {
         if (e.tank == this.localTank && this.isEnabled) {
            this.activateIgnore();
         }
      }

      private function activateIgnore():void {
         if (this.localTank != null) {
            //this.localTank.setBodyCollisionGroup(CollisionGroup.TANK);
            this.localTank.setTracksCollisionGroup(CollisionGroup.INACTIVE_TRACK);
            this.localTank.tankBody.body.postCollisionFilter = this.localTank;
         }
      }
   
   }

}