package projects.tanks.client.panel.model.news.item
{
   public class NewsItemCC
   {
      private var newname_11779__END:String;
      
      private var newname_11780__END:String;
      
      private var newname_11781__END:String;
      
      public function NewsItemCC(param1:String = null, param2:String = null, param3:String = null)
      {
         super();
         this.newname_11779__END = param1;
         this.newname_11780__END = param2;
         this.newname_11781__END = param3;
      }
      
      public function get imageUrl() : String
      {
         return this.newname_11779__END;
      }
      
      public function set imageUrl(param1:String) : void
      {
         this.newname_11779__END = param1;
      }
      
      public function get newsDate() : String
      {
         return this.newname_11780__END;
      }
      
      public function set newsDate(param1:String) : void
      {
         this.newname_11780__END = param1;
      }
      
      public function get newsText() : String
      {
         return this.newname_11781__END;
      }
      
      public function set newsText(param1:String) : void
      {
         this.newname_11781__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "NewsItemCC [";
         _loc1_ += "imageUrl = " + this.newname_11779__END + " ";
         _loc1_ += "newsDate = " + this.newname_11780__END + " ";
         _loc1_ += "newsText = " + this.newname_11781__END + " ";
         return _loc1_ + "]";
      }
   }
}

