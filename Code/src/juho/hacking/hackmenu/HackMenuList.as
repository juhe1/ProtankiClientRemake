package juho.hacking.hackmenu
{
    import flash.display.Sprite;
    import fl.containers.ScrollPane;
    import fl.controls.ScrollPolicy;
    import utils.ScrollStyleUtils;

    public class HackMenuList extends ScrollPane {

        private var _cont:Sprite;
        private var some:Sprite;
        private var previousItem:HackMenuItem;

        public function HackMenuList() {
            super();
            this.some = new Sprite();
            this._cont = new Sprite();
            this._cont.addChild(some);

            ScrollStyleUtils.setGreenStyle(this);
            this.horizontalScrollPolicy = ScrollPolicy.OFF;
            this.verticalScrollPolicy = ScrollPolicy.AUTO;
            this.source = this._cont;
            this.update();
            this.focusEnabled = false;
        }

        public function addItem(item:HackMenuItem) : void {
            if (previousItem != null) {
                item.y = previousItem.y + previousItem.height + 10;
            } else {
               item.y = 10
            }

            this.previousItem = item;
            this._cont.addChild(item);
            this.update();
        }

        public function deleteItem(item:HackMenuItem) : void {
            this._cont.removeChild(item);
            this.update();
        }
    }
}