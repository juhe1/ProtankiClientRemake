package projects.tanks.clients.fp10.libraries.tanksservices.service.helper
{
   import alternativa.osgi.OSGi;
   import alternativa.osgi.service.display.IDisplay;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
   import projects.tanks.clients.fp10.libraries.tanksservices.utils.KeyUpListenerPriority;
   
   public class HelpService implements IHelpService
   {
      
      private var storage:SharedObject;
      
      private var stage:Stage;
      
      private var helpLayer:DisplayObjectContainer;
      
      private var helpContainer:Sprite;
      
      private var helpGroups:Dictionary;
      
      private var mainGroupObjects:Array;
      
      private var advancedUser:Boolean;
      
      private var timers:Array;
      
      private var listenerAdded:Boolean;
      
      private var currentlyVisibleHelpers:Dictionary;
      
      private var storedState:Dictionary = new Dictionary();
      
      private var addedDuringLock:Vector.<ShowedHelperInfo> = new Vector.<ShowedHelperInfo>();
      
      private var hidedHelpers:Vector.<Object>;
      
      private var locked:Boolean;
      
      private const showPeriod:int = 86400000;
      
      private const showCount:int = 5;
      
      public function HelpService()
      {
         super();
         var _loc1_:OSGi = OSGi.getInstance();
         var _loc2_:IDisplay = IDisplay(_loc1_.getService(IDisplay));
         this.stage = _loc2_.stage;
         this.helpLayer = _loc2_.noticesLayer;
         this.helpContainer = new Sprite();
         this.helpGroups = new Dictionary();
         this.mainGroupObjects = new Array();
         this.timers = new Array();
         this.storage = IStorageService(_loc1_.getService(IStorageService)).getStorage();
         if(!this.storage.data.helperShowNum)
         {
            this.storage.data.helperShowNum = new Vector.<Object>();
         }
         if(this.storage.data.hidedHelpers as Vector.<Object> == null)
         {
            this.storage.data.hidedHelpers = new Vector.<Object>();
         }
         this.hidedHelpers = this.storage.data.hidedHelpers as Vector.<Object>;
         this.advancedUser = int(this.storage.data.userRank) >= 6;
         this.currentlyVisibleHelpers = new Dictionary();
         this.stage.addEventListener(Event.RESIZE,this.onStageResize);
      }
      
      public function registerHelper(param1:String, param2:int, param3:Helper, param4:Boolean) : void
      {
         var _loc9_:Object = null;
         var _loc5_:Dictionary = this.helpGroups[param1];
         if(_loc5_ == null)
         {
            _loc5_ = new Dictionary();
            this.helpGroups[param1] = _loc5_;
         }
         _loc5_[param2] = param3;
         if(param4)
         {
            this.mainGroupObjects.push(param3);
         }
         var _loc6_:Vector.<Object> = this.storage.data.helperShowNum != null && this.storage.data.helperShowNum is Vector.<Object> ? this.storage.data.helperShowNum as Vector.<Object> : new Vector.<Object>();
         var _loc7_:int = -1;
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.length)
         {
            if(Boolean(_loc6_[_loc8_].hasOwnProperty("groupKey")) && _loc6_[_loc8_].groupKey == param1)
            {
               _loc7_ = _loc8_;
            }
            _loc8_++;
         }
         if(_loc7_ == -1)
         {
            _loc9_ = new Object();
            _loc9_.groupKey = param1;
            _loc9_.helper = new Array();
            _loc6_.push(_loc9_);
            _loc7_ = _loc6_.length - 1;
         }
         if(_loc6_[_loc7_].helper == null)
         {
            _loc6_[_loc7_].helper = new Array();
         }
         if(_loc6_[_loc7_].helper[param2] == null)
         {
            _loc6_[_loc7_].helper[param2] = param3.showNum;
         }
         else
         {
            param3.showNum = _loc6_[_loc7_].helper[param2];
         }
         this.storage.data.helperShowNum = _loc6_;
         param3.id = param2;
         param3.groupKey = param1;
      }
      
      public function unregisterHelper(param1:String, param2:int) : void
      {
         var _loc3_:Dictionary = this.helpGroups[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:Helper = _loc3_[param2];
         if(_loc4_ == null)
         {
            return;
         }
         this.doHideHelper(_loc4_);
         delete _loc3_[param2];
         var _loc5_:int = int(this.mainGroupObjects.indexOf(_loc4_));
         if(_loc5_ >= 0)
         {
            this.mainGroupObjects.splice(_loc5_,1);
         }
      }
      
      public function showHelperIfAble(param1:String, param2:int, param3:Boolean = false) : void
      {
         if(this.locked)
         {
            this.addedDuringLock.push(new ShowedHelperInfo(param1,param2,param3));
         }
         else
         {
            this.showHelper(param1,param2,param3);
         }
      }
      
      public function showHelper(param1:String, param2:int, param3:Boolean = false) : void
      {
         var _loc5_:Vector.<Object> = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:HelperTimer = null;
         if(this.advancedUser || this.helperHiddenManually(param1,param2))
         {
            return;
         }
         var _loc4_:Helper = this.getHelper(param1,param2);
         if(_loc4_ == null)
         {
            return;
         }
         if(!this.helpLayer.contains(this.helpContainer))
         {
            this.helpLayer.addChild(this.helpContainer);
         }
         if(param3 || _loc4_.showLimit == -1 || _loc4_.showNum < _loc4_.showLimit)
         {
            if(!this.helpContainer.contains(_loc4_))
            {
               ++_loc4_.showNum;
               this.currentlyVisibleHelpers[_loc4_] = new ShowedHelperInfo(param1,param2,param3);
               _loc5_ = this.storage.data.helperShowNum != null && this.storage.data.helperShowNum is Vector.<Object> ? this.storage.data.helperShowNum as Vector.<Object> : new Vector.<Object>();
               _loc6_ = -1;
               _loc7_ = 0;
               while(_loc7_ < _loc5_.length)
               {
                  if(Boolean(_loc5_[_loc7_].hasOwnProperty("groupKey")) && _loc5_[_loc7_].groupKey == param1)
                  {
                     _loc6_ = _loc7_;
                  }
                  _loc7_++;
               }
               if(_loc6_ == -1)
               {
                  _loc8_ = new Object();
                  _loc8_.groupKey = param1;
                  _loc8_.helper = new Array();
                  _loc8_.helper[param2] = _loc4_.showNum;
                  _loc5_.push(_loc8_);
               }
               else
               {
                  _loc5_[_loc6_].helper[param2] = _loc4_.showNum;
               }
               this.storage.data.helperShowNum = _loc5_;
               this.helpContainer.addChild(_loc4_);
               _loc4_.draw(_loc4_.size);
               _loc4_.align(this.stage.stageWidth,this.stage.stageHeight);
               _loc4_.addEventListener(MouseEvent.MOUSE_DOWN,this.onHelperClick);
               if(!param3)
               {
                  _loc9_ = new HelperTimer(_loc4_.showDuration,1);
                  _loc9_.helper = _loc4_;
                  _loc4_.timer = _loc9_;
                  _loc9_.addEventListener(TimerEvent.TIMER_COMPLETE,this.onHelperTimer);
                  this.timers.push(_loc9_);
                  _loc9_.start();
               }
            }
         }
      }
      
      private function helperHiddenManually(param1:String, param2:int) : Boolean
      {
         var _loc4_:Object = null;
         var _loc3_:Date = new Date();
         for each(_loc4_ in this.hidedHelpers)
         {
            if(_loc4_.groupKey == param1 && _loc4_.helperId == param2)
            {
               return _loc3_.time - _loc4_.date.time < this.showPeriod || _loc4_.count >= this.showCount;
            }
         }
         return false;
      }
      
      public function hideAllHelpers() : void
      {
         var _loc1_:Helper = null;
         if(this.helpContainer != null)
         {
            while(this.helpContainer.numChildren != 0)
            {
               _loc1_ = this.helpContainer.getChildAt(0) as Helper;
               this.hideHelper(_loc1_.groupKey,_loc1_.id);
            }
            if(this.helpContainer.numChildren == 0 && this.helpLayer.contains(this.helpContainer))
            {
               this.helpLayer.removeChild(this.helpContainer);
            }
         }
      }
      
      public function hideHelper(param1:String, param2:int) : void
      {
         if(this.currentlyVisibleHelpers[this.getHelper(param1,param2)] != null)
         {
            delete this.currentlyVisibleHelpers[this.getHelper(param1,param2)];
         }
         this.doHideHelper(this.getHelper(param1,param2));
         this.checkContainerEmptiness();
      }
      
      private function checkContainerEmptiness() : void
      {
         if(this.helpContainer.numChildren == 0 && this.helpLayer.contains(this.helpContainer))
         {
            this.helpLayer.removeChild(this.helpContainer);
         }
      }
      
      public function showHelp() : void
      {
         var _loc2_:Helper = null;
         var _loc3_:int = 0;
         if(!this.helpLayer.contains(this.helpContainer))
         {
            this.helpLayer.addChild(this.helpContainer);
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.mainGroupObjects.length)
         {
            _loc2_ = this.mainGroupObjects[_loc1_] as Helper;
            if(!this.helpContainer.contains(_loc2_))
            {
               this.helpContainer.addChild(_loc2_);
               _loc2_.draw(_loc2_.size);
               _loc2_.align(this.stage.stageWidth,this.stage.stageHeight);
            }
            else
            {
               _loc3_ = int(this.timers.indexOf(_loc2_.timer));
               if(_loc3_ != -1)
               {
                  HelperTimer(this.timers[_loc3_]).stop();
                  this.timers.splice(_loc3_,1);
               }
            }
            this.currentlyVisibleHelpers[_loc2_] = new ShowedHelperInfo(_loc2_.groupKey,_loc2_.id,true);
            _loc1_++;
         }
         if(!this.listenerAdded)
         {
            this.listenerAdded = true;
            this.stage.addEventListener(MouseEvent.CLICK,this.onStageMouseClick,true);
            this.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,KeyUpListenerPriority.HELP);
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(AlertUtils.isCancelKey(param1.keyCode))
         {
            param1.stopImmediatePropagation();
            this.hideHelp();
         }
      }
      
      public function hideHelp() : void
      {
         var _loc2_:Helper = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.mainGroupObjects.length)
         {
            _loc2_ = this.mainGroupObjects[_loc1_];
            _loc3_ = int(this.timers.indexOf(_loc2_.timer));
            if(_loc3_ != -1)
            {
               (this.timers[_loc3_] as HelperTimer).stop();
               this.timers.splice(_loc3_,1);
            }
            if(this.helpContainer.contains(_loc2_))
            {
               this.helpContainer.removeChild(_loc2_);
            }
            if(this.currentlyVisibleHelpers[_loc2_] != null)
            {
               delete this.currentlyVisibleHelpers[_loc2_];
            }
            _loc1_++;
         }
         this.checkContainerEmptiness();
         if(this.listenerAdded)
         {
            this.listenerAdded = false;
            this.stage.removeEventListener(MouseEvent.CLICK,this.onStageMouseClick,true);
            this.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         }
      }
      
      public function pushState() : void
      {
         var _loc1_:Object = null;
         this.storedState = new Dictionary();
         for(_loc1_ in this.currentlyVisibleHelpers)
         {
            this.storedState[_loc1_] = this.currentlyVisibleHelpers[_loc1_];
         }
      }
      
      public function popState() : void
      {
         var _loc1_:Object = null;
         for(_loc1_ in this.storedState)
         {
            this.showHelper(this.storedState[_loc1_].groupKey,this.storedState[_loc1_].helperId,this.storedState[_loc1_].force);
         }
         this.storedState = new Dictionary();
      }
      
      private function onStageMouseClick(param1:MouseEvent) : void
      {
         this.hideHelp();
         param1.stopPropagation();
      }
      
      private function onHelperTimer(param1:TimerEvent) : void
      {
         var _loc2_:HelperTimer = param1.target as HelperTimer;
         var _loc3_:Helper = _loc2_.helper;
         this.hideHelper(_loc3_.groupKey,_loc3_.id);
      }
      
      private function onHelperClick(param1:MouseEvent) : void
      {
         var _loc2_:Helper = null;
         if(param1.target is Helper)
         {
            _loc2_ = param1.target as Helper;
            this.hideHelper(_loc2_.groupKey,_loc2_.id);
            this.addHidedHelper(_loc2_);
            param1.stopPropagation();
         }
      }
      
      private function addHidedHelper(param1:Helper) : void
      {
         var _loc4_:Object = null;
         var _loc2_:Date = new Date();
         var _loc3_:Boolean = false;
         for each(_loc4_ in this.hidedHelpers)
         {
            if(_loc4_.groupKey == param1.groupKey && _loc4_.helperId == param1.id)
            {
               _loc4_.date = _loc2_;
               ++_loc4_.count;
               _loc3_ = true;
            }
         }
         if(!_loc3_)
         {
            this.hidedHelpers.push(new HidedHelperInfo(param1.groupKey,param1.id,_loc2_,0));
         }
      }
      
      private function onStageResize(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Helper = null;
         if(this.helpLayer.contains(this.helpContainer))
         {
            _loc2_ = 0;
            while(_loc2_ < this.helpContainer.numChildren)
            {
               _loc3_ = this.helpContainer.getChildAt(_loc2_) as Helper;
               if(_loc3_ != null)
               {
                  _loc3_.align(this.stage.stageWidth,this.stage.stageHeight);
               }
               _loc2_++;
            }
         }
      }
      
      private function getHelper(param1:String, param2:int) : Helper
      {
         var _loc3_:Dictionary = this.helpGroups[param1];
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_[param2];
      }
      
      private function doHideHelper(param1:Helper) : void
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(this.helpContainer.contains(param1))
         {
            this.helpContainer.removeChild(param1);
         }
         param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onHelperClick);
         var _loc2_:HelperTimer = param1.timer;
         if(_loc2_ != null)
         {
            _loc2_.stop();
            _loc3_ = int(this.timers.indexOf(_loc2_));
            if(_loc3_ != -1)
            {
               this.timers.splice(_loc3_,1);
            }
         }
      }
      
      public function lock() : void
      {
         this.locked = true;
      }
      
      public function unlock() : void
      {
         var _loc1_:ShowedHelperInfo = null;
         this.locked = false;
         for each(_loc1_ in this.addedDuringLock)
         {
            this.showHelper(_loc1_.groupKey,_loc1_.helperId,_loc1_.force);
         }
         this.addedDuringLock = new Vector.<ShowedHelperInfo>();
      }
      
      public function manuallyShutDownHelper(param1:Helper) : void
      {
         this.hideHelper(param1.groupKey,param1.id);
         this.addHidedHelper(param1);
      }
   }
}

class ShowedHelperInfo
{
   
   public var groupKey:String;
   
   public var helperId:int;
   
   public var force:Boolean = false;
   
   public function ShowedHelperInfo(param1:String, param2:int, param3:Boolean)
   {
      super();
      this.groupKey = param1;
      this.helperId = param2;
      this.force = param3;
   }
}

class HidedHelperInfo
{
   
   public var groupKey:String;
   
   public var helperId:int;
   
   public var date:Date;
   
   public var count:int;
   
   public function HidedHelperInfo(param1:String, param2:int, param3:Date, param4:int)
   {
      super();
      this.groupKey = param1;
      this.helperId = param2;
      this.date = param3;
      this.count = param4;
   }
   
   public function toString() : String
   {
      return this.date.toString() + ", " + this.count.toString();
   }
}
