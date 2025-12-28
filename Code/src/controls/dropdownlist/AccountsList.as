package controls.dropdownlist
{
   import controls.base.TankInputBase;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.SharedObject;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
   
   public class AccountsList extends DropDownList
   {
      
      [Inject] // added
      public static var storageService:IStorageService;
      
      public static const ROW_HEIGHT:int = 20;
      
      private var dropButton:DropDownButton = new DropDownButton();
      
      private var inputControl:TankInputBase;
      
      public function AccountsList(param1:TankInputBase)
      {
         super();
         this.inputControl = param1;
         this.inputControl.addEventListener(Event.ADDED,this.onAdded);
      }
      
      private function onAdded(param1:Event) : void
      {
         this.inputControl.removeEventListener(Event.ADDED,this.onAdded);
         this.listBg.x = this.inputControl.x;
         this.listBg.y = this.inputControl.y + 28;
         this.inputControl.parent.addChildAt(this.listBg,this.inputControl.parent.getChildIndex(this.inputControl));
      }
      
      override protected function init() : void
      {
         super.init();
         list.y = 30;
         list.height = 100;
         list.rowHeight = ROW_HEIGHT;
         this.listBg.height = 110;
         removeChild(button);
         addChild(this.dropButton);
         this.dropButton.y = -1;
         this.dropButton.addEventListener(MouseEvent.CLICK,onButtonClick);
         setRenderer(AccountsRenderer);
         addEventListener(DeleteEvent.REMOVED,this.onAccountRemove);
      }
      
      public function onAccountRemove(param1:DeleteEvent) : void
      {
         list.removeItem(param1.data);
         close();
         selectedItem = null;
         height = Math.min(this.length,4) * ROW_HEIGHT + 13;
         var _loc2_:Object = param1.data.data;
         var _loc3_:SharedObject = storageService.getAccountsStorage();
         delete _loc3_.data[_loc2_.userName];
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      override protected function get listBg() : DPLBackground
      {
         if(!_listBg)
         {
            _listBg = new AccountsBackground();
         }
         return _listBg;
      }
      
      override public function addItem(param1:Object) : void
      {
         super.addItem(param1);
         height = Math.min(this.length,4) * ROW_HEIGHT + 10;
      }
      
      override public function set width(param1:Number) : void
      {
         this.dropButton.x = param1 - 30;
         super.width = param1;
      }
      
      override protected function draw() : void
      {
         super.draw();
         list.setSize(this.listBg.width,this.listBg.height - 7);
         list.invalidate();
      }
      
      public function get length() : Number
      {
         return dp.length;
      }
      
      public function initialize() : void
      {
         var _loc3_:String = null;
         var _loc4_:SharedObject = null;
         clear();
         var _loc1_:SharedObject = storageService.getAccountsStorage();
         var _loc2_:int = 0;
         for(_loc3_ in _loc1_.data)
         {
            if(Boolean(_loc1_.data[_loc3_].userHash))
            {
               this.addItem({
                  "gameName":_loc3_,
                  "rang":0,
                  "id":_loc2_++,
                  "data":_loc1_.data[_loc3_]
               });
            }
         }
         visible = _loc2_ > 0;
         _loc4_ = storageService.getStorage();
         if(Boolean(_loc4_.data.userName))
         {
            selectItemByField("gameName",_loc4_.data.userName);
         }
         else
         {
            selectItemByField("id",0);
         }
      }
   }
}

