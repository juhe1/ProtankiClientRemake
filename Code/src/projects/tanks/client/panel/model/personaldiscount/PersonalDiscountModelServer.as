package projects.tanks.client.panel.model.personaldiscount
{
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.type.IGameObject;

   public class PersonalDiscountModelServer
   {

      private var model:IModel;

      public function PersonalDiscountModelServer(param1:IModel)
      {
         super();
         this.model = param1;
      }

      public function select(param1:IGameObject) : void
      {
      }
   }
}
