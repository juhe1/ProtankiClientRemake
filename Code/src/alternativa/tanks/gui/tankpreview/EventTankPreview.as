package alternativa.tanks.gui.tankpreview
{
   import alternativa.engine3d.containers.KDContainer;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.tanks.service.garage.GarageService;
   import flash.geom.Vector3D;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import projects.tanks.clients.flash.resources.tanks.Tank3D;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
   
   public class EventTankPreview extends TankPreviewWindow
   {
      
      [Inject]
      public static var lobbyLayoutService:ILobbyLayoutService;
      
      [Inject]
      public static var garageService:GarageService;
      
      public function EventTankPreview()
      {
         super();
      }
      
      private function createTank() : void
      {
         tank = new Tank3D();
         tank.z = -1;
         tank.y = 0;
         tank.x = 0;
      }
      
      override protected function addGarageObjectsToScene(param1:Tanks3DSResource) : void
      {
         var _loc5_:Mesh = null;
         var _loc6_:TextureMaterial = null;
         camera.x = 0;
         var _loc2_:int = int(param1.objects.length);
         var _loc3_:Vector.<Object3D> = new Vector.<Object3D>();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = param1.objects[_loc4_] as Mesh;
            if(_loc5_ != null)
            {
               _loc5_.setParent(null);
               _loc6_ = TextureMaterial(_loc5_.faceList.material);
               _loc6_.texture = param1.getTextureForObject(_loc4_);
               _loc5_.setMaterialToAllFaces(_loc6_);
               _loc5_.sorting = 2;
               _loc3_.push(_loc5_);
            }
            _loc4_++;
         }
         kdTree = new KDContainer();
         kdTree.createTree(_loc3_);
         this.createTank();
         createDrone(new Vector3D(100,-100,100));
         kdTree.addChild(tank);
         kdTree.addChild(drone);
         hangarContainer.addChild(kdTree);
      }
      
      override protected function createScene() : void
      {
      }
   }
}

