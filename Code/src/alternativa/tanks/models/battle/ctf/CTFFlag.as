package alternativa.tanks.models.battle.ctf
{
   import alternativa.engine3d.lights.OmniLight;
   import alternativa.math.Vector3;
   import alternativa.physics.Body;
   import alternativa.physics.PhysicsMaterial;
   import alternativa.physics.ShapeContact;
   import alternativa.physics.collision.CollisionDetector;
   import alternativa.physics.collision.CollisionShape;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.physics.collision.types.RayHit;
   import alternativa.tanks.battle.Trigger;
   import alternativa.tanks.battle.hidablegraphicobjects.HidableGraphicObject;
   import alternativa.tanks.battle.objects.tank.Tank;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.engine3d.AnimatedSprite3D;
   import alternativa.tanks.engine3d.TextureAnimation;
   import alternativa.tanks.models.teamlight.ModeLight;
   import alternativa.tanks.models.teamlight.TeamLightColor;
   import alternativa.tanks.physics.CollisionGroup;
   import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
   import alternativa.tanks.utils.EncryptedInt;
   import alternativa.tanks.utils.EncryptedIntImpl;
   import alternativa.types.Long;
   import flash.display.BitmapData;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class CTFFlag implements HidableGraphicObject, Trigger, Renderer
   {
      
      [Inject] // added
      public static var lightingEffectsService:ILightingEffectsService;
      
      private static const SKIN_BASE_SIZE:EncryptedInt = new EncryptedIntImpl(95);
      
      private static const SKIN_HEIGHT:EncryptedInt = new EncryptedIntImpl(400);
      
      private static const contacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();
      
      private static const rayOrigin:Vector3 = new Vector3();
      
      private static const rayHit:RayHit = new RayHit();
      
      private static const flagPosition:Vector3 = new Vector3();
      
      private static const rayDirection:Vector3 = new Vector3();
      
      public var teamType:BattleTeam;
      
      public var collisionPrimitive:CollisionShape;
      
      private var _carrier:Tank;
      
      private var _carrierId:String;
      
      private var _state:CTFFlagState = CTFFlagState.AT_BASE;
      
      private var basePosition:Vector3;
      
      private var skin:AnimatedSprite3D;
      
      private var startTime:int;
      
      private var frameInterval:int = 1000;
      
      private var _alphaCoefficient:Number = 1;
      
      private var isLocalCarrier:Boolean;
      
      private var collisionDetector:CollisionDetector;
      
      private var callback:ICTFModel;
      
      private var battleScene3D:BattleScene3D;
      
      private var lightSource:OmniLight;
      
      public function CTFFlag(param1:BattleTeam, param2:Vector3, param3:int, param4:int, param5:TextureAnimation, param6:CollisionDetector, param7:ICTFModel, param8:BattleScene3D)
      {
         super();
         this.teamType = param1;
         this.basePosition = param2.clone();
         this._state = CTFFlagState.AT_BASE;
         this.collisionDetector = param6;
         this.callback = param7;
         this.battleScene3D = param8;
         this.createSkin(param3,param4,param5);
         this.createLight(param1);
         this.setPosition(param2);
         this.startTime = this.frameInterval * Math.random();
      }
      
      private function createLight(param1:BattleTeam) : void
      {
         var _loc2_:ModeLight = lightingEffectsService.getLightForMode(BattleMode.CTF);
         var _loc3_:TeamLightColor = _loc2_.getLightForTeam(param1);
         this.lightSource = new OmniLight(_loc3_.getColor(),_loc2_.getAttenuationBegin(),_loc2_.getAttenuationEnd());
         this.lightSource.intensity = _loc3_.getIntensity();
      }
      
      public function setAlphaMultiplier(param1:Number) : void
      {
         this._alphaCoefficient = param1 < 0.2 ? 0.2 : param1;
         this.setSkinAlpha(this.isLocalCarrier ? 0.5 : 1);
      }
      
      private function setSkinAlpha(param1:Number) : void
      {
         if(this._state == CTFFlagState.CARRIED)
         {
            this.skin.alpha = param1;
         }
         else
         {
            this.skin.alpha = this._alphaCoefficient;
         }
      }
      
      public function readPosition(param1:Vector3) : void
      {
         param1.x = this.skin.x;
         param1.y = this.skin.y;
         param1.z = this.skin.z;
      }
      
      public function checkTrigger(param1:Body) : void
      {
         var _loc3_:CollisionShape = null;
         var _loc4_:ShapeContact = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         while(true)
         {
            if(_loc2_ >= param1.numCollisionShapes)
            {
               return;
            }
            _loc3_ = param1.collisionShapes[0];
            this.collisionDetector.getContacts(_loc3_,this.collisionPrimitive,contacts);
            if(contacts.length > 0)
            {
               _loc4_ = contacts[0];
               rayOrigin.copy(_loc4_.position);
               rayDirection.x = this.collisionPrimitive.transform.m03 - rayOrigin.x;
               rayDirection.y = this.collisionPrimitive.transform.m13 - rayOrigin.y;
               rayDirection.z = this.collisionPrimitive.transform.m23 - rayOrigin.z;
               if(!this.collisionDetector.raycastStatic(rayOrigin,rayDirection,CollisionGroup.STATIC,1,null,rayHit))
               {
                  break;
               }
               rayOrigin.x = _loc3_.transform.m03;
               rayOrigin.y = _loc3_.transform.m13;
               rayOrigin.z = _loc3_.transform.m23;
               rayDirection.x = this.collisionPrimitive.transform.m03 - rayOrigin.x;
               rayDirection.y = this.collisionPrimitive.transform.m13 - rayOrigin.y;
               rayDirection.z = this.collisionPrimitive.aabb.minZ - rayOrigin.z + 1;
               if(!this.collisionDetector.raycastStatic(rayOrigin,rayDirection,CollisionGroup.STATIC,1,null,rayHit))
               {
                  break;
               }
            }
            _loc2_++;
         }
         _loc5_ = 0;
         while(_loc5_ < contacts.length)
         {
            _loc4_ = contacts[_loc5_];
            _loc4_.dispose();
            _loc5_++;
         }
         contacts.length = 0;
         this.callback.onFlagTouch(this);
      }
      
      public function render(param1:int, param2:int) : void
      {
         this.skin.setFrameIndex(int((param1 - this.startTime) / this.frameInterval));
         if(this._carrier != null)
         {
            this._carrier.getSkin().readGlobalFlagMountPoint(flagPosition, new Vector3());
            flagPosition.z -= 50;
            this.setPosition(flagPosition);
         }
      }
      
      public function get carrier() : Tank
      {
         return this._carrier;
      }
      
      public function get carrierId() : String
      {
         return this._carrierId;
      }
      
      private function setPosition(param1:Vector3) : void
      {
         this.skin.x = param1.x;
         this.skin.y = param1.y;
         this.skin.z = param1.z;
         this.collisionPrimitive.transform.m03 = param1.x;
         this.collisionPrimitive.transform.m13 = param1.y;
         this.collisionPrimitive.transform.m23 = param1.z + 0.5 * SKIN_HEIGHT.getInt();
         this.collisionPrimitive.calculateAABB();
         this.lightSource.x = param1.x;
         this.lightSource.y = param1.y;
         this.lightSource.z = param1.z + 0.75 * SKIN_HEIGHT.getInt();
      }
      
      public function addToScene() : void
      {
         this.battleScene3D.addObject(this.skin);
         this.battleScene3D.addObject(this.lightSource);
      }
      
      public function get state() : CTFFlagState
      {
         return this._state;
      }
      
      public function setLocalCarrier(param1:String, param2:Tank) : void
      {
         this.isLocalCarrier = true;
         this.setCarrier(param1,param2,0.5);
      }
      
      public function setRemoteCarrier(param1:String, param2:Tank) : void
      {
         this.isLocalCarrier = false;
         this.setCarrier(param1,param2,1);
      }
      
      private function setCarrier(param1:String, param2:Tank, param3:Number) : void
      {
         this._carrierId = param1;
         this._carrier = param2;
         this._state = CTFFlagState.CARRIED;
         if(param2 != null)
         {
            this.skin.visible = true;
            this.setSkinAlpha(param3);
         }
         else
         {
            this.skin.visible = false;
         }
      }
      
      public function returnToBase() : void
      {
         this.reset(CTFFlagState.AT_BASE);
         this.setPosition(this.basePosition);
      }
      
      public function dropAt(param1:Vector3) : void
      {
         this.reset(CTFFlagState.DROPPED);
         this.setPosition(param1);
      }
      
      public function dispose() : void
      {
         this.battleScene3D.removeObject(this.skin);
         this.battleScene3D.removeObject(this.lightSource);
      }
      
      private function createSkin(param1:int, param2:int, param3:TextureAnimation) : void
      {
         var _loc4_:Number = param1 * SKIN_HEIGHT.getInt() / param2;
         this.skin = new AnimatedSprite3D(_loc4_,SKIN_HEIGHT.getInt());
         this.skin.softAttenuation = 10;
         this.skin.setAnimationData(param3);
         this.skin.setFrameIndex(0);
         this.skin.originY = 1;
         var _loc5_:BitmapData = param3.material.texture;
         param3.material.resolution = this.skin.calculateResolution(_loc5_.width,_loc5_.height);
         this.collisionPrimitive = new CollisionBox(new Vector3(0.5 * SKIN_BASE_SIZE.getInt(),0.5 * SKIN_BASE_SIZE.getInt(),0.5 * SKIN_HEIGHT.getInt()),CollisionGroup.TANK,PhysicsMaterial.DEFAULT_MATERIAL);
      }
      
      private function reset(param1:CTFFlagState) : void
      {
         this._state = param1;
         this._carrierId = null;
         this._carrier = null;
         this.setSkinAlpha(1);
         this.skin.visible = true;
      }
   }
}

