package juho.hacking.hackmenu {
   import controls.TankInput;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import controls.Label;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Vector3D;
   import juho.hacking.Hack;
   import juho.hacking.HackProperty;
   import controls.checkbox.TankCheckBox;
   
   public class HackMenuItem extends Sprite {
      
      private static const CONTAINER_COLOR:uint = 0x145998;
      private static const CONTAINER_BORDER_COLOR:uint = 0x00a0F0;
      private static const CONTAINER_BORDER_THICKNESS:int = 3;
      private static const PROPERTY_SPACE:int = 3;
      
      private var hack:Hack;
      private var container:Shape;
      private var checkBox:TankCheckBox;
      private var currentPropertyPos:Point;
      
      public function HackMenuItem(_hack:Hack) {
         this.hack = _hack;
         
         this.container = new Shape()
         addChild(this.container);
         
         var headerBarContainer:Sprite = new Sprite();
         headerBarContainer.x = CONTAINER_BORDER_THICKNESS + 3;
         headerBarContainer.y = CONTAINER_BORDER_THICKNESS + 6;
         addChild(headerBarContainer);
      
         var nameLabel:Label = new Label();
         nameLabel.text = this.hack.name;
         nameLabel.size = 18;
         headerBarContainer.addChild(nameLabel);
         
         var enabledLabel:Label = new Label();
         enabledLabel.text = "ENABLED  ";
         enabledLabel.size = 18;
         enabledLabel.x = nameLabel.x + nameLabel.width + 30;
         headerBarContainer.addChild(enabledLabel);
         
         this.checkBox = new TankCheckBox();
         this.checkBox.x = enabledLabel.x + enabledLabel.width + 5;
         this.checkBox.y = enabledLabel.y - 2;
         this.checkBox.checked = this.hack.isEnabled;
         this.checkBox.addEventListener(MouseEvent.MOUSE_UP, this.enableStateChanged);
         headerBarContainer.addChild(this.checkBox);
         
         currentPropertyPos = new Point(headerBarContainer.x, headerBarContainer.height + headerBarContainer.y + PROPERTY_SPACE)
         
         this.createProperties();
      }
      
      private function enableStateChanged(e:MouseEvent) : void {
         if (this.checkBox.checked) {
            this.hack.enable();
         } else {
            this.hack.disable();
         }
      }
      
      private function createProperties() : void {
         for each (var property:HackProperty in this.hack.allHackProperties) {
            switch (property.type) {
               case "Number":
                  this.createNumberProperty(property);
                  break;
               case "Vector3D":
                  this.createVector3DProperty(property);
                  break;
               default:
                  break;
            }
         }
      }
      
      private function createNumberProperty(property:HackProperty) : void {
         var propertyContainer:Sprite = new Sprite();
         propertyContainer.x = this.currentPropertyPos.x + 8;
         propertyContainer.y = this.currentPropertyPos.y;
         addChild(propertyContainer);
         
         var propertyName:Label = new Label();
         propertyName.text = property.name;
         propertyName.size = 18;
         propertyContainer.addChild(propertyName);
         
         var input:TankInput = new TankInput();
         input.width = 200;
         input.x = propertyName.width + 13;
         input.textField.restrict = "-0-9.";
         input.textField.text = Number(property.value).toString();
         propertyContainer.addChild(input);
         
         currentPropertyPos = new Point(currentPropertyPos.x, propertyContainer.height + propertyContainer.y + PROPERTY_SPACE)
         
         var self:Object = this;
         input.textField.addEventListener(Event.CHANGE, function(event:Event):void {
            self.hack.setPropertyValue(property.name, parseFloat(input.textField.text));
         });
      }
      
      private function createVector3DProperty(property:HackProperty) : void {
         var propertyContainer:Sprite = new Sprite();
         propertyContainer.x = this.currentPropertyPos.x + 8;
         propertyContainer.y = this.currentPropertyPos.y;
         addChild(propertyContainer);
         
         var propertyName:Label = new Label();
         propertyName.text = property.name;
         propertyName.size = 18;
         propertyContainer.addChild(propertyName);
         
         var xLabel:Label = new Label();
         xLabel.x = propertyName.width + 13;
         xLabel.text = "X";
         xLabel.size = 18;
         propertyContainer.addChild(xLabel);
         
         var xInput:TankInput = new TankInput();
         xInput.width = 80;
         xInput.x = xLabel.x + xLabel.width + 4;
         xInput.textField.restrict = "-0-9.";
         xInput.textField.text = Vector3D(property.value).x.toString();
         propertyContainer.addChild(xInput);
         
         var yLabel:Label = new Label();
         yLabel.x = xInput.x + xInput.width + 13;
         yLabel.text = "Y";
         yLabel.size = 18;
         propertyContainer.addChild(yLabel);
         
         var yInput:TankInput = new TankInput();
         yInput.width = 80;
         yInput.x = yLabel.x + yLabel.width + 4;
         yInput.textField.restrict = "-0-9.";
         yInput.textField.text = Vector3D(property.value).y.toString();
         propertyContainer.addChild(yInput);
         
         var zLabel:Label = new Label();
         zLabel.x = yInput.x + yInput.width + 13;
         zLabel.text = "Z";
         zLabel.size = 18;
         propertyContainer.addChild(zLabel);
         
         var zInput:TankInput = new TankInput();
         zInput.width = 80;
         zInput.x = zLabel.x + zLabel.width + 4;
         zInput.textField.restrict = "-0-9.";
         zInput.textField.text = Vector3D(property.value).z.toString();
         propertyContainer.addChild(zInput);
         
         currentPropertyPos = new Point(currentPropertyPos.x, propertyContainer.height + propertyContainer.y + PROPERTY_SPACE)
         
         var self:Object = this;
         xInput.textField.addEventListener(Event.CHANGE, function(event:Event):void {
            Vector3D(property.value).x = parseFloat(xInput.textField.text);
            self.hack.setPropertyValue(property.name, property.value);
         });
         
         yInput.textField.addEventListener(Event.CHANGE, function(event:Event):void {
            Vector3D(property.value).y = parseFloat(yInput.textField.text);
            self.hack.setPropertyValue(property.name, property.value);
         });
         
         zInput.textField.addEventListener(Event.CHANGE, function(event:Event):void {
            Vector3D(property.value).z = parseFloat(zInput.textField.text);
            self.hack.setPropertyValue(property.name, property.value);
         });
      }
      
      public function sizeContainer(_width:int, _height:int) : void {
         this.container.graphics.clear();
         this.container.graphics.beginFill(CONTAINER_BORDER_COLOR);
         this.container.graphics.drawRoundRect(0, 0, _width, _height, 5, 5);
         this.container.graphics.endFill();
         this.container.graphics.beginFill(CONTAINER_COLOR);
         this.container.graphics.drawRoundRect(CONTAINER_BORDER_THICKNESS, CONTAINER_BORDER_THICKNESS, _width - CONTAINER_BORDER_THICKNESS * 2, _height - CONTAINER_BORDER_THICKNESS * 2, 5, 5);
         this.container.graphics.endFill();
      }
   }
}