package alternativa.tanks.camera
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.console.variables.ConsoleVarFloat;
   
   public class ProjectileHitCameraModifier implements ICameraStateModifier
   {
      
      private static var amplitude:ConsoleVarFloat;
      
      private static var swayAmplitude:ConsoleVarFloat;
      
      private static var time1:ConsoleVarFloat;
      
      private static var time2:ConsoleVarFloat;
      
      private static var m:Matrix3 = new Matrix3();
      
      private static var m1:Matrix3 = new Matrix3();
      
      private var hitDirection:Vector3 = new Vector3();
      
      private var swayAxis:Vector3 = new Vector3();
      
      private var power:Number;
      
      private var t:Number;
      
      private var state:int;
      
      public function ProjectileHitCameraModifier()
      {
         super();
      }
      
      public static function initVars() : void
      {
         amplitude = new ConsoleVarFloat("hitcam_ampl",50,-1000,1000);
         swayAmplitude = new ConsoleVarFloat("hitcam_sway",-0.05,-10,10);
         time1 = new ConsoleVarFloat("hitcam_time1",0.1,0,10);
         time2 = new ConsoleVarFloat("hitcam_time2",0.5,0,10);
      }
      
      public function init(param1:Vector3, param2:Number) : void
      {
         this.hitDirection.copy(param1);
         this.power = param2;
         this.swayAxis.reset(this.hitDirection.y,-this.hitDirection.x,0).normalize();
         this.t = 0;
         this.state = 0;
      }
      
      public function update(param1:int, param2:int, param3:Vector3, param4:Vector3) : Boolean
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         this.t += param2 * 0.001;
         switch(this.state)
         {
            case 0:
               if(this.t > time1.value)
               {
                  this.t = time1.value;
                  this.state = 1;
               }
               _loc5_ = Math.sin(Math.PI / 2 / time1.value * this.t);
               break;
            case 1:
               if(this.t > time2.value)
               {
                  this.t = time2.value;
                  this.state = 2;
               }
               _loc6_ = Math.PI / (time2.value - time1.value);
               _loc7_ = Math.PI * time1.value / (time1.value - time2.value);
               _loc5_ = 0.5 * (1 + Math.cos(_loc6_ * this.t + _loc7_));
               break;
            case 2:
               return false;
         }
         param3.addScaled(_loc5_ * amplitude.value * this.power,this.hitDirection);
         m.setRotationMatrix(param4.x,param4.y,param4.z);
         m1.fromAxisAngle(this.swayAxis,_loc5_ * swayAmplitude.value * this.power);
         m.append(m1);
         m.getEulerAngles(param4);
         return true;
      }
      
      public function onAddedToController(param1:IFollowCameraController) : void
      {
      }
      
      public function destroy() : void
      {
      }
   }
}

