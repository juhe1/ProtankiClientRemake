package alternativa.tanks.models.battle.assault
{
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.core.Vertex;
   import alternativa.engine3d.core.Wrapper;
   import alternativa.engine3d.lights.OmniLight;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.battle.scene3d.Renderer;
   import alternativa.tanks.models.battle.gui.markers.PointIndicatorStateProvider;
   import alternativa.tanks.models.controlpoints.hud.KeyPointView;
   import alternativa.tanks.models.teamlight.ModeLight;
   import alternativa.tanks.models.teamlight.TeamLightColor;
   import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import projects.tanks.client.battleservice.BattleMode;
   import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
   
   public class PointBaseIndicatorPlane extends Mesh implements Renderer
   {
      
      [Inject]
      public static var lightingEffectsService:ILightingEffectsService;
      
      public static const CIRCLE_SIZE:Number = 1000;
      
      private var battleService:BattleService;
      
      private var material:Material;
      
      private var _faces:Vector.<Face>;
      
      private var uvs:Vector.<Point> = new Vector.<Point>();
      
      private var verts:Vector.<Vector3D> = new Vector.<Vector3D>();
      
      private var lightSource:OmniLight;
      
      private var indicatorStateProvider:PointIndicatorStateProvider;
      
      public function PointBaseIndicatorPlane(param1:BattleTeam, param2:Material, param3:BattleService, param4:PointIndicatorStateProvider)
      {
         super();
         this.indicatorStateProvider = param4;
         this.material = param2;
         this.battleService = param3;
         useShadowMap = false;
         useLight = false;
         shadowMapAlphaThreshold = 2;
         depthMapAlphaThreshold = 2;
         this.createGeometry();
         if(param1 != null)
         {
            this.initLight(param1);
         }
         this.setPosition();
         param3.getBattleScene3D().addObjectToExclusion(this);
      }
      
      private function createGeometry() : void
      {
         var _loc1_:Vertex = null;
         var _loc2_:Vertex = null;
         var _loc3_:Vertex = null;
         var _loc4_:Number = CIRCLE_SIZE * 0.5;
         var _loc5_:Number = CIRCLE_SIZE * 0.5;
         this.verts[0] = new Vector3D(0,_loc5_,0);
         this.verts[1] = new Vector3D(-_loc4_,0,0);
         this.verts[2] = new Vector3D(0,-_loc5_,0);
         this.verts[3] = new Vector3D(_loc4_,0,0);
         this.uvs[0] = new Point(0.5,-0.5);
         this.uvs[1] = new Point(-0.5,0.5);
         this.uvs[2] = new Point(0.5,1.5);
         this.uvs[3] = new Point(1.5,0.5);
         this._faces = new Vector.<Face>();
         _loc1_ = this.createVertex(-_loc4_,0,0,-0.5,0.5);
         _loc2_ = this.createVertex(0,0,0,0.5,0.5);
         _loc3_ = this.createVertex(0,_loc5_,0,0.5,-0.5);
         this._faces[0] = this.createFace(_loc1_,_loc2_,_loc3_,this.material);
         _loc1_ = this.createVertex(0,-_loc5_,0,0.5,1.5);
         _loc2_ = this.createVertex(0,0,0,0.5,0.5);
         _loc3_ = this.createVertex(-_loc4_,0,0,-0.5,0.5);
         this._faces[1] = this.createFace(_loc1_,_loc2_,_loc3_,this.material);
         _loc1_ = this.createVertex(_loc4_,0,0,1.5,0.5);
         _loc2_ = this.createVertex(0,0,0,0.5,0.5);
         _loc3_ = this.createVertex(0,-_loc5_,0,0.5,1.5);
         this._faces[2] = this.createFace(_loc1_,_loc2_,_loc3_,this.material);
         _loc1_ = this.createVertex(0,_loc5_,0,0.5,-0.5);
         _loc2_ = this.createVertex(0,0,0,0.5,0.5);
         _loc3_ = this.createVertex(_loc4_,0,0,1.5,0.5);
         this._faces[3] = this.createFace(_loc1_,_loc2_,_loc3_,this.material);
         _loc1_ = this.createVertex(0,0,0,0,0);
         _loc2_ = this.createVertex(0,0,0,0.5,0.5);
         _loc3_ = this.createVertex(0,0,0,0,0);
         this._faces[4] = this.createFace(_loc1_,_loc2_,_loc3_,this.material);
      }
      
      private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Vertex
      {
         var _loc6_:Vertex = new Vertex();
         _loc6_.x = param1;
         _loc6_.y = param2;
         _loc6_.z = param3;
         _loc6_.u = param4;
         _loc6_.v = param5;
         _loc6_.next = vertexList;
         vertexList = _loc6_;
         return _loc6_;
      }
      
      private function createFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Material) : Face
      {
         var _loc5_:Face = null;
         _loc5_ = new Face();
         _loc5_.material = param4;
         _loc5_.wrapper = new Wrapper();
         _loc5_.wrapper.vertex = param1;
         _loc5_.wrapper.next = new Wrapper();
         _loc5_.wrapper.next.vertex = param2;
         _loc5_.wrapper.next.next = new Wrapper();
         _loc5_.wrapper.next.next.vertex = param3;
         _loc5_.normalX = 0;
         _loc5_.normalY = 0;
         _loc5_.normalZ = 1;
         _loc5_.offset = 0;
         _loc5_.next = faceList;
         faceList = _loc5_;
         return _loc5_;
      }
      
      public function updateRotation(param1:Camera3D) : void
      {
         rotationX = param1.rotationX - Math.PI;
         rotationY = 0;
         rotationZ = param1.rotationZ;
      }
      
      public function render(param1:int, param2:int) : void
      {
         visible = this.indicatorStateProvider.isIndicatorActive();
         if(Boolean(this.lightSource))
         {
            this.lightSource.visible = visible;
         }
         this.setPosition();
         this.updateRotation(this.battleService.getBattleScene3D().getCamera());
      }
      
      private function setPosition() : void
      {
         var _loc1_:Vector3 = this.indicatorStateProvider.getIndicatorPosition();
         x = _loc1_.x;
         y = _loc1_.y;
         z = _loc1_.z + KeyPointView.CIRCLE_ASCENSION;
         if(Boolean(this.lightSource))
         {
            this.lightSource.x = x;
            this.lightSource.y = y;
            this.lightSource.z = z;
         }
      }
      
      private function initLight(param1:BattleTeam) : void
      {
         var _loc2_:ModeLight = lightingEffectsService.getLightForMode(BattleMode.CP);
         var _loc3_:TeamLightColor = _loc2_.getLightForTeam(param1);
         this.lightSource = new OmniLight(0,_loc2_.getAttenuationBegin(),_loc2_.getAttenuationEnd());
         this.lightSource.color = _loc3_.getColor();
         this.lightSource.intensity = _loc3_.getIntensity();
         this.battleService.getBattleScene3D().addObject(this.lightSource);
      }
   }
}

