package alternativa.tanks.utils
{
   import alternativa.tanks.utils.thirdparty.URI;
   
   public class LinksInterceptor
   {
      
      private var _linkRegexp:RegExp = /(https?:\/\/|www\.)((([\w-\.]+)\.([a-z]{2,6}\.?))|(([а-я-\.]+)\.(рф\.?)))(\/[\w\.]*)*\/?([^\s\n]+)?/gi;
      
      private var _linkRegexpExtra:RegExp;
      
      private var _linkRegexpAddon:RegExp = /[\[\]\{\}\|\*\(\)\@\$\^\'`~+№!]/gi;
      
      private var _allowedDomains:Vector.<String>;
      
      public var htmlFlag:Boolean = false;
      
      public function LinksInterceptor(param1:Vector.<String>)
      {
         super();
         this._allowedDomains = param1;
      }
      
      public function checkLinks(param1:String) : String
      {
         this._linkRegexpExtra = new RegExp(this._linkRegexp);
         var _loc5_:String = null;
         var _loc6_:URI = null;
         this._linkRegexp.lastIndex = 0;
         var _loc2_:String = "";
         var _loc3_:Array = this._linkRegexp.exec(param1);
         var _loc4_:int = 0;
         this.htmlFlag = false;
         while(_loc3_ != null)
         {
            _loc2_ += param1.substr(_loc4_,_loc3_.index - _loc4_);
            _loc5_ = param1.substr(_loc3_.index,this._linkRegexp.lastIndex - _loc3_.index);
            _loc6_ = this.createUri(_loc5_);
            if(!this.existsUrlInQuery(_loc6_) && _loc5_.indexOf("*") == -1)
            {
               _loc2_ += " <u><a href=\'event:" + _loc6_ + "\'>" + _loc5_ + "</a></u> ";
               this.htmlFlag = true;
            }
            else
            {
               _loc2_ += _loc5_;
            }
            _loc4_ = this._linkRegexp.lastIndex;
            _loc3_ = this._linkRegexp.exec(param1);
         }
         return _loc2_ + param1.substr(this._linkRegexp.lastIndex == 0 ? _loc4_ : this._linkRegexp.lastIndex);
      }
      
      public function isInWhiteList(param1:String) : Boolean
      {
         var _loc2_:URI = this.createUri(param1);
         var _loc3_:String = _loc2_.authority;
         return this._allowedDomains.indexOf(_loc3_) != -1 && !this.existsUrlInQuery(_loc2_);
      }
      
      private function createUri(param1:String) : URI
      {
         return new URI(param1.search(/^https?:\/\//i) == -1 ? "http://" + param1 : param1);
      }
      
      private function existsUrlInQuery(param1:URI) : Boolean
      {
         this._linkRegexpExtra.lastIndex = 0;
         if(this._linkRegexpExtra.exec(param1.queryRaw) != null)
         {
            return true;
         }
         this._linkRegexpAddon.lastIndex = 0;
         if(this._linkRegexpAddon.exec(param1.path) != null)
         {
            return true;
         }
         this._linkRegexpAddon.lastIndex = 0;
         if(this._linkRegexpAddon.exec(param1.fragment) != null)
         {
            return true;
         }
         return false;
      }
   }
}

