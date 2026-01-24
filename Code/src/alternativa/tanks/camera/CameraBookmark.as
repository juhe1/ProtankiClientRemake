package alternativa.tanks.camera
{
   import alternativa.math.Vector3;
   import alternativa.tanks.battle.BattleService;
   
   public class CameraBookmark
   {
      
      [Inject] // added
      public static var battleService:BattleService;
      
      public var position:Vector3 = new Vector3();
      
      public var eulerAnlges:Vector3 = new Vector3();
      
      public function CameraBookmark()
      {
         super();
      }
      
      public function saveCurrentPossitionCamera() : void
      {
         var _loc1_:GameCamera = battleService.getBattleScene3D().getCamera();
         this.position.x = _loc1_.x;
         this.position.y = _loc1_.y;
         this.position.z = _loc1_.z;
         this.eulerAnlges.x = _loc1_.rotationX;
         this.eulerAnlges.y = _loc1_.rotationY;
         this.eulerAnlges.z = _loc1_.rotationZ;
      }
   }
}

