package alternativa.tanks.models.weapon.shared.shot
{
   import projects.tanks.client.battlefield.models.tankparts.weapon.shot.DiscreteShotModelBase;
   import projects.tanks.client.battlefield.models.tankparts.weapon.shot.IDiscreteShotModelBase;
   
   [ModelInfo]
   public class DiscreteShotModel extends DiscreteShotModelBase implements IDiscreteShotModelBase, IShotModel
   {
      
      public function DiscreteShotModel()
      {
         super();
      }
      
      public function getReloadMS() : int
      {
         return getInitParam().reloadMsec;
      }
   }
}

