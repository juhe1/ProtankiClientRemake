package platform.client.core.general.resourcelocale.format
{
   public class LocalizedFileFormat
   {   
      private var _images:Vector.<ImagePair>;
      
      private var _strings:Vector.<StringPair>;
      
      public function LocalizedFileFormat(param1:Vector.<ImagePair> = null, param2:Vector.<StringPair> = null)
      {
         super();
         this._images = param1;
         this._strings = param2;
      }
      
      public function get images() : Vector.<ImagePair>
      {
         return this._images;
      }
      
      public function set images(param1:Vector.<ImagePair>) : void
      {
         this._images = param1;
      }
      
      public function get strings() : Vector.<StringPair>
      {
         return this._strings;
      }
      
      public function set strings(param1:Vector.<StringPair>) : void
      {
         this._strings = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "LocalizedFileFormat [";
         _loc1_ += "images = " + this.images + " ";
         _loc1_ += "strings = " + this.strings + " ";
         return _loc1_ + "]";
      }
   }
}

