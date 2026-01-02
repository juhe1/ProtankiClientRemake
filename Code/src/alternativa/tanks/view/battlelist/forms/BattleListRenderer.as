package alternativa.tanks.view.battlelist.forms
{
   import alternativa.tanks.view.battlelist.battleitem.renderer.full.CellRendererFullUp;
   import alternativa.tanks.view.battlelist.battleitem.renderer.full.CellRendererFullUpSelected;
   import alternativa.tanks.view.battlelist.battleitem.renderer.normal.CellNormalSelected;
   import alternativa.tanks.view.battlelist.battleitem.renderer.unavailable.CellUnavailableSelected;
   import controls.cellrenderer.CellNormal;
   import controls.cellrenderer.CellUnavailable;
   import fl.controls.listClasses.CellRenderer;
   import fl.controls.listClasses.ListData;
   import flash.display.DisplayObject;
   
   public class BattleListRenderer extends CellRenderer
   {
      
      private var access:Boolean = true;
      
      private var nicon:DisplayObject;
      
      private var sicon:DisplayObject;
      
      private var isFull:Boolean;
      
      public function BattleListRenderer()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         _data = param1;
         this.access = param1.accessible;
         this.nicon = param1.iconNormal;
         this.sicon = param1.iconSelected;
         this.isFull = param1.isFull;
         this.setupBackgroundStyles();
      }
      
      override public function set listData(param1:ListData) : void
      {
         _listData = param1;
         label = _listData.label;
         if(this.nicon != null && this.sicon != null)
         {
            setStyle("icon",this.nicon);
            setStyle("selectedUpIcon",this.sicon);
            setStyle("selectedOverIcon",this.sicon);
            setStyle("selectedDownIcon",this.sicon);
         }
      }
      
      override protected function drawBackground() : void
      {
         var _loc1_:String = enabled ? mouseState : "disabled";
         if(selected)
         {
            _loc1_ = "selected" + _loc1_.substr(0,1).toUpperCase() + _loc1_.substr(1);
         }
         _loc1_ += "Skin";
         var _loc2_:DisplayObject = background;
         background = getDisplayObjectInstance(getStyleValue(_loc1_));
         addChildAt(background,0);
         if(_loc2_ != null && _loc2_ != background)
         {
            removeChild(_loc2_);
         }
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         background.width = width - 4;
         background.height = height;
      }
      
      override protected function drawIcon() : void
      {
         var _loc1_:DisplayObject = icon;
         var _loc2_:String = enabled ? mouseState : "disabled";
         if(selected)
         {
            _loc2_ = "selected" + _loc2_.substr(0,1).toUpperCase() + _loc2_.substr(1);
         }
         _loc2_ += "Icon";
         var _loc3_:Object = getStyleValue(_loc2_);
         if(_loc3_ == null)
         {
            _loc3_ = getStyleValue("icon");
         }
         if(_loc3_ != null)
         {
            icon = getDisplayObjectInstance(_loc3_);
         }
         if(icon != null)
         {
            addChildAt(icon,1);
         }
         if(_loc1_ != null && _loc1_ != icon && _loc1_.parent == this)
         {
            removeChild(_loc1_);
         }
      }
      
      private function setupBackgroundStyles() : void
      {
         if(this.access)
         {
            if(this.isFull)
            {
               setStyle("upSkin",CellRendererFullUp);
               setStyle("overSkin",CellRendererFullUp);
               setStyle("downSkin",CellRendererFullUp);
               setStyle("selectedUpSkin",CellRendererFullUpSelected);
               setStyle("selectedOverSkin",CellRendererFullUpSelected);
               setStyle("selectedDownSkin",CellRendererFullUpSelected);
            }
            else
            {
               setStyle("upSkin",CellNormal);
               setStyle("overSkin",CellNormal);
               setStyle("downSkin",CellNormal);
               setStyle("selectedUpSkin",CellNormalSelected);
               setStyle("selectedOverSkin",CellNormalSelected);
               setStyle("selectedDownSkin",CellNormalSelected);
            }
         }
         else
         {
            setStyle("upSkin",CellUnavailable);
            setStyle("overSkin",CellUnavailable);
            setStyle("downSkin",CellUnavailable);
            setStyle("selectedUpSkin",CellUnavailableSelected);
            setStyle("selectedOverSkin",CellUnavailableSelected);
            setStyle("selectedDownSkin",CellUnavailableSelected);
         }
      }
   }
}

