package alternativa.tanks.battle.objects.tank
{
   import alternativa.math.Matrix4;
   import alternativa.math.Vector3;
   import alternativa.physics.PhysicsMaterial;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.physics.TankBody;
   import alternativa.tanks.utils.MathUtils;
   
   public class CollisionBoxesBuilder
   {
      
      private static const NORMAL_FRICTION_MATERIAL:PhysicsMaterial = new PhysicsMaterial(0,1);
      
      private static const LOW_FRICTION_MATERIAL:PhysicsMaterial = new PhysicsMaterial(0,0.2);
      
      public function CollisionBoxesBuilder()
      {
         super();
      }
      
      public static function createStaticCollisionBoxes(param1:Vector3, param2:Number, param3:TankBody) : void
      {
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc4_:Number = param2 - 10;
         var _loc5_:Number = param1.y;
         var _loc6_:Number = _loc4_ / 2;
         var _loc7_:Number = 0.82;
         var _loc8_:Number = 1 - (1 - _loc7_) * (1 - _loc7_) * _loc5_ * _loc5_ / (_loc6_ * _loc6_);
         if(_loc8_ > 0)
         {
            _loc8_ = Math.sqrt(_loc8_);
         }
         else
         {
            _loc8_ = 1 - (1 - _loc7_) * _loc5_ / _loc6_;
         }
         var _loc9_:Number = (_loc7_ - 1) * _loc5_ / ((1 + _loc8_) * _loc6_);
         var _loc10_:Number = _loc8_ * _loc6_ - _loc9_ * _loc5_;
         var _loc11_:Number = (1 - _loc7_) * _loc5_ / ((1 + _loc8_) * _loc6_);
         var _loc12_:Number = (1 - _loc8_) * _loc6_ / ((1 - _loc7_) * _loc5_);
         if(MathUtils.numbersEqual(_loc11_,_loc12_,0.00001) || _loc11_ < _loc12_)
         {
            _loc13_ = _loc7_ * _loc5_;
            _loc14_ = _loc9_ * _loc13_ + _loc10_;
         }
         else
         {
            _loc13_ = (1 - _loc8_) * _loc6_ / _loc9_ + _loc5_;
            _loc14_ = _loc6_;
         }
         var _loc15_:Number = _loc14_ - _loc8_ * _loc6_;
         var _loc16_:Number = _loc5_ - _loc13_;
         var _loc17_:Number = Math.sqrt(_loc15_ * _loc15_ + _loc16_ * _loc16_) / 2;
         _loc15_ = (1 + _loc8_) * _loc6_;
         _loc16_ = (1 - _loc7_) * _loc5_;
         var _loc18_:Number = Math.sqrt(_loc15_ * _loc15_ + _loc16_ * _loc16_) / 2;
         var _loc19_:CollisionBox = new CollisionBox(new Vector3(param1.x,_loc17_,_loc18_),CollisionGroup.STATIC,LOW_FRICTION_MATERIAL);
         var _loc20_:Matrix4 = new Matrix4();
         var _loc21_:Number = Math.atan(_loc11_);
         _loc20_.setRotationMatrix(-_loc21_,0,0);
         var _loc22_:Number = _loc7_ * _loc5_ + _loc18_ * Math.sin(_loc21_) - _loc17_ * Math.cos(_loc21_);
         var _loc23_:Number = -_loc6_ + _loc18_ * Math.cos(_loc21_) + _loc17_ * Math.sin(_loc21_) - (param1.z - _loc4_ / 2);
         _loc20_.setPosition(new Vector3(0,_loc22_,_loc23_));
         param3.body.addCollisionShape(_loc19_,_loc20_);
         param3.staticShapes.push(_loc19_);
         _loc19_ = new CollisionBox(new Vector3(param1.x,_loc17_,_loc18_),CollisionGroup.STATIC,LOW_FRICTION_MATERIAL);
         _loc20_.setRotationMatrix(_loc21_,0,0);
         _loc20_.setPosition(new Vector3(0,-_loc22_,_loc23_));
         param3.body.addCollisionShape(_loc19_,_loc20_);
         param3.staticShapes.push(_loc19_);
         var _loc24_:Number = param2 * 3 / 4;
         var _loc25_:Vector3 = new Vector3(param1.x,param1.y * _loc7_,_loc24_ / 2);
         var _loc26_:Matrix4 = new Matrix4();
         _loc26_.m23 = _loc25_.z - param1.z;
         var _loc27_:CollisionBox = new CollisionBox(_loc25_,CollisionGroup.STATIC,LOW_FRICTION_MATERIAL);
         param3.body.addCollisionShape(_loc27_,_loc26_);
         param3.staticShapes.push(_loc27_);
         var _loc28_:Number = param2 * 3 / 4;
         var _loc29_:Vector3 = new Vector3(param1.x,param1.y * _loc7_,_loc28_ / 2);
         var _loc30_:Matrix4 = new Matrix4();
         _loc30_.m23 = param2 - _loc29_.z - param1.z;
         var _loc31_:CollisionBox = new CollisionBox(_loc29_,CollisionGroup.STATIC,NORMAL_FRICTION_MATERIAL);
         param3.body.addCollisionShape(_loc31_,_loc30_);
         param3.staticShapes.push(_loc31_);
      }
      
      public static function createTankCollisionBox(param1:Vector3, param2:Number, param3:TankBody) : void
      {
         var _loc4_:Vector3 = new Vector3(param1.x,param1.y,param2 / 2);
         var _loc5_:CollisionBox = new CollisionBox(_loc4_,0,LOW_FRICTION_MATERIAL);
         var _loc6_:Matrix4 = new Matrix4();
         _loc6_.m23 = param2 / 2 - param1.z;
         param3.body.addCollisionShape(_loc5_,_loc6_);
         param3.tankCollisionBox = _loc5_;
      }
   }
}

