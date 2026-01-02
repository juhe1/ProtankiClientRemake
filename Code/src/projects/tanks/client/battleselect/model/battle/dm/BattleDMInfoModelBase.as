package projects.tanks.client.battleselect.model.battle.dm
{
   import alternativa.types.Long;
   import platform.client.fp10.core.model.IModel;
   import platform.client.fp10.core.model.impl.Model;
   
   public class BattleDMInfoModelBase extends Model
   {
      protected var server:BattleDMInfoModelServer;
      
      public static var modelId:Long = Long.getLong(231608534,1754662850);
      
      public function BattleDMInfoModelBase()
      {
         super();
         this.server = new BattleDMInfoModelServer(IModel(this));
      }
      
      protected function getInitParam() : BattleDMInfoCC
      {
         return BattleDMInfoCC(initParams[Model.object]);
      }
      
      override public function get id() : Long
      {
         return BattleDMInfoModelBase.modelId;
      }
   }
}

