package alternativa.tanks.gui.friends.list.refferals
{
   import controls.TankWindowInner;
   import controls.statassets.StatLineBase;
   import controls.statassets.StatLineNormal;
   import controls.statassets.StatLineNormalActive;
   import controls.statassets.StatLineSelected;
   import controls.statassets.StatLineSelectedActive;
   import fl.controls.List;
   import fl.data.DataProvider;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import forms.events.StatListEvent;
   import projects.tanks.client.panel.model.referrals.ReferralIncomeData;
   import utils.ScrollStyleUtils;
   
   public class ReferralStatList extends Sprite
   {
      
      private var inner:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      
      private var header:ReferralStatHeader = new ReferralStatHeader();
      
      private var list:List = new List();
      
      private var dp:DataProvider = new DataProvider();
      
      private var currentSort:int = 1;
      
      public function ReferralStatList()
      {
         super();
         this.list.rowHeight = 20;
         this.list.setStyle("cellRenderer",ReferralStatListRenderer);
         this.list.dataProvider = this.dp;
         this.list.focusEnabled = true;
         ScrollStyleUtils.setGreenStyle(this.list);
         addChild(this.inner);
         this.inner.addChild(this.header);
         this.header.y = 4;
         this.header.x = 4;
         this.inner.addChild(this.list);
         this.list.y = this.header.y + this.header.height + 2;
         this.list.x = this.header.x;
         this.header.addEventListener(StatListEvent.UPDATE_SORT,this.changeSort);
      }
      
      private function clear() : void
      {
         var _loc1_:Object = {};
         var _loc2_:int = 0;
         while(_loc2_ < this.dp.length)
         {
            _loc1_ = this.dp.getItemAt(_loc2_);
            _loc1_.sort = this.currentSort;
            this.dp.replaceItemAt(_loc1_,_loc2_);
            _loc2_++;
         }
         this.sort();
      }
      
      private function sort() : void
      {
         if(this.currentSort == 0)
         {
            this.dp.sortOn("uid",Array.CASEINSENSITIVE);
         }
         else
         {
            this.dp.sortOn("income",Array.NUMERIC | Array.DESCENDING);
         }
         var _loc1_:Boolean = this.list.maxVerticalScrollPosition > 0;
         var _loc2_:Number = _loc1_ ? this.header.width + 25 : this.header.width;
         this.list.width = _loc1_ ? this.header.width + 7 : this.header.width;
         ReferralStatLineBackgroundNormal.bg = new Bitmap(this.setBackground(_loc2_,false));
         ReferalStatLineBackgroundSelected.bg = new Bitmap(this.setBackground(_loc2_,true));
         this.dp.invalidate();
      }
      
      public function addReferrals(param1:Vector.<ReferralIncomeData>) : void
      {
         var _loc2_:ReferralIncomeData = null;
         var _loc3_:Object = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = {};
            _loc3_.userId = _loc2_.user;
            _loc3_.income = _loc2_.income;
            _loc3_.sort = this.currentSort;
            this.dp.addItem(_loc3_);
         }
         this.header.setDefaultSort();
         this.currentSort = 1;
         this.sort();
      }
      
      private function setBackground(param1:int, param2:Boolean) : BitmapData
      {
         var _loc4_:StatLineBase = null;
         var _loc3_:Sprite = new Sprite();
         var _loc5_:Array = [0,param1 - 120,param1 - 1];
         var _loc6_:BitmapData = new BitmapData(param1,20,true,0);
         var _loc7_:uint = 0;
         while(_loc7_ < 2)
         {
            _loc4_ = this.currentSort == _loc7_ ? (param2 ? new StatLineSelectedActive() : new StatLineNormalActive()) : (param2 ? new StatLineSelected() : new StatLineNormal());
            _loc4_.width = _loc5_[_loc7_ + 1] - _loc5_[_loc7_] - 2;
            _loc4_.height = 18;
            _loc4_.x = _loc5_[_loc7_];
            _loc3_.addChild(_loc4_);
            _loc7_++;
         }
         _loc6_.draw(_loc3_);
         return _loc6_;
      }
      
      private function changeSort(param1:StatListEvent) : void
      {
         this.currentSort = param1.sortField;
         this.clear();
      }
      
      public function resize(param1:Number, param2:Number) : void
      {
         this.inner.height = param2;
         this.list.height = this.inner.height - 32;
         this.inner.width = param1;
         this.header.width = param1 - 6;
         this.list.width = this.header.width;
      }
      
      public function hide() : void
      {
         this.dp.removeAll();
      }
   }
}

