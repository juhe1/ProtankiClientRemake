package projects.tanks.client.panel.model.bonus.showing.info
{
   import platform.client.fp10.core.resource.types.ImageResource;
   
   public class BonusInfoCC
   {
      private var newname_8855__END:String;
      
      private var newname_8856__END:ImageResource;
      
      private var newname_8857__END:String;
      
      public function BonusInfoCC(param1:String = null, param2:ImageResource = null, param3:String = null)
      {
         super();
         this.newname_8855__END = param1;
         this.newname_8856__END = param2;
         this.newname_8857__END = param3;
      }
      
      public function get bottomText() : String
      {
         return this.newname_8855__END;
      }
      
      public function set bottomText(param1:String) : void
      {
         this.newname_8855__END = param1;
      }
      
      public function get image() : ImageResource
      {
         return this.newname_8856__END;
      }
      
      public function set image(param1:ImageResource) : void
      {
         this.newname_8856__END = param1;
      }
      
      public function get topText() : String
      {
         return this.newname_8857__END;
      }
      
      public function set topText(param1:String) : void
      {
         this.newname_8857__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "BonusInfoCC [";
         _loc1_ += "bottomText = " + this.newname_8855__END + " ";
         _loc1_ += "image = " + this.newname_8856__END + " ";
         _loc1_ += "topText = " + this.newname_8857__END + " ";
         return _loc1_ + "]";
      }
   }
}

