package alternativa.tanks.battle.objects.tank.tankskin
{
   import alternativa.engine3d.core.Face;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.tanks.battle.objects.tank.tankskin.dynamic.CircleDynamicSkin;
   import alternativa.tanks.battle.objects.tank.tankskin.dynamic.CylinderDynamicSkin;
   import alternativa.tanks.battle.objects.tank.tankskin.dynamic.DynamicSkin;
   
   public class TankTurretDynamicSkin
   {
      
      private static const BARREL_MATERIAL_NAME:String = "barrel";
      
      private static const MUZZLE_MATERIAL_NAME:String = "muzzle";
      
      private static const BAND_MATERIAL_NAME:String = "band";
      
      private static const BAND_M_MATERIAL_NAME:String = "band_m";
      
      private var _barrelSkin:DynamicSkin;
      
      private var _muzzleSkin:DynamicSkin;
      
      private var _bandSkin:DynamicSkin;
      
      private var _bandMSkin:DynamicSkin;
      
      private var _skins:Vector.<DynamicSkin>;
      
      public function TankTurretDynamicSkin(param1:Mesh)
      {
         super();
         this.init(param1);
      }
      
      private function init(param1:Mesh) : void
      {
         var _loc2_:Face = null;
         for each(_loc2_ in param1.faces)
         {
            if(_loc2_.material != null && _loc2_.material.name == BARREL_MATERIAL_NAME)
            {
               this.initSkins();
               this._barrelSkin.addFace(_loc2_);
            }
            else if(_loc2_.material != null && _loc2_.material.name == MUZZLE_MATERIAL_NAME)
            {
               this.initSkins();
               this._muzzleSkin.addFace(_loc2_);
            }
            else if(_loc2_.material != null && _loc2_.material.name == BAND_MATERIAL_NAME)
            {
               this.initSkins();
               this._bandSkin.addFace(_loc2_);
            }
            else if(_loc2_.material != null && _loc2_.material.name == BAND_M_MATERIAL_NAME)
            {
               this.initSkins();
               this._bandMSkin.addFace(_loc2_);
            }
         }
         if(this._skins != null)
         {
            this._barrelSkin.init();
            this._muzzleSkin.init();
            this._bandSkin.init();
            this._bandMSkin.init();
         }
      }
      
      private function initSkins() : void
      {
         if(this._skins == null)
         {
            this._skins = new Vector.<DynamicSkin>();
            this._barrelSkin = new CylinderDynamicSkin(17 / 256);
            this._muzzleSkin = new CircleDynamicSkin(137.5 / 256,188 / 256);
            this._bandSkin = new CylinderDynamicSkin(9 / 256);
            this._bandMSkin = new CircleDynamicSkin(17 / 256,104 / 256);
            this._skins.push(this._barrelSkin);
            this._skins.push(this._muzzleSkin);
            this._skins.push(this._bandSkin);
            this._skins.push(this._bandMSkin);
         }
      }
      
      public function setMaterial(param1:TextureMaterial) : void
      {
         var _loc2_:DynamicSkin = null;
         if(this.hasSkins())
         {
            for each(_loc2_ in this._skins)
            {
               _loc2_.setMaterial(param1);
            }
         }
      }
      
      private function hasSkins() : Boolean
      {
         return this._skins != null;
      }
      
      public function get barrelSkin() : DynamicSkin
      {
         return this._barrelSkin;
      }
      
      public function get muzzleSkin() : DynamicSkin
      {
         return this._muzzleSkin;
      }
      
      public function get bandSkin() : DynamicSkin
      {
         return this._bandSkin;
      }
      
      public function get bandMSkin() : DynamicSkin
      {
         return this._bandMSkin;
      }
      
      public function destroy() : void
      {
         this._skins = null;
         this._barrelSkin = null;
         this._muzzleSkin = null;
         this._bandSkin = null;
         this._bandMSkin = null;
      }
   }
}

