package alternativa.tanks.models.weapon.terminator.sfx
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.models.weapon.terminator.TerminatorToggleCallback;
   import flash.utils.getTimer;
   
   public class TerminatorOpenEffect implements Renderer
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const OPEN_LENGTH:Number = 50;
      
      private static const OPEN_TIME:Number = 500;
      
      private var leftBox:Object3D;
      
      private var rightBox:Object3D;
      
      private var elapsedTime:int;
      
      private var startTime:int;
      
      private var reverse:Boolean;
      
      private var toggleCallback:TerminatorToggleCallback;
      
      public function TerminatorOpenEffect(param1:Object3D, param2:Object3D, param3:TerminatorToggleCallback)
      {
         super();
         this.rightBox = param2;
         this.leftBox = param1;
         this.toggleCallback = param3;
      }
      
      private function toggle(param1:Boolean) : void
      {
         battleService.getBattleScene3D().addRenderer(this);
         this.reverse = param1;
         var _loc2_:* = getTimer();
         var _loc3_:* = _loc2_ - this.startTime;
         this.elapsedTime = _loc3_ < OPEN_TIME ? int(OPEN_TIME - _loc3_) : 0;
         this.startTime = _loc2_;
      }
      
      public function turnOn() : void
      {
         this.toggle(false);
      }
      
      public function turnOff() : void
      {
         this.toggle(true);
      }
      
      public function reset() : void
      {
         this.rightBox.x = 0;
         this.leftBox.x = 0;
      }
      
      public function render(param1:int, param2:int) : void
      {
         this.elapsedTime += param2;
         if(this.elapsedTime >= OPEN_TIME)
         {
            battleService.getBattleScene3D().removeRenderer(this);
            if(this.reverse)
            {
               this.reset();
               this.toggleCallback.onClosed();
            }
            else
            {
               this.toggleCallback.onOpened();
            }
            return;
         }
         var _loc3_:Number = this.reverse ? OPEN_LENGTH : 0;
         var _loc4_:Number = (this.reverse ? this.elapsedTime : -this.elapsedTime) / OPEN_TIME * OPEN_LENGTH;
         this.rightBox.x = _loc3_ - _loc4_;
         this.leftBox.x = _loc4_ - _loc3_;
      }
      
      public function destroy() : void
      {
         battleService.getBattleScene3D().removeRenderer(this);
      }
   }
}

