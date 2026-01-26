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
   
   public class WallHack extends Hack {
      private static const NAME:String = "Wall Hack";
      
      // ID is used in saving to disk
      private static const ID:String = "WALL_HACK";
      
      public function WallHack() {
         super(NAME, ID);
         HackEventDispatcher.singleton.addEventListener(LocalTankInitedEvent.LOCAL_TANK_INITED, this.localTankInited);
      }
      
      override public function enable():void {
         super.enable();
         
         this.reveal();
      }
      
      override public function disable():void {
         super.disable();
         
         this.conceal();
      }
      
      private function localTankInited(e:LocalTankInitedEvent) : void {
         if (this.isEnabled) {
            this.reveal();
         } else {
            this.conceal();
         }
      }
      
      private function reveal() : void {
         BattlefieldModel.wallHack.revealTanks();
      }

      private function conceal() : void {
         BattlefieldModel.wallHack.concealTanks();
      }
   
   }

}