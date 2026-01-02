package alternativa.tanks.gui
{
   import alternativa.tanks.gui.upgrade.UpgradeColors;
   import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
   import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
   import assets.Diamond;
   import controls.base.LabelBase;
   import flash.display.Sprite;
   import flash.text.TextFormatAlign;
   import forms.ranks.SmallRankIcon;
   import utils.FontParamsUtil;
   
   public class ModInfoRow extends Sprite
   {
      
      private static const RANK_WIDTH:int = 13;
      
      public const h:int = 17;
      
      public const hSpace:int = 10;
      
      public var labels:Vector.<LabelBase>;
      
      public var costLabel:LabelBase;
      
      public var crystalIcon:Diamond;
      
      public var rankIcon:SmallRankIcon;
      
      public var upgradeIndicator:UpgradeIndicator;
      
      public var costWidth:int;
      
      private var numberProperties:int = 0;
      
      private var _width:int;
      
      public function ModInfoRow(param1:int, param2:int)
      {
         var _loc4_:LabelBase = null;
         super();
         this._width = param2;
         this.labels = new Vector.<LabelBase>(8);
         var _loc3_:int = 0;
         while(_loc3_ < 8)
         {
            _loc4_ = new LabelBase();
            _loc4_.color = 16777215;
            _loc4_.align = TextFormatAlign.CENTER;
            _loc4_.text = "ABC123";
            addChild(_loc4_);
            this.labels[_loc3_] = _loc4_;
            _loc4_.y = this.h - _loc4_.height >> 1;
            _loc3_++;
         }
         this.costLabel = new LabelBase();
         this.costLabel.color = 16777215;
         this.costLabel.align = TextFormatAlign.RIGHT;
         this.costLabel.text = "ABC123";
         addChild(this.costLabel);
         this.costLabel.y = this.h - this.costLabel.height >> 1;
         this.crystalIcon = new Diamond();
         addChild(this.crystalIcon);
         this.crystalIcon.y = this.h - this.crystalIcon.height >> 1;
         this.rankIcon = new SmallRankIcon();
         addChild(this.rankIcon);
         this.rankIcon.y = (this.h - this.rankIcon.height >> 1) + 1;
         this.upgradeIndicator = new UpgradeIndicator(param1);
         addChild(this.upgradeIndicator);
         this.upgradeIndicator.y = (this.h - this.upgradeIndicator.height >> 1) + 1;
      }
      
      public function select() : void
      {
         var _loc2_:LabelBase = null;
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = this.labels[_loc1_] as LabelBase;
            _loc2_.color = 16777215;
            _loc2_.sharpness = -100;
            _loc2_.thickness = 100;
            _loc1_++;
         }
         this.costLabel.sharpness = -100;
         this.costLabel.thickness = 100;
      }
      
      public function unselect() : void
      {
         var _loc2_:LabelBase = null;
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = this.labels[_loc1_] as LabelBase;
            _loc2_.color = 16777215;
            _loc2_.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
            _loc2_.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
            _loc1_++;
         }
         this.costLabel.color = 16777215;
         this.costLabel.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
         this.costLabel.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
      }
      
      public function setLabelsNum(param1:int) : void
      {
         this.numberProperties = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this.labels.length)
         {
            this.labels[_loc2_].visible = _loc2_ < param1;
            _loc2_++;
         }
      }
      
      public function setLabelsText(param1:UpgradableItemParams, param2:Vector.<UpgradableItemPropertyValue>) : void
      {
         var _loc4_:UpgradableItemPropertyValue = null;
         var _loc5_:LabelBase = null;
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            _loc4_ = param2[_loc3_];
            _loc5_ = this.labels[_loc3_];
            _loc5_.text = _loc4_.getValue(param1.getLevel());
            _loc5_.color = UpgradeColors.getColor(param1,_loc4_);
            _loc3_++;
         }
      }
      
      public function updatePositions() : void
      {
         var _loc4_:LabelBase = null;
         this.crystalIcon.x = this._width - this.crystalIcon.width - this.hSpace;
         this.costLabel.x = this.crystalIcon.x - 3 - this.costLabel.width;
         var _loc1_:Number = this.crystalIcon.x - 3 - this.costWidth;
         this.rankIcon.x = _loc1_ - this.hSpace - RANK_WIDTH;
         this.upgradeIndicator.x = this.rankIcon.x - this.upgradeIndicator.width - this.hSpace;
         var _loc2_:Number = (this.upgradeIndicator.x - 2 * this.hSpace) / this.numberProperties;
         var _loc3_:int = 0;
         while(_loc3_ < this.numberProperties)
         {
            _loc4_ = this.labels[_loc3_];
            _loc4_.x = Math.round(this.hSpace + _loc2_ * _loc3_ + (_loc2_ - _loc4_.width) / 2);
            _loc3_++;
         }
      }
      
      public function getPositions() : Vector.<Number>
      {
         var _loc3_:LabelBase = null;
         var _loc1_:Vector.<Number> = new Vector.<Number>(this.numberProperties,true);
         var _loc2_:int = 0;
         while(_loc2_ < this.numberProperties)
         {
            _loc3_ = this.labels[_loc2_];
            _loc1_[_loc2_] = _loc3_.x + _loc3_.width * 0.5;
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

