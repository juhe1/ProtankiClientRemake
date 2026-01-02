package projects.tanks.clients.flash.resources.tanks
{
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.objects.BSP;
   import alternativa.engine3d.objects.Mesh;
   import flash.geom.Vector3D;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   
   public class Tanks3DUtils
   {
      
      public function Tanks3DUtils()
      {
         super();
      }
      
      public static function createTank3DPart(param1:Tanks3DSResource, param2:Boolean) : Tank3DPart
      {
         var _loc9_:Object3D = null;
         var _loc10_:Mesh = null;
         var _loc11_:BSP = null;
         var _loc12_:Object3D = null;
         var _loc13_:int = 0;
         var _loc14_:Object3D = null;
         var _loc15_:Object3D = null;
         var _loc3_:Tank3DPart = new Tank3DPart();
         var _loc4_:Object3DContainer = new Object3DContainer();
         var _loc5_:Vector.<Object3D> = param1.objects;
         var _loc6_:Vector.<Object3D> = param1.parents;
         var _loc7_:Object3D = _loc5_[0];
         var _loc8_:int = 0;
         while(_loc8_ < _loc5_.length)
         {
            _loc9_ = _loc5_[_loc8_];
            if(_loc9_ is Mesh && !Tank3D.EXCLUDED.test(_loc9_.name))
            {
               _loc10_ = Mesh(_loc9_);
               if(_loc10_.sorting != Sorting.DYNAMIC_BSP)
               {
                  _loc10_.sorting = Sorting.DYNAMIC_BSP;
                  _loc10_.calculateFacesNormals(true);
                  _loc10_.optimizeForDynamicBSP();
               }
               _loc11_ = new BSP();
               _loc11_.createTree(Mesh(_loc10_));
               _loc4_.addChild(_loc11_);
               _loc12_ = _loc6_[_loc8_];
               if(_loc12_ == null)
               {
                  _loc11_.x = _loc10_.x - _loc7_.x;
                  _loc11_.y = _loc10_.y - _loc7_.y;
                  _loc11_.z = _loc10_.z - _loc7_.z;
               }
               else
               {
                  _loc13_ = int(_loc5_.indexOf(_loc12_));
                  _loc14_ = _loc4_.getChildAt(_loc13_);
                  _loc11_.x = _loc10_.x + _loc14_.x;
                  _loc11_.y = _loc10_.y + _loc14_.y;
                  _loc11_.z = _loc10_.z + _loc14_.z;
               }
            }
            _loc8_++;
         }
         _loc3_.view = _loc4_;
         _loc3_.lightmap = param1.textures["lightmap.jpg"];
         _loc3_.details = param1.textures["details.png"];
         if(param2)
         {
            _loc15_ = _loc5_[1];
            _loc3_.turretMountPoint = new Vector3D(_loc15_.x,_loc15_.y,_loc15_.z);
         }
         return _loc3_;
      }
   }
}

