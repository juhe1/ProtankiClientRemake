package projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser
{
   import flash.net.SharedObject;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.UidUtil;
   
   public class BlockUserService implements IBlockUserService
   {
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      private static var so:SharedObject;
      
      public function BlockUserService()
      {
         super();
      }
      
      public function getBlockList() : Array
      {
         var _loc1_:Array = null;
         so = storageService.getStorage();
         _loc1_ = so.data.blocklist;
         if(_loc1_ == null)
         {
            _loc1_ = new Array();
         }
         return _loc1_;
      }
      
      public function blockUser(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:String = UidUtil.userNameWithoutClanTag(param1);
         so = storageService.getStorage();
         _loc2_ = so.data.blocklist;
         if(_loc2_ == null)
         {
            _loc2_ = new Array();
         }
         var _loc4_:int = int(_loc2_.indexOf(_loc3_));
         if(_loc4_ > -1)
         {
            _loc2_.splice(_loc4_,1);
         }
         _loc2_.push(_loc3_);
         so.data.blocklist = _loc2_;
      }
      
      public function unblockUser(param1:String) : void
      {
         var _loc2_:Array = null;
         so = storageService.getStorage();
         _loc2_ = so.data.blocklist;
         if(_loc2_ == null)
         {
            _loc2_ = new Array();
         }
         var _loc3_:int = int(_loc2_.indexOf(UidUtil.userNameWithoutClanTag(param1)));
         if(_loc3_ > -1)
         {
            _loc2_.splice(_loc3_,1);
         }
         so.data.blocklist = _loc2_;
      }
      
      public function unblockAll() : void
      {
         so = storageService.getStorage();
         so.data.blocklist = new Array();
      }
      
      public function isBlocked(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         so = storageService.getStorage();
         _loc2_ = so.data.blocklist;
         if(_loc2_ == null)
         {
            _loc2_ = new Array();
            so.data.blocklist = _loc2_;
         }
         _loc3_ = int(_loc2_.indexOf(UidUtil.userNameWithoutClanTag(param1)));
         return _loc3_ > -1;
      }
   }
}

