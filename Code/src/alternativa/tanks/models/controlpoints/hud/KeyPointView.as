package alternativa.tanks.models.controlpoints.hud
{
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.lights.OmniLight;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.BSP;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.scene3d.BattleScene3D;
   import alternativa.tanks.models.teamlight.ModeLight;
   import alternativa.tanks.models.teamlight.TeamLightColor;
   import alternativa.tanks.services.colortransform.ColorTransformService;
   import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
   import alternativa.utils.TextureMaterialRegistry;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.BlendMode;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import projects.tanks.client.battlefield.models.battle.cp.resources.DominationResources;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class KeyPointView
   {
      
      [Inject]
      public static var colorTransformService:ColorTransformService;
      
      [Inject]
      public static var materialRegistry:TextureMaterialRegistry;
      
      [Inject]
      public static var lightingEffectsService:ILightingEffectsService;
      
      public static const CIRCLE_SIZE:Number = 1000;
      
      public static const CIRCLE_ASCENSION:Number = 350;
      
      private static const MAX_PROGRESS:Number = 100;
      
      private static const CURVE:Number = 1.5;
      
      private var pedestal:BSP;
      
      private var currentPedestalMaterial:TextureMaterial;
      
      private var redTextureMaterial:TextureMaterial;
      
      private var blueTextureMaterial:TextureMaterial;
      
      private var neutralTextureMaterial:TextureMaterial;
      
      private var plane:ProgressPlane;
      
      private var lightSource:OmniLight;
      
      private var redTeamColor:TeamLightColor;
      
      private var blueTeamColor:TeamLightColor;
      
      private var neutralTeamColor:TeamLightColor;
      
      public function KeyPointView(param1:String, param2:BattleScene3D, param3:DominationResources)
      {
         super();
         this.pedestal = createPedestal(param3.pedestal);
         this.blueTextureMaterial = materialRegistry.getMaterial(param3.bluePedestalTexture.data);
         this.redTextureMaterial = materialRegistry.getMaterial(param3.redPedestalTexture.data);
         this.neutralTextureMaterial = materialRegistry.getMaterial(param3.neutralPedestalTexture.data);
         var _loc4_:ModeLight = lightingEffectsService.getLightForMode(BattleMode.CP);
         this.redTeamColor = _loc4_.getLightForTeam(BattleTeam.RED);
         this.blueTeamColor = _loc4_.getLightForTeam(BattleTeam.BLUE);
         this.neutralTeamColor = _loc4_.getLightForTeam(BattleTeam.NONE);
         this.createIndicator(param1,param3);
         this.createLightSource(_loc4_);
         param2.addObjectToExclusion(this.plane);
         param2.addObjectToExclusion(this.pedestal);
      }
      
      private static function createPedestal(param1:Tanks3DSResource) : BSP
      {
         var _loc2_:Mesh = Mesh(param1.objects[0]);
         var _loc3_:BSP = new BSP();
         _loc3_.createTree(_loc2_);
         return _loc3_;
      }
      
      private static function getCircleMaterial(param1:BitmapData) : TextureMaterial
      {
         var _loc2_:TextureMaterial = materialRegistry.getMaterial(param1,false);
         _loc2_.resolution = CIRCLE_SIZE / param1.width;
         return _loc2_;
      }
      
      private static function createMatrix(param1:BitmapData, param2:BitmapData, param3:int) : Matrix
      {
         var _loc4_:int = param2.height;
         var _loc5_:Matrix = new Matrix();
         _loc5_.tx = (param1.height - _loc4_) / 2 - _loc4_ * param3;
         _loc5_.ty = (param1.height - _loc4_) / 2;
         return _loc5_;
      }
      
      private static function createRectangle(param1:BitmapData, param2:BitmapData) : Rectangle
      {
         var _loc3_:int = param2.height;
         var _loc4_:Number = (param1.height - _loc3_) / 2;
         return new Rectangle(_loc4_,_loc4_,_loc3_,_loc3_);
      }
      
      private static function createFillingTexture(param1:BitmapData, param2:BitmapData) : BitmapData
      {
         var _loc3_:BitmapData = param1.clone();
         _loc3_.copyChannel(param2,param2.rect,new Point(),BitmapDataChannel.ALPHA,BitmapDataChannel.ALPHA);
         return _loc3_;
      }
      
      private static function lerpNumber(param1:Number, param2:Number, param3:Number) : Number
      {
         return param1 + (param2 - param1) * param3;
      }
      
      private static function lerpColor(param1:uint, param2:uint, param3:Number) : uint
      {
         var _loc4_:Number = (param1 >> 16 & 0xFF) / 255;
         var _loc5_:Number = (param1 >> 8 & 0xFF) / 255;
         var _loc6_:Number = (param1 & 0xFF) / 255;
         var _loc7_:Number = (param2 >> 16 & 0xFF) / 255;
         var _loc8_:Number = (param2 >> 8 & 0xFF) / 255;
         var _loc9_:Number = (param2 & 0xFF) / 255;
         var _loc10_:int = lerpNumber(_loc4_,_loc7_,param3) * 255;
         var _loc11_:int = lerpNumber(_loc5_,_loc8_,param3) * 255;
         var _loc12_:int = lerpNumber(_loc6_,_loc9_,param3) * 255;
         return _loc10_ << 16 | _loc11_ << 8 | _loc12_;
      }
      
      private function createLightSource(param1:ModeLight) : void
      {
         this.lightSource = new OmniLight(0,param1.getAttenuationBegin(),param1.getAttenuationEnd());
         this.setLightColor(this.neutralTeamColor);
      }
      
      private function createIndicator(param1:String, param2:DominationResources) : void
      {
         var _loc3_:BitmapData = param2.neutralCircle.data.clone();
         var _loc4_:BitmapData = param2.blueCircle.data.clone();
         var _loc5_:BitmapData = param2.redCircle.data.clone();
         var _loc6_:BitmapData = param2.bigLetters.data;
         var _loc7_:int = param1.charCodeAt(0) - "A".charCodeAt(0);
         var _loc8_:Rectangle = createRectangle(_loc3_,_loc6_);
         var _loc9_:Matrix = createMatrix(_loc3_,_loc6_,_loc7_);
         _loc3_.draw(_loc6_,_loc9_,null,BlendMode.NORMAL,_loc8_,true);
         _loc4_.draw(_loc6_,_loc9_,null,BlendMode.NORMAL,_loc8_,true);
         _loc5_.draw(_loc6_,_loc9_,null,BlendMode.NORMAL,_loc8_,true);
         var _loc10_:BitmapData = createFillingTexture(_loc4_,_loc3_);
         var _loc11_:BitmapData = createFillingTexture(_loc5_,_loc3_);
         var _loc12_:TextureMaterial = getCircleMaterial(_loc3_);
         var _loc13_:TextureMaterial = getCircleMaterial(_loc4_);
         var _loc14_:TextureMaterial = getCircleMaterial(_loc10_);
         var _loc15_:TextureMaterial = getCircleMaterial(_loc5_);
         var _loc16_:TextureMaterial = getCircleMaterial(_loc11_);
         this.plane = new ProgressPlane(CIRCLE_SIZE,CIRCLE_SIZE,_loc12_,_loc14_,_loc13_,_loc16_,_loc15_);
      }
      
      public function update(param1:Number, param2:Camera3D) : void
      {
         this.plane.setProgress(param1);
         this.plane.updateRotation(param2);
         this.updateTeamColor(param1 / MAX_PROGRESS);
      }
      
      public function addToScene(param1:BattleScene3D, param2:Vector3) : void
      {
         this.pedestal.x = param2.x;
         this.pedestal.y = param2.y;
         this.pedestal.z = param2.z;
         param1.addObject(this.pedestal);
         this.plane.x = param2.x;
         this.plane.y = param2.y;
         this.plane.z = param2.z + CIRCLE_ASCENSION;
         param1.addObject(this.plane);
         this.lightSource.x = param2.x;
         this.lightSource.y = param2.y;
         this.lightSource.z = param2.z + CIRCLE_ASCENSION;
         param1.addObject(this.lightSource);
      }
      
      public function becomeRed() : void
      {
         this.setPedestalMaterial(this.redTextureMaterial);
         this.setLightColor(this.redTeamColor);
      }
      
      public function becomeBlue() : void
      {
         this.setPedestalMaterial(this.blueTextureMaterial);
         this.setLightColor(this.blueTeamColor);
      }
      
      public function becomeNeutral() : void
      {
         this.setPedestalMaterial(this.neutralTextureMaterial);
         this.setLightColor(this.neutralTeamColor);
      }
      
      private function setPedestalMaterial(param1:TextureMaterial) : void
      {
         if(this.currentPedestalMaterial != param1)
         {
            this.currentPedestalMaterial = param1;
            this.pedestal.setMaterialToAllFaces(param1);
         }
      }
      
      private function setLightColor(param1:TeamLightColor) : void
      {
         this.lightSource.color = param1.getColor();
         this.lightSource.intensity = param1.getIntensity();
      }
      
      private function updateTeamColor(param1:Number) : void
      {
         var _loc2_:uint = param1 < 0 ? this.redTeamColor.getColor() : this.blueTeamColor.getColor();
         var _loc3_:Number = param1 < 0 ? this.redTeamColor.getIntensity() : this.blueTeamColor.getIntensity();
         this.lightSource.color = lerpColor(this.neutralTeamColor.getColor(),_loc2_,Math.pow(Math.abs(param1),CURVE));
         this.lightSource.intensity = lerpNumber(this.neutralTeamColor.getIntensity(),_loc3_,Math.pow(Math.abs(param1),CURVE));
      }
   }
}

