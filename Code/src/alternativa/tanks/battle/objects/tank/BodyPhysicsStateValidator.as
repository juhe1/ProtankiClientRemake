package alternativa.tanks.battle.objects.tank
{
   import alternativa.math.Quaternion;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.BodyState;
   import alternativa.tanks.battle.events.BattleEventDispatcher;
   import alternativa.tanks.utils.DataValidationErrorEvent;
   import alternativa.tanks.utils.DataValidatorType;
   import alternativa.tanks.utils.EncryptedNumber;
   import alternativa.tanks.utils.EncryptedNumberImpl;
   
   public class BodyPhysicsStateValidator
   {
      
      private const hash:EncryptedNumber = new EncryptedNumberImpl();
      
      private const cx:EncryptedNumber = new EncryptedNumberImpl(Math.random() + 1);
      
      private const cy:EncryptedNumber = new EncryptedNumberImpl(Math.random() + 1);
      
      private const cz:EncryptedNumber = new EncryptedNumberImpl(Math.random() + 1);
      
      private const cw:EncryptedNumber = new EncryptedNumberImpl(Math.random() + 1);
      
      private var body:Body;
      
      private const prevPosition:Vector3 = new Vector3();
      
      private const prevOrientation:Quaternion = new Quaternion();
      
      private var eventDispatcher:BattleEventDispatcher;
      
      public function BodyPhysicsStateValidator(param1:Body, param2:BattleEventDispatcher)
      {
         super();
         this.body = param1;
         this.eventDispatcher = param2;
         this.refresh();
      }
      
      public function refresh() : void
      {
         var _loc1_:BodyState = this.body.state;
         var _loc2_:Vector3 = _loc1_.position;
         var _loc3_:Quaternion = _loc1_.orientation;
         var _loc4_:Number = Number(this.cx.getNumber());
         var _loc5_:Number = Number(this.cy.getNumber());
         var _loc6_:Number = Number(this.cz.getNumber());
         this.hash.setNumber(_loc4_ * _loc2_.x + _loc5_ * _loc2_.y + _loc6_ * _loc2_.z + _loc4_ * _loc3_.x + _loc5_ * _loc3_.y + _loc6_ * _loc3_.z + this.cw.getNumber() * _loc3_.w);
         this.prevPosition.copy(_loc2_);
         this.prevOrientation.copy(_loc3_);
      }
      
      public function validate() : void
      {
         var _loc1_:BodyState = this.body.state;
         var _loc2_:Vector3 = _loc1_.position;
         var _loc3_:Quaternion = _loc1_.orientation;
         var _loc4_:Number = Number(this.cx.getNumber());
         var _loc5_:Number = Number(this.cy.getNumber());
         var _loc6_:Number = Number(this.cz.getNumber());
         var _loc7_:Number = _loc4_ * _loc2_.x + _loc5_ * _loc2_.y + _loc6_ * _loc2_.z + _loc4_ * _loc3_.x + _loc5_ * _loc3_.y + _loc6_ * _loc3_.z + this.cw.getNumber() * _loc3_.w;
         if(_loc7_ != this.hash.getNumber())
         {
            this.eventDispatcher.dispatchEvent(new DataValidationErrorEvent(DataValidatorType.TANK_POSITION));
         }
      }
   }
}

