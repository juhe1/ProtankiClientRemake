package alternativa.tanks.models.weapon.healing.targeting
{
   import alternativa.math.Vector3;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.tanks.models.weapons.targeting.direction.TargetingDirection;
   import alternativa.tanks.models.weapons.targeting.direction.TargetingDirectionCalculator;
   
   public class IsisDirectionCalculator implements TargetingDirectionCalculator
   {
      
      private const NUMBER_SIDE_POINTS:int = 11;
      
      private var upDirection:Vector3 = new Vector3();
      
      private var currentDirection:Vector3 = new Vector3();
      
      private var angle:Number;
      
      private var screenSize:Number;
      
      private var bonusDirection:Vector3;
      
      public function IsisDirectionCalculator(param1:Number)
      {
         super();
         this.angle = param1 / 2;
         this.screenSize = Math.tan(this.angle) * 2;
      }
      
      public function setBonusDirection(param1:Vector3) : void
      {
         this.bonusDirection = param1;
      }
      
      public function resetBonusDirection() : void
      {
         this.bonusDirection = null;
      }
      
      public function getDirections(param1:AllGlobalGunParams) : Vector.<TargetingDirection>
      {
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         this.upDirection.cross2(param1.elevationAxis,param1.direction);
         var _loc2_:Vector.<TargetingDirection> = new Vector.<TargetingDirection>();
         var _loc3_:Number = this.screenSize / (this.NUMBER_SIDE_POINTS - 1);
         var _loc4_:Number = -this.screenSize * 0.5;
         var _loc5_:int = 0;
         while(_loc5_ < this.NUMBER_SIDE_POINTS)
         {
            _loc6_ = -this.screenSize * 0.5;
            _loc7_ = 0;
            while(_loc7_ < this.NUMBER_SIDE_POINTS)
            {
               this.currentDirection.copy(param1.direction);
               this.currentDirection.addScaled(_loc4_,this.upDirection);
               this.currentDirection.addScaled(_loc6_,param1.elevationAxis);
               this.currentDirection.normalize();
               _loc8_ = Math.acos(this.currentDirection.dot(param1.direction));
               if(_loc8_ <= this.angle)
               {
                  _loc2_.push(new TargetingDirection(this.currentDirection,_loc8_,Number.MAX_VALUE));
               }
               _loc6_ += _loc3_;
               _loc7_++;
            }
            _loc4_ += _loc3_;
            _loc5_++;
         }
         if(this.bonusDirection != null)
         {
            _loc2_.push(new TargetingDirection(this.bonusDirection,Math.acos(this.bonusDirection.dot(param1.direction)),Number.MAX_VALUE,10));
         }
         return _loc2_;
      }
   }
}

