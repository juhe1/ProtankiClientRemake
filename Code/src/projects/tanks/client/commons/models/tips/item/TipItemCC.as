package projects.tanks.client.commons.models.tips.item
{
   import platform.client.fp10.core.resource.types.LocalizedImageResource;
   
   public class TipItemCC
   {
      private var newname_4908__END:LocalizedImageResource;
      
      public function TipItemCC(param1:LocalizedImageResource = null)
      {
         super();
         this.newname_4908__END = param1;
      }
      
      public function get preview() : LocalizedImageResource
      {
         return this.newname_4908__END;
      }
      
      public function set preview(param1:LocalizedImageResource) : void
      {
         this.newname_4908__END = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "TipItemCC [";
         _loc1_ += "preview = " + this.newname_4908__END + " ";
         return _loc1_ + "]";
      }
   }
}

