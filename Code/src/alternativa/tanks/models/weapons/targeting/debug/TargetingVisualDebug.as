package alternativa.tanks.models.weapons.targeting.debug
{
   import alternativa.engine3d.primitives.Box;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.osgi.service.console.variables.ConsoleVarInt;
   import alternativa.tanks.battle.BattleService;
   import alternativa.tanks.models.weapon.AllGlobalGunParams;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.FillMaterial;
   import flash.geom.Matrix3D;
   
   public class TargetingVisualDebug
   {
      
      [Inject] // added
      public static var battleService:BattleService;

      public var debugEnabled:Boolean = false;
      
      private var rotationMatrix:Matrix3 = new Matrix3();
      private var material:FillMaterial = new FillMaterial(65535,0.9);
      private var boxes:Vector.<Box> = new Vector.<Box>();

      private var xAxis:Vector3 = new Vector3();
      private var zAxis:Vector3 = new Vector3();
      
      public function TargetingVisualDebug()
      {
         super();
      }
      
      public function reset() : void
      {
         for each (var box:Box in this.boxes)
         {
            if (box.parent != null)
            {
               box.parent.removeChild(box);
            }
         }
         this.boxes.length = 0;
      }
      
      public function addRay(param1:AllGlobalGunParams, dir:Vector3, len:Number) : void
      {
         if (!debugEnabled) {
            return;
         }

         // Box dimensions
         var width:Number = 5;
         var length:Number = len;
         var height:Number = 5;

         // Create the box
         var box:Box = createBox(width, length, height);
         box.name = "TargetingRayDebug";
         box.setMaterialToAllFaces(this.material);

         var dirNorm:Vector3 = dir.clone();
         dirNorm.normalize();

         // Calculate center position of the box along the ray
         var centerX:Number = param1.muzzlePosition.x + dirNorm.x * (len * 0.5);
         var centerY:Number = param1.muzzlePosition.y + dirNorm.y * (len * 0.5);
         var centerZ:Number = param1.muzzlePosition.z + dirNorm.z * (len * 0.5);

         // Build a Matrix3D that aligns the box with the direction
         var up:Vector3 = new Vector3(0, 0, 1); // Z-up
         // If dir is parallel to up, pick another up vector
         if (Math.abs(dirNorm.z) > 0.999) {
            up = new Vector3(0, 1, 0);
         }
         var right:Vector3 = new Vector3();
         right.cross2(dirNorm, up);
         right.normalize();
         var newUp:Vector3 = new Vector3();
         newUp.cross2(right, dirNorm);
         newUp.normalize();

         // Matrix3D row-major: [right.x, right.y, right.z, 0, up.x, up.y, up.z, 0, dir.x, dir.y, dir.z, 0, tx, ty, tz, 1]
         // For Alternativa3D, the box's local forward is likely along the Y axis, not Z. So use dirNorm as the Y axis.
         // right = X, dirNorm = Y, newUp = Z
         var matrix3d:Matrix3D = new Matrix3D();
         matrix3d.rawData = Vector.<Number>([
            right.x, right.y, right.z, 0,
            dirNorm.x, dirNorm.y, dirNorm.z, 0,
            newUp.x, newUp.y, newUp.z, 0,
            centerX, centerY, centerZ, 1
         ]);
         box.matrix = matrix3d;

         battleService.getBattleScene3D().addObject(box);
      }
      
      private function createBox(param1:Number, param2:Number, param3:Number) : Box
      {
         var box:Box = new Box(param1,param2,param3);
         this.boxes.push(box);
         return box;
      }
   }
}

