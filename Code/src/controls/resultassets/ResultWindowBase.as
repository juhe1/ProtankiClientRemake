package controls.resultassets
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class ResultWindowBase extends Sprite
   {
      
      protected var tl:BitmapData;
      
      protected var px:BitmapData;
      
      protected var _width:int = 10;
      
      protected var _height:int = 10;
      
      public function ResultWindowBase()
      {
         super();
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = Math.floor(param1);
         this.draw();
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set height(param1:Number) : void
      {
         this._height = Math.floor(param1);
         this.draw();
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      protected function draw() : void
      {
         var _loc2_:Matrix = null;
         var _loc1_:Graphics = this.graphics;
         _loc1_.clear();
         _loc1_.beginBitmapFill(this.tl);
         _loc1_.drawRect(0,0,4,4);
         _loc1_.endFill();
         _loc2_ = new Matrix();
         _loc2_.rotate(Math.PI * 0.5);
         _loc2_.translate(this._width - 4,0);
         _loc1_.beginBitmapFill(this.tl,_loc2_);
         _loc1_.drawRect(this._width - 4,0,4,4);
         _loc1_.endFill();
         _loc2_ = new Matrix();
         _loc2_.rotate(Math.PI);
         _loc2_.translate(this._width - 4,this._height - 4);
         _loc1_.beginBitmapFill(this.tl,_loc2_);
         _loc1_.drawRect(this._width - 4,this._height - 4,4,4);
         _loc1_.endFill();
         _loc2_ = new Matrix();
         _loc2_.rotate(Math.PI * 1.5);
         _loc2_.translate(0,this._height - 4);
         _loc1_.beginBitmapFill(this.tl,_loc2_);
         _loc1_.drawRect(0,this._height - 4,4,4);
         _loc1_.endFill();
         _loc1_.beginBitmapFill(this.px);
         _loc1_.drawRect(4,0,this._width - 8,this._height);
         _loc1_.drawRect(0,4,4,this._height - 8);
         _loc1_.drawRect(this._width - 4,4,4,this._height - 8);
         _loc1_.endFill();
      }
   }
}

