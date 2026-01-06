package alternativa.tanks.services.targeting
{
   public interface TargetingInputListener
   {
      
      function mouseAbsoluteMovement(param1:Number, param2:Number) : void;
      
      function mouseRelativeMovement(param1:Number, param2:Number) : void;
      
      function mouseWheel(param1:int) : void;
      
      function mouseRightButton(param1:Boolean, param2:Boolean) : Boolean;
      
      function mouseLeftButton(param1:Boolean, param2:Boolean) : Boolean;
      
      function keyboardButton(param1:uint, param2:Boolean) : Boolean;
      
      function mouseLocked(param1:Boolean) : void;
   }
}

