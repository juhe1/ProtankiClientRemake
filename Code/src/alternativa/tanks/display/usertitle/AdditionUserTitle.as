package alternativa.tanks.display.usertitle
{
   import alternativa.engine3d.core.Clipping;
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.tanks.model.garage.resistance.ResistancesIcons;
   import alternativa.tanks.models.battle.battlefield.keyboard.DeviceIcons;
   import alternativa.tanks.models.tank.device.TankDevice;
   import alternativa.tanks.models.tank.gearscore.GearScoreInfo;
   import alternativa.tanks.models.tank.resistance.TankResistances;
   import controls.Label;
   import filters.Filters;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.text.GridFitType;
   import flash.text.TextFieldAutoSize;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.battlefield.models.user.resistance.TankResistance;
   
   public class AdditionUserTitle extends Sprite3D
   {
      
      private static var tankPartInfoWidth:Number;
      
      private static var titleHeight:Number;
      
      private static const matrix:Matrix = new Matrix();
      
      private static const label:Label = new Label();
      
      private static const ZERO:Point = new Point();
      
      label.autoSize = TextFieldAutoSize.LEFT;
      label.thickness = 200;
      label.gridFitType = GridFitType.PIXEL;
      
      private var texture:BitmapData = new BitmapData(256,180,true,0);
      
      public function AdditionUserTitle()
      {
         var _loc1_:TextureMaterial = new TextureMaterial(this.texture);
         _loc1_.uploadEveryFrame = true;
         super(256,180,_loc1_);
         perspectiveScale = false;
         alpha = 1;
         visible = true;
         useShadowMap = false;
         useLight = false;
         originY = 1;
         clipping = Clipping.FACE_CULLING;
         sorting = Sorting.AVERAGE_Z;
      }
      
      public static function createTexture(param1:String, param2:Vector.<TankResistance>, param3:TankDevice) : BitmapData
      {
         tankPartInfoWidth = 0;
         var _loc4_:BitmapData = new BitmapData(256,180,true,0);
         var _loc5_:int = 2;
         var _loc6_:int = 42;
         var _loc7_:BitmapData = DeviceIcons.getByDeviceId(param3.getDevice());
         if(_loc7_ != null)
         {
            drawDevice(_loc6_,param2.length == 0 ? _loc5_ + 37 : _loc5_,_loc7_,_loc4_);
         }
         _loc5_ += DeviceIcons.backgroundIcon.height;
         if(param2.length != 0)
         {
            drawResistances(_loc6_,_loc5_,param2,_loc4_);
         }
         _loc5_ += 40;
         drawInfo(_loc6_,_loc5_,param1,_loc4_);
         _loc5_ += 15;
         titleHeight = _loc5_;
         _loc4_.applyFilter(_loc4_,_loc4_.rect,ZERO,Filters.SHADOW_FILTER);
         return _loc4_;
      }
      
      private static function drawInfo(param1:int, param2:int, param3:String, param4:BitmapData) : void
      {
         label.text = param3;
         matrix.tx = param1 + 25;
         matrix.ty = param2;
         param4.draw(label,matrix,null,null,null,true);
         matrix.tx += label.width + 10;
         tankPartInfoWidth = Math.max(tankPartInfoWidth,matrix.tx + label.width + 2);
      }
      
      private static function drawResistances(param1:int, param2:int, param3:Vector.<TankResistance>, param4:BitmapData) : void
      {
         var _loc5_:TankResistance = null;
         var _loc6_:BitmapData = null;
         var _loc7_:BitmapData = null;
         var _loc8_:Number = NaN;
         var _loc9_:Label = null;
         var _loc10_:Number = NaN;
         matrix.tx = param1 + ((3 - param3.length) * ResistancesIcons.resistanceIcon.width >> 1);
         matrix.ty = param2;
         for each(_loc5_ in param3)
         {
            _loc6_ = ResistancesIcons.resistanceIcon;
            param4.draw(_loc6_,matrix,null,null,null,true);
            _loc7_ = ResistancesIcons.getBitmapDataByName(_loc5_.resistanceProperty.name);
            _loc8_ = _loc6_.height - _loc7_.height >> 1;
            matrix.tx += _loc6_.width - _loc7_.width >> 1;
            matrix.ty += _loc8_;
            param4.draw(_loc7_,matrix,null,null,null,true);
            _loc9_ = new Label();
            _loc9_.text = _loc5_.resistanceInPercent == 100 ? "??" : _loc5_.resistanceInPercent.toString() + "%";
            matrix.ty += _loc6_.height - 3;
            _loc10_ = _loc6_.width - _loc9_.textWidth + 2 >> 1;
            matrix.tx += _loc10_;
            param4.draw(_loc9_,matrix,null,null,null,true);
            matrix.tx += _loc6_.width + 3 - _loc10_;
            matrix.ty -= _loc8_ + _loc6_.height - 3;
         }
      }
      
      private static function drawDevice(param1:int, param2:int, param3:BitmapData, param4:BitmapData) : void
      {
         matrix.tx = param1 + (DeviceIcons.backgroundIcon.width >> 1);
         matrix.ty = param2;
         param4.draw(DeviceIcons.backgroundIcon,matrix,null,null,null,true);
         matrix.tx += DeviceIcons.backgroundIcon.width - param3.width >> 1;
         matrix.ty += DeviceIcons.backgroundIcon.height - param3.height >> 1;
         param4.draw(param3,matrix,null,null,null,true);
      }
      
      public function updateTexture(param1:uint, param2:IGameObject, param3:int) : void
      {
         var _loc4_:GearScoreInfo = GearScoreInfo(param2.adapt(GearScoreInfo));
         var _loc5_:String = "GS: " + _loc4_.getScore();
         var _loc6_:TankResistances = TankResistances(param2.adapt(TankResistances));
         var _loc7_:Vector.<TankResistance> = _loc6_.getResistances();
         var _loc8_:TankDevice = TankDevice(param2.adapt(TankDevice));
         label.color = param1;
         var _loc9_:BitmapData = createTexture(_loc5_,_loc7_,_loc8_);
         this.cleanTexture();
         this.texture.draw(_loc9_);
         _loc9_.dispose();
         var _loc10_:Number = Math.max(32 * _loc7_.length + 4,tankPartInfoWidth);
         width = _loc10_;
         titleHeight += param3;
         height = titleHeight;
         bottomRightU = _loc10_ / this.texture.width;
         bottomRightV = titleHeight / this.texture.height;
      }
      
      private function cleanTexture() : *
      {
         this.texture.dispose();
         this.texture = new BitmapData(256,180,true,0);
         material = new TextureMaterial(this.texture);
         material.uploadEveryFrame = true;
      }
      
      public function dispose() : void
      {
         if(material != null)
         {
            material.dispose();
         }
         if(this.texture != null)
         {
            this.texture.dispose();
         }
         this.texture = null;
         material = null;
      }
   }
}

