package juho.hacking {
   
   import juho.hacking.hacks.SpeedHack;
   import juho.hacking.Hack;
   import juho.hacking.hacks.TankIgnoreHack;
   import juho.hacking.hacks.AimHack;
   
   public class HackRegistry {
      
      public static var allHacks:Vector.<Hack>;
      
      public function HackRegistry() {
         allHacks = new Vector.<Hack>();
         
         var speedHack:SpeedHack = new SpeedHack()
         allHacks.push(speedHack);
         
         var tankIgnoreHack:TankIgnoreHack = new TankIgnoreHack()
         allHacks.push(tankIgnoreHack);
         
         var aimHack:AimHack = new AimHack()
         allHacks.push(aimHack);
      }
   }
}