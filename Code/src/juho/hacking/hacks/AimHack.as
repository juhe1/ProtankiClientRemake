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
   import alternativa.tanks.models.weapons.targeting.direction.sector.CheatTargetingSectorsCalculator;
   import alternativa.tanks.models.weapons.targeting.direction.sector.splitter.CheatSectorsSplitter;
   import alternativa.tanks.models.weapon.smoky.SmokyWeapon;
   import alternativa.tanks.models.weapon.twins.TwinsWeapon;
   import alternativa.tanks.models.weapon.railgun.RailgunWeapon;
   import alternativa.tanks.models.weapon.thunder.ThunderWeapon;
   
	/**
    * ...
    * @author juhe
    */
   public class AimHack extends Hack {
      private static const NAME:String = "Aim cheat (Works with Smoky, Twins, Railgun, Thunder)";

      // ID is used in saving to disk
      private static const ID:String = "AIM";

      private static const PROP_SIDEWAYS_AIM_ENABLED:String = "Sideways aim enabled";
      private static const PROP_MAX_LEFT_ANGLE:String = "   Max left angle°";
      private static const PROP_MAX_RIGHT_ANGLE:String = "   Max right angle°";
      private static const PROP_MAX_UP_ANGLE:String = "Max up angle°";
      private static const PROP_MAX_DOWN_ANGLE:String = "Max down angle°";
      private static const PROP_DEBUG_ENABLED:String = "Debug enabled";
      
      public function AimHack() {
         super(NAME, ID);
         this.addProperty(PROP_SIDEWAYS_AIM_ENABLED, true, "Boolean", sideWaysAimEnabledChanged);
         this.addProperty(PROP_MAX_LEFT_ANGLE, 30, "Number", leftAngleChanged);
         this.addProperty(PROP_MAX_RIGHT_ANGLE, 30, "Number", rightAngleChanged);
         this.addProperty(PROP_MAX_UP_ANGLE, 30, "Number", upAngleChanged);
         this.addProperty(PROP_MAX_DOWN_ANGLE, 30, "Number", downAngleChanged);
         this.addProperty(PROP_DEBUG_ENABLED, false, "Boolean", debugEnabledChanged);
         HackEventDispatcher.singleton.addEventListener(LocalTankInitedEvent.LOCAL_TANK_INITED, this.localTankInited);
      }
      
      override public function enable():void {
         super.enable();
         SmokyWeapon.cheatTargetingEnabled = true;
         TwinsWeapon.cheatTargetingEnabled = true;
         RailgunWeapon.cheatTargetingEnabled = true;
         ThunderWeapon.cheatTargetingEnabled = true;
         setMaxLeftAngleState();
         setMaxRightAngleState();
         setMaxUpAngleState();
         setMaxDownAngleState();
         setDebugState();
      }

      override public function disable():void {
         super.disable();
         SmokyWeapon.cheatTargetingEnabled = false;
         TwinsWeapon.cheatTargetingEnabled = false;
         RailgunWeapon.cheatTargetingEnabled = false;
         ThunderWeapon.cheatTargetingEnabled = false;
         setMaxLeftAngleState();
         setMaxRightAngleState();
         setMaxUpAngleState();
         setMaxDownAngleState();
         setDebugState();
      }

      private function localTankInited(e:LocalTankInitedEvent) : void {
         if (this.isEnabled)
         {
            enable();
         } else
         {
            disable();
         }
      }
      
      private function leftAngleChanged(value:*):void {
         setMaxLeftAngleState();
      }

      private function rightAngleChanged(value:*):void {
         setMaxRightAngleState();
      }

      private function upAngleChanged(value:*):void {
         setMaxUpAngleState();
      }

      private function downAngleChanged(value:*):void {
         setMaxDownAngleState();
      }

      private function debugEnabledChanged(value:Boolean):void {
         this.setDebugState();
      }

      private function sideWaysAimEnabledChanged(value:Boolean):void {
         setMaxLeftAngleState();
         setMaxRightAngleState();
      }

      private function setMaxLeftAngleState():void {
         if (!isEnabled || !this.getProperty(PROP_SIDEWAYS_AIM_ENABLED).value) {
            CheatTargetingSectorsCalculator.maxAngleLeft = 0;
            return;
         }
         var angle:Number = this.getProperty(PROP_MAX_LEFT_ANGLE).value;
         CheatTargetingSectorsCalculator.maxAngleLeft = angle / 180 * Math.PI;
      }

      private function setMaxRightAngleState():void {
         if (!isEnabled || !this.getProperty(PROP_SIDEWAYS_AIM_ENABLED).value) {
            CheatTargetingSectorsCalculator.maxAngleRight = 0;
            return;
         }
         var angle:Number = this.getProperty(PROP_MAX_RIGHT_ANGLE).value;
         CheatTargetingSectorsCalculator.maxAngleRight = angle / 180 * Math.PI;
      }

      private function setMaxUpAngleState():void {
         if(!isEnabled)
         {
            CheatTargetingSectorsCalculator.maxAngleUpOverride = 0;
            return;
         }
         var angle:Number = this.getProperty(PROP_MAX_UP_ANGLE).value;
         CheatTargetingSectorsCalculator.maxAngleUpOverride = angle / 180 * Math.PI;
      }

      private function setMaxDownAngleState():void {
         if(!isEnabled)
         {
            CheatTargetingSectorsCalculator.maxAngleDownOverride = 0;
            return;
         }
         var angle:Number = this.getProperty(PROP_MAX_DOWN_ANGLE).value;
         CheatTargetingSectorsCalculator.maxAngleDownOverride = angle / 180 * Math.PI;
      }
      
      private function setDebugState():void {
         if (!isEnabled) {
            CheatSectorsSplitter.targetingVisualDebug.debugEnabled = 0;
            CheatSectorsSplitter.targetingVisualDebug.reset();
            return;
         }
         var enabled:Boolean = this.getProperty(PROP_DEBUG_ENABLED).value;
         CheatSectorsSplitter.targetingVisualDebug.debugEnabled = enabled;
      }
   
   }

}