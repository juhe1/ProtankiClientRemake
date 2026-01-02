package alternativa.tanks.gui
{
   import controls.base.LabelBase;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class ModTable extends Sprite
   {
      
      private static const upgradeSelectionLeftClass:Class = ModTable_upgradeSelectionLeftClass;
      
      private static const upgradeSelectionCenterClass:Class = ModTable_upgradeSelectionCenterClass;
      
      private var _maxCostWidth:int;
      
      public var constWidth:int;
      
      public var rows:Vector.<ModInfoRow>;
      
      public const vSpace:int = 0;
      
      private var selection:Shape;
      
      private var selectedRowIndex:int = -1;
      
      private var _width:int;
      
      public function ModTable(param1:int)
      {
         var _loc3_:ModInfoRow = null;
         this.rows = new Vector.<ModInfoRow>();
         super();
         this._width = param1;
         this.selection = new Shape();
         addChild(this.selection);
         this.selection.x = 3;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = new ModInfoRow(_loc2_,this._width);
            addChild(_loc3_);
            _loc3_.y = (_loc3_.h + this.vSpace) * _loc2_;
            this.rows.push(_loc3_);
            _loc2_++;
         }
         this.resizeSelection(this._width);
      }
      
      public function select(param1:int) : void
      {
         var _loc2_:ModInfoRow = null;
         if(this.selectedRowIndex != -1)
         {
            _loc2_ = this.rows[this.selectedRowIndex];
            _loc2_.unselect();
         }
         this.selectedRowIndex = param1;
         this.selection.y = (ModInfoRow(this.rows[0]).h + this.vSpace) * param1;
         this.selection.visible = true;
         _loc2_ = this.rows[this.selectedRowIndex];
         _loc2_.select();
      }
      
      public function resetSelection() : void
      {
         var _loc1_:ModInfoRow = null;
         this.selection.visible = false;
         if(this.selectedRowIndex != -1)
         {
            _loc1_ = this.rows[this.selectedRowIndex];
            _loc1_.unselect();
         }
         this.selectedRowIndex = -1;
      }
      
      private function resizeSelection(param1:int) : void
      {
         var _loc2_:int = param1 - 6;
         var _loc3_:BitmapData = new upgradeSelectionLeftClass().bitmapData;
         this.selection.graphics.clear();
         this.selection.graphics.beginBitmapFill(_loc3_);
         this.selection.graphics.drawRect(0,0,_loc3_.width,_loc3_.height);
         var _loc4_:BitmapData = new upgradeSelectionCenterClass().bitmapData;
         this.selection.graphics.beginBitmapFill(_loc4_);
         this.selection.graphics.drawRect(_loc3_.width,0,_loc2_ - _loc3_.width * 2,_loc4_.height);
         var _loc5_:Matrix = new Matrix(-1,0,0,1,_loc2_,0);
         this.selection.graphics.beginBitmapFill(_loc3_,_loc5_);
         this.selection.graphics.drawRect(_loc2_ - _loc3_.width,0,_loc3_.width,_loc3_.height);
         this.selection.graphics.endFill();
      }
      
      public function correctNonintegralValues() : void
      {
         var _loc5_:int = 0;
         var _loc6_:LabelBase = null;
         var _loc7_:int = 0;
         var _loc1_:Array = new Array();
         var _loc2_:ModInfoRow = this.rows[0];
         var _loc3_:int = int(_loc2_.labels.length);
         var _loc4_:int = 0;
         while(_loc4_ < 4)
         {
            _loc2_ = this.rows[_loc4_] as ModInfoRow;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc6_ = _loc2_.labels[_loc5_] as LabelBase;
               if(_loc6_.text.indexOf(".") != -1)
               {
                  _loc1_.push(_loc5_);
               }
               _loc5_++;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc2_ = this.rows[_loc4_];
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               _loc7_ = int(_loc1_[_loc5_]);
               _loc6_ = _loc2_.labels[_loc7_] as LabelBase;
               if(_loc6_.text.indexOf(".") == -1)
               {
                  _loc6_.text += ".0";
               }
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      public function set maxCostWidth(param1:int) : void
      {
         this._maxCostWidth = param1;
         var _loc2_:ModInfoRow = this.rows[0];
         this.constWidth = _loc2_.upgradeIndicator.width + _loc2_.rankIcon.width + 3 + _loc2_.crystalIcon.width + this._maxCostWidth + _loc2_.hSpace * 3;
         var _loc3_:int = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = this.rows[_loc3_] as ModInfoRow;
            _loc2_.costWidth = this._maxCostWidth;
            _loc3_++;
         }
      }
   }
}

