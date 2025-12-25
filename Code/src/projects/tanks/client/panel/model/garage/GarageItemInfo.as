package projects.tanks.client.panel.model.garage
{
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.IGameObject;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.commons.types.ItemViewCategoryEnum;
   
   public class GarageItemInfo
   {
      private var newname_4901__END:ItemCategoryEnum;
      
      private var newname_4902__END:IGameObject;
      
      private var newname_4903__END:ItemViewCategoryEnum;
      
      private var newname_4904__END:int;
      
      private var newname_4905__END:Boolean;
      
      private var newname_3259__END:String;
      
      private var newname_4906__END:int;
      
      private var newname_4907__END:Boolean;
      
      private var newname_4908__END:ImageResource;
      
      private var newname_4909__END:int;
      
      public function GarageItemInfo(param1:ItemCategoryEnum = null, param2:IGameObject = null, param3:ItemViewCategoryEnum = null, param4:int = 0, param5:Boolean = false, param6:String = null, param7:int = 0, param8:Boolean = false, param9:ImageResource = null, param10:int = 0)
      {
         super();
         this.newname_4901__END = param1;
         this.newname_4902__END = param2;
         this.newname_4903__END = param3;
         this.newname_4904__END = param4;
         this.newname_4905__END = param5;
         this.newname_3259__END = param6;
         this.newname_4906__END = param7;
         this.newname_4907__END = param8;
         this.newname_4908__END = param9;
         this.newname_4909__END = param10;
      }
      
      public function get category() : ItemCategoryEnum
      {
         return this.newname_4901__END;
      }
      
      public function set category(param1:ItemCategoryEnum) : void
      {
         this.newname_4901__END = param1;
      }
      
      public function get item() : IGameObject
      {
         return this.newname_4902__END;
      }
      
      public function set item(param1:IGameObject) : void
      {
         this.newname_4902__END = param1;
      }
      
      public function get itemViewCategory() : ItemViewCategoryEnum
      {
         return this.newname_4903__END;
      }
      
      public function set itemViewCategory(param1:ItemViewCategoryEnum) : void
      {
         this.newname_4903__END = param1;
      }
      
      public function get modificationIndex() : int
      {
         return this.newname_4904__END;
      }
      
      public function set modificationIndex(param1:int) : void
      {
         this.newname_4904__END = param1;
      }
      
      public function get mounted() : Boolean
      {
         return this.newname_4905__END;
      }
      
      public function set mounted(param1:Boolean) : void
      {
         this.newname_4905__END = param1;
      }
      
      public function get name() : String
      {
         return this.newname_3259__END;
      }
      
      public function set name(param1:String) : void
      {
         this.newname_3259__END = param1;
      }
      
      public function get position() : int
      {
         return this.newname_4906__END;
      }
      
      public function set position(param1:int) : void
      {
         this.newname_4906__END = param1;
      }
      
      public function get premiumItem() : Boolean
      {
         return this.newname_4907__END;
      }
      
      public function set premiumItem(param1:Boolean) : void
      {
         this.newname_4907__END = param1;
      }
      
      public function get preview() : ImageResource
      {
         return this.newname_4908__END;
      }
      
      public function set preview(param1:ImageResource) : void
      {
         this.newname_4908__END = param1;
      }
      
      public function get remainingTimeInMS() : int
      {
         return this.newname_4909__END;
      }
      
      public function set remainingTimeInMS(param1:int) : void
      {
         this.newname_4909__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "GarageItemInfo [";
         _loc1_ += "category = " + this.newname_4901__END + " ";
         _loc1_ += "item = " + this.newname_4902__END + " ";
         _loc1_ += "itemViewCategory = " + this.newname_4903__END + " ";
         _loc1_ += "modificationIndex = " + this.newname_4904__END + " ";
         _loc1_ += "mounted = " + this.newname_4905__END + " ";
         _loc1_ += "name = " + this.newname_3259__END + " ";
         _loc1_ += "position = " + this.newname_4906__END + " ";
         _loc1_ += "premiumItem = " + this.newname_4907__END + " ";
         _loc1_ += "preview = " + this.newname_4908__END + " ";
         _loc1_ += "remaingTimeInMS = " + this.newname_4909__END + " ";
         return _loc1_ + "]";
      }
   }
}

