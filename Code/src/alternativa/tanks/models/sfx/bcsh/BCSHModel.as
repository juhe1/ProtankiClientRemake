package alternativa.tanks.models.sfx.bcsh
{
   import alternativa.osgi.service.logging.LogService;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import projects.tanks.client.battlefield.models.tankparts.sfx.bcsh.BCSHModelBase;
   import projects.tanks.client.battlefield.models.tankparts.sfx.bcsh.BCSHStruct;
   import projects.tanks.client.battlefield.models.tankparts.sfx.bcsh.IBCSHModelBase;
   
   [ModelInfo]
   public class BCSHModel extends BCSHModelBase implements IBCSHModelBase, ObjectLoadListener, IBcsh
   {
      
      [Inject]
      public static var logService:LogService;
      
      public function BCSHModel()
      {
         super();
      }
      
      [Obfuscation(rename="false")]
      public function objectLoaded() : void
      {
         var _loc3_:BCSHStruct = null;
         var _loc1_:Object = {};
         var _loc2_:Vector.<BCSHStruct> = getInitParam().data;
         for each(_loc3_ in _loc2_)
         {
            _loc1_[_loc3_.key] = new BCSHData(_loc3_);
         }
         putData(Object,_loc1_);
      }
      
      public function createFilter(param1:String) : BitmapFilter
      {
         var _loc2_:Object = Object(getData(Object));
         var _loc3_:BCSHData = _loc2_[param1];
         if(_loc3_ != null)
         {
            return _loc3_.createFilter();
         }
         return new ColorMatrixFilter();
      }
   }
}

