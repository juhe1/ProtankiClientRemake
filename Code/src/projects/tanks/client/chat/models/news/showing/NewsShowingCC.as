package projects.tanks.client.chat.models.news.showing
{
   import projects.tanks.client.panel.model.news.item.NewsItemCC;
   
   public class NewsShowingCC
   {
      private var newname_8601__END:Vector.<NewsItemCC>;
      
      public function NewsShowingCC(param1:Vector.<NewsItemCC> = null)
      {
         super();
         this.newname_8601__END = param1;
      }
      
      public function get newsItems() : Vector.<NewsItemCC>
      {
         return this.newname_8601__END;
      }
      
      public function set newsItems(param1:Vector.<NewsItemCC>) : void
      {
         this.newname_8601__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "NewsShowingCC [";
         _loc1_ += "newsItems = " + this.newname_8601__END + " ";
         return _loc1_ + "]";
      }
   }
}

