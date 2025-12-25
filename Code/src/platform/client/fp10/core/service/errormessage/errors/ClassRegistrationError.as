package platform.client.fp10.core.service.errormessage.errors
{
   import platform.client.fp10.core.dispatcher.ClassDispatcherItem;
   
   public class ClassRegistrationError implements ErrorType
   {
      
      private var classItem:ClassDispatcherItem;
      
      private var e:Error;
      
      public function ClassRegistrationError(param1:ClassDispatcherItem, param2:Error)
      {
         super();
         this.classItem = param1;
         this.e = param2;
      }
      
      public function getMessage() : String
      {
         return "Class registration error in class " + this.classItem + ": " + this.e.getStackTrace();
      }
   }
}

