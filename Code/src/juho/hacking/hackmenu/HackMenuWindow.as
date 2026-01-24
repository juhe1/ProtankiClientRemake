package juho.hacking.hackmenu {
   import flash.display.Sprite;
   import forms.TankWindowWithHeader;
   import flash.geom.Point;
   import controls.TankWindowInner;
   import juho.hacking.Hack;
   import juho.hacking.HackRegistry;
   import juho.hacking.HackProperty;
   import flash.events.Event;
   import alternativa.tanks.gui.friends.FriendWindowButton;
   import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
   
   public class HackMenuWindow extends DialogWindow {
      
      private static const WINDOW_NAME:String = "HACK MENU";
      private static const WINDOW_MARGIN:int = 12;
      private static const WINDOW_WIDTH:int = 700 + WINDOW_MARGIN * 2 + 4;
      private static const WINDOW_HEIGHT:int = 800;
      private static const HACK_LIST_MARGIN:int = 10;
      private static const DEFAULT_BUTTON_WIDTH:int = 100;
      
      private var _window:TankWindowWithHeader;
      private var _windowSize:Point;
      private var _windowInner:TankWindowInner;
      private var hackMenuList:HackMenuList;
      private var hackMenuItems:Vector.<HackMenuItem> = new Vector.<HackMenuItem>();
      
      public var _closeButton:FriendWindowButton;
      
      public function HackMenuWindow() {
         this._windowSize = new Point(WINDOW_WIDTH, WINDOW_HEIGHT);
         
         this._window = TankWindowWithHeader.createWindow(WINDOW_NAME);
         addChild(this._window);
         
         this._windowInner = new TankWindowInner(0, 0, TankWindowInner.GREEN);
         this._windowInner.showBlink = true;
         addChild(this._windowInner);
         
         this.hackMenuList = new HackMenuList();
         addChild(this.hackMenuList);
         
         this._closeButton = new FriendWindowButton();
         this._closeButton.label = "Close";
         addChild(this._closeButton);
         
         this.resize();
         addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
      }
      
      private function addedToStage(event:Event) : void {
         this.loadHacks();
      }
      
      private function loadHacks():void {
         for each (var hack:Hack in HackRegistry.allHacks) {
            this.addHackToMenu(hack);
         }
      }
      
      private function addHackToMenu(hack:Hack):void {
         var item:HackMenuItem = new HackMenuItem(hack);
         this.hackMenuItems.push(item);
         this.hackMenuList.addItem(item);
         
         item.sizeContainer(this.hackMenuList.width - 23, item.height + 17);
      }
      
      private function resize():void {
         this._window.width = this._windowSize.x;
         this._window.height = this._windowSize.y;
         
         this._closeButton.width = DEFAULT_BUTTON_WIDTH;
         this._closeButton.x = this._windowSize.x - this._closeButton.width - WINDOW_MARGIN;
         this._closeButton.y = this._windowSize.y - this._closeButton.height - WINDOW_MARGIN;
         
         this._windowInner.x = WINDOW_MARGIN;
         this._windowInner.y = WINDOW_MARGIN;
         this._windowInner.width = this._windowSize.x - WINDOW_MARGIN * 2;
         this._windowInner.height = this._windowSize.y - this._windowInner.y - this._closeButton.height - 18;
         
         this.hackMenuList.x = this._windowInner.x + HACK_LIST_MARGIN;
         this.hackMenuList.y = this._windowInner.y + 4;
         this.hackMenuList.width = this._windowInner.width - HACK_LIST_MARGIN + 4;
         this.hackMenuList.height = this._windowInner.height - 4 * 2;
         this.hackMenuList.update();
      }
   
   }
}