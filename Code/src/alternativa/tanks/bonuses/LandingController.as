package alternativa.tanks.bonuses
{
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   
   public class LandingController implements BonusController
   {
      
      private static const eulerAngles:Vector3 = new Vector3();
      
      private static const m:Matrix3 = new Matrix3();
      
      private static const ANGULAR_SPEED:Number = 2.5;
      
      private var bonus:BattleBonus;
      
      private var normal:Vector3 = new Vector3();
      
      private var pivot:Vector3 = new Vector3();
      
      private var r:Vector3 = new Vector3();
      
      private var angle:Number;
      
      private var axis:Vector3 = new Vector3();
      
      private var oldState:LandingState = new LandingState();
      
      private var newState:LandingState = new LandingState();
      
      private var interpolatedState:LandingState = new LandingState();
      
      public function LandingController(param1:BattleBonus)
      {
         super();
         this.bonus = param1;
      }
      
      public function init(param1:Vector3, param2:Vector3) : void
      {
         this.pivot.copy(param1);
         this.normal.copy(param2);
      }
      
      public function start() : void
      {
         var _loc1_:BonusMesh = this.bonus.getBonusMesh();
         _loc1_.readPosition(this.r);
         this.r.subtract(this.pivot);
         this.axis.copy(Vector3.Z_AXIS);
         this.axis.cross(this.normal);
         this.axis.normalize();
         this.angle = Math.acos(this.normal.z);
         _loc1_.readPosition(this.newState.position);
         _loc1_.readRotation(eulerAngles);
         this.newState.orientation.setFromEulerAngles(eulerAngles);
         this.oldState.copy(this.newState);
      }
      
      public function runBeforePhysicsUpdate(param1:Number) : void
      {
         this.oldState.copy(this.newState);
         var _loc2_:Number = ANGULAR_SPEED * param1;
         if(_loc2_ > this.angle)
         {
            _loc2_ = this.angle;
            this.angle = 0;
         }
         else
         {
            this.angle -= _loc2_;
         }
         m.fromAxisAngle(this.axis,_loc2_);
         this.r.transform3(m);
         this.newState.position.copy(this.pivot).add(this.r);
         this.newState.orientation.addScaledVector(this.axis,_loc2_);
         this.updateTrigger();
         if(this.angle == 0)
         {
            this.interpolatePhysicsState(1);
            this.render();
            this.bonus.onLandingComplete();
         }
      }
      
      private function updateTrigger() : void
      {
         this.newState.orientation.toMatrix3(m);
         this.bonus.getTrigger().setTransform(this.newState.position,m);
      }
      
      public function interpolatePhysicsState(param1:Number) : void
      {
         this.interpolatedState.interpolate(this.oldState,this.newState,param1);
      }
      
      public function render() : void
      {
         var _loc1_:BonusMesh = this.bonus.getBonusMesh();
         _loc1_.setPosition(this.interpolatedState.position);
         this.interpolatedState.orientation.getEulerAngles(eulerAngles);
         _loc1_.setRotation(eulerAngles);
      }
   }
}

