package alternativa.tanks.sfx.floatingmessage
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
   import alternativa.tanks.camera.GameCamera;
   import alternativa.tanks.sfx.*;
   import alternativa.tanks.utils.objectpool.Pool;
   import alternativa.tanks.utils.objectpool.PooledObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Vector3D;
   
   public class FloatingTextEffect extends PooledObject implements GraphicEffect
   {
      
      [Inject]
      public static var battleService:BattleService;
      
      private static const vector1:Vector3D = new Vector3D();
      
      private var messageLifeTime:int;
      
      private var messages:Vector.<Message>;
      
      private var anchor:Object3D;
      
      private var messageContainer:DisplayObjectContainer;
      
      private var destructionCallback:Function;
      
      private var killed:Boolean;
      
      public function FloatingTextEffect(param1:Pool)
      {
         super(param1);
         this.messages = new Vector.<Message>();
         this.messageContainer = new Sprite();
      }
      
      public function init(param1:int, param2:Object3D, param3:Function) : void
      {
         this.messageLifeTime = param1;
         this.anchor = param2;
         this.destructionCallback = param3;
         this.killed = false;
      }
      
      public function addMessage(param1:String, param2:uint) : void
      {
         var _loc3_:Message = Message.create();
         _loc3_.color = param2;
         _loc3_.text = param1;
         _loc3_.lifeTime = 0;
         this.messages.push(_loc3_);
         this.messageContainer.addChild(_loc3_);
      }
      
      public function addedToScene(param1:Scene3DContainer) : void
      {
         battleService.getBattleView().addOverlayObject(this.messageContainer);
      }
      
      public function kill() : void
      {
         this.killed = true;
      }
      
      public function play(param1:int, param2:GameCamera) : Boolean
      {
         var _loc3_:int = 0;
         var _loc6_:Message = null;
         if(this.killed)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < this.messages.length)
         {
            _loc6_ = this.messages[_loc3_];
            _loc6_.lifeTime += param1;
            if(_loc6_.lifeTime >= this.messageLifeTime)
            {
               _loc6_.destroy();
               this.messages.shift();
               _loc3_--;
            }
            _loc3_++;
         }
         if(this.messages.length == 0)
         {
            return false;
         }
         vector1.x = 0;
         vector1.y = 0;
         vector1.z = 0;
         var _loc4_:Vector3D = param2.projectGlobal(this.anchor.localToGlobal(vector1));
         if(_loc4_.z > 0.01 && _loc4_.z > param2.nearClipping)
         {
            this.messageContainer.visible = true;
            this.messageContainer.x = int(_loc4_.x);
            this.messageContainer.y = int(_loc4_.y);
         }
         else
         {
            this.messageContainer.visible = false;
         }
         var _loc5_:int = 0;
         _loc3_ = this.messages.length - 1;
         while(_loc3_ >= 0)
         {
            _loc6_ = this.messages[_loc3_];
            _loc6_.y = _loc5_;
            _loc6_.x = -int(_loc6_.textWidth / 2);
            _loc5_ -= 20;
            _loc3_--;
         }
         return true;
      }
      
      public function destroy() : void
      {
         var _loc1_:Message = null;
         var _loc2_:Function = null;
         if(this.messageContainer.parent != null)
         {
            this.messageContainer.parent.removeChild(this.messageContainer);
         }
         for each(_loc1_ in this.messages)
         {
            _loc1_.destroy();
         }
         this.messages.length = 0;
         if(this.destructionCallback != null)
         {
            _loc2_ = this.destructionCallback;
            this.destructionCallback = null;
            _loc2_.call();
         }
      }
   }
}

