package juho.hacking {
   
   import juho.hacking.hacks.SpeedHack;
   import juho.hacking.Hack;
   import juho.hacking.hacks.TankIgnoreHack;
   import juho.hacking.hacks.AimHack;
   import juho.hacking.hacks.WallHack;
   
   public class HackRegistry {
      
      public static var allHacks:Vector.<Hack>;
      
      public function HackRegistry() {
         allHacks = new Vector.<Hack>();
         
         var tankIgnoreHack:TankIgnoreHack = new TankIgnoreHack()
         allHacks.push(tankIgnoreHack);
         
         var aimHack:AimHack = new AimHack()
         allHacks.push(aimHack);
         
         var wallHack:WallHack = new WallHack()
         allHacks.push(wallHack);

         var speedHack:SpeedHack = new SpeedHack()
         allHacks.push(speedHack);
      }
   }
}