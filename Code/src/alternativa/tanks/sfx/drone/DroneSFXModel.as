package alternativa.tanks.sfx.drone
{
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.battlefield.models.drone.DroneSFXModelBase;
   import projects.tanks.client.battlefield.models.drone.IDroneSFXModelBase;
   
   [ModelInfo]
   public class DroneSFXModel extends DroneSFXModelBase implements IDroneSFXModelBase, DroneSFX, ObjectLoadListener
   {
      
      public function DroneSFXModel()
      {
         super();
      }
      
      public function objectLoaded() : void
      {
         var _loc1_:DroneSFXData = new DroneSFXData(getInitParam());
         putData(DroneSFXData,_loc1_);
      }
      
      public function getSfxData() : DroneSFXData
      {
         return DroneSFXData(getData(DroneSFXData));
      }
   }
}

