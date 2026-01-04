package scpacker.weapon
{
   import projects.tanks.client.battlefield.models.tankparts.sfx.firebird.FlameThrowingSFXCC;
   import alternativa.tanks.models.weapon.flamethrower.FlameThrowingSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx.MachineGunSFXCC;
   import alternativa.tanks.models.weapon.healing.IsisSFXModel;
   import alternativa.tanks.models.weapon.railgun.RailgunShootSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.freeze.FreezeSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.smoky.SmokyShootSFXCC;
   import alternativa.tanks.models.weapon.freeze.FreezeSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet.RicochetSFXCC;
   import alternativa.types.Long;
   import projects.tanks.client.battlefield.models.tankparts.sfx.isis.IsisSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.LightingEfect;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.LightingSFXModelCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.LightingEfectRecord;
   import alternativa.tanks.models.weapon.twins.TwinsShootSFXModel;
   import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.ThunderShootSFXCC;
   import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx.ShotgunSFXCC;
   import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunSFXModel;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.models.weapon.thunder.ThunderShootSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.bcsh.BCSHStruct;
   import projects.tanks.client.battlefield.models.tankparts.sfx.bcsh.BCSHModelCC;
   import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.sfx.ArtillerySfxCC;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun.RailgunShootSFXCC;
   import flash.utils.Dictionary;
   import alternativa.object.ClientObject;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft.ShaftShootSFXCC;
   import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfxModel;
   import alternativa.tanks.models.weapon.shaft.ShaftShootSFXModel;
   import platform.client.fp10.core.model.ObjectLoadListener;
   import platform.client.fp10.core.model.impl.*;
   import platform.client.fp10.core.registry.ModelRegistry;
   import platform.client.fp10.core.registry.ResourceRegistry;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import platform.client.fp10.core.type.IGameObject;
   import alternativa.tanks.models.weapon.ricochet.RicochetSFXModel;
   import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins.TwinsShootSFXCC;
   import alternativa.tanks.models.sfx.colortransform.ColorTransformEntry;
   import alternativa.tanks.models.weapon.smoky.sfx.SmokyShootSFXModel;
   
   public class WeaponsManager
   {
      public static var newname_122__END:ResourceRegistry = OSGi.getInstance().getService(ResourceRegistry) as ResourceRegistry;
      
      public static var modelRegistry:ModelRegistry = OSGi.getInstance().getService(ModelRegistry) as ModelRegistry;
      
      public static var newname_5965__END:Dictionary = new Dictionary();
      
      public static var newname_123__END:Dictionary = new Dictionary();
      
      private static var newname_5966__END:Dictionary = new Dictionary();
      
      private static var newname_5967__END:Dictionary = new Dictionary();
      
      private static var newname_5968__END:Dictionary = new Dictionary();
      
      private static var newname_5969__END:Dictionary = new Dictionary();
      
      private static var newname_5970__END:Dictionary = new Dictionary();
      
      private static var newname_5971__END:Dictionary = new Dictionary();
      
      private static var newname_5972__END:Dictionary = new Dictionary();
      
      private static var newname_5973__END:Dictionary = new Dictionary();
      
      private static var newname_5974__END:Dictionary = new Dictionary();
      
      private static var newname_5975__END:Dictionary = new Dictionary();
      
      private static var newname_5976__END:Dictionary = new Dictionary();
      
      private static var newname_5977__END:Dictionary = new Dictionary();
      
      private static var newname_5978__END:Dictionary = new Dictionary();
      
      public function WeaponsManager()
      {
         super();
      }
      
      public static function newname_2441__END(param1:ClientObject, param2:ClientObject, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         var _loc7_:newname_2398__END = OSGi.getInstance().getService(newname_998__END) as newname_2398__END;
         if(_loc7_ == null)
         {
            _loc7_ = new newname_2398__END();
            OSGi.getInstance().registerService(newname_998__END,_loc7_);
         }
         _loc7_.newname_5979__END(param2,param3,param4,param5,param6);
      }
      
      public static function newname_5980__END(param1:ClientObject, param2:String, param3:Object, param4:IGameObject) : void
      {
         newname_5981__END(param3,param4);
         newname_5982__END(param3,param4);
         var _loc6_:* = param4;
         var _loc5_:Model = Model;
         platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.newname_1693__END;
         platform.client.fp10.core.model.impl.Model.newname_1693__END = _loc6_;
         switch(param2.split("_")[0])
         {
            case "smoky":
               newname_5983__END(param1,param3);
               break;
            case "flamethrower":
               newname_5827__END(param1,param3);
               break;
            case "twins":
               newname_5984__END(param1,param3);
               break;
            case "railgun":
               newname_5985__END(param1,param3);
               break;
            case "ricochet":
               newname_5986__END(param1,param3);
               break;
            case "freeze":
               newname_5987__END(param1,param3);
               break;
            case "isida":
               newname_5988__END(param1,param3);
               break;
            case "shaft":
               newname_5989__END(param1,param3);
               break;
            case "thunder":
               newname_5990__END(param1,param3);
               break;
            case "shotgun":
               newname_5991__END(param1,param3);
               break;
            case "machinegun":
               newname_5992__END(param1,param3);
               break;
            case "artillery":
               newname_5993__END(param1,param3);
         }
         Model.popObject();
      }
      
      public static function newname_5981__END(param1:Object, param2:IGameObject) : void
      {
         var _loc5_:BCSHStruct = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Vector.<BCSHStruct> = new Vector.<BCSHStruct>();
         for each(var _loc4_ in param1.bcsh)
         {
            _loc5_ = new BCSHStruct();
            _loc5_.newname_5994__END = _loc4_.brightness;
            _loc5_.newname_5995__END = _loc4_.contrast;
            _loc5_.newname_5996__END = _loc4_.hue;
            _loc5_.newname_5997__END = _loc4_.key;
            _loc5_.newname_5998__END = _loc4_.saturation;
            _loc3_[_loc3_.length] = _loc5_;
         }
         var _loc9_:* = param2;
         var _loc8_:Model = Model;
         platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.newname_1693__END;
         platform.client.fp10.core.model.impl.Model.newname_1693__END = _loc9_;
         modelRegistry.getModel(param2.gameClass.models[3]).putInitParams(new BCSHModelCC(_loc3_));
         ObjectLoadListener(modelRegistry.getModel(param2.gameClass.models[3])).objectLoaded();
         Model.popObject();
      }
      
      public static function newname_5982__END(param1:Object, param2:IGameObject) : void
      {
         var _loc5_:LightingEfect = null;
         var _loc6_:LightingEfectRecord = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:Vector.<LightingEfect> = new Vector.<LightingEfect>();
         for each(var _loc7_ in param1.lighting)
         {
            _loc5_ = new LightingEfect();
            _loc5_.newname_1120__END = _loc7_.name;
            _loc5_.newname_5999__END = new Vector.<LightingEfectRecord>();
            for each(var _loc3_ in _loc7_.light)
            {
               _loc6_ = new LightingEfectRecord();
               _loc6_.newname_2760__END = _loc3_.attenuationBegin;
               _loc6_.newname_2761__END = _loc3_.attenuationEnd;
               _loc6_.newname_1996__END = _loc3_.color;
               _loc6_.newname_2759__END = _loc3_.intensity;
               _loc6_.ClientTime = _loc3_.time;
               _loc5_.newname_5999__END[_loc5_.newname_5999__END.length] = _loc6_;
            }
            _loc4_[_loc4_.length] = _loc5_;
         }
         var _loc13_:* = param2;
         var _loc12_:Model = Model;
         platform.client.fp10.core.model.impl.Model.objects[platform.client.fp10.core.model.impl.Model.objects.length] = platform.client.fp10.core.model.impl.Model.newname_1693__END;
         platform.client.fp10.core.model.impl.Model.newname_1693__END = _loc13_;
         modelRegistry.getModel(param2.gameClass.models[4]).putInitParams(new LightingSFXModelCC(_loc4_));
         Model.popObject();
      }
      
      public static function newname_5985__END(param1:ClientObject, param2:Object = null) : RailgunShootSFXModel
      {
         var _loc3_:RailgunShootSFXCC = null;
         if(newname_5966__END == null)
         {
            newname_5966__END = new Dictionary();
         }
         var _loc4_:RailgunShootSFXModel = newname_5966__END[param1.id];
         if(param2 != null)
         {
            _loc3_ = new RailgunShootSFXCC();
            _loc3_.newname_6000__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.chargingPart1)));
            _loc3_.newname_6001__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.chargingPart2)));
            _loc3_.newname_6002__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.chargingPart3)));
            _loc3_.newname_6003__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.hitMarkTexture)));
            _loc3_.newname_6004__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.powTexture)));
            _loc3_.newname_6005__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.ringsTexture)));
            _loc3_.newname_6006__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.newname_6007__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.smokeImage)));
            _loc3_.newname_6008__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.sphereTexture)));
            _loc3_.newname_6009__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.trailImage)));
            _loc4_ = new RailgunShootSFXModel();
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoadedPost(param1);
            newname_5966__END[param1.id] = _loc4_;
         }
         return _loc4_;
      }
      
      public static function newname_5983__END(param1:ClientObject, param2:Object = null) : SmokyShootSFXModel
      {
         var _loc3_:SmokyShootSFXCC = null;
         if(newname_5967__END == null)
         {
            newname_5967__END = new Dictionary();
         }
         var _loc4_:SmokyShootSFXModel = newname_5967__END[param1.id];
         if(param2 != null)
         {
            _loc3_ = new SmokyShootSFXCC();
            _loc3_.newname_6010__END = param2.criticalHitSize;
            _loc3_.newname_6011__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.criticalHitTexture)));
            _loc3_.newname_4491__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionMarkTexture)));
            _loc3_.newname_6012__END = param2.explosionSize;
            _loc3_.newname_4492__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.explosionSound)));
            _loc3_.newname_6013__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.newname_6006__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.newname_6014__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.shotTexture)));
            _loc4_ = new SmokyShootSFXModel();
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoaded(param1);
            newname_5967__END[param1.id] = _loc4_;
         }
         return _loc4_;
      }
      
      public static function newname_5827__END(param1:ClientObject, param2:Object = null) : FlameThrowingSFXModel
      {
         var _loc3_:FlameThrowingSFXCC = null;
         var _loc6_:* = undefined;
         var _loc4_:ColorTransformEntry = null;
         if(newname_5968__END == null)
         {
            newname_5968__END = new Dictionary();
         }
         var _loc7_:FlameThrowingSFXModel = newname_5968__END[param1.id];
         if(param2 != null)
         {
            _loc7_ = new FlameThrowingSFXModel();
            _loc3_ = new FlameThrowingSFXCC();
            _loc3_.newname_5573__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.fireTexture)));
            _loc3_.newname_5574__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.flameSound)));
            _loc3_.newname_5575__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.muzzlePlaneTexture)));
            _loc7_.putInitParams(_loc3_);
            _loc7_.objectLoaded(param1);
            _loc6_ = new Vector.<ColorTransformEntry>();
            for each(var _loc5_ in param2.colorTransform)
            {
               _loc4_ = new ColorTransformEntry(_loc5_.redMultiplier,_loc5_.greenMultiplier,_loc5_.blueMultiplier,_loc5_.alphaMultiplier,_loc5_.redOffset,_loc5_.greenOffset,_loc5_.blueOffset,_loc5_.alphaOffset,_loc5_.t);
               _loc6_.push(_loc4_);
            }
            _loc7_.initColorTransform(param1,_loc6_);
            newname_5968__END[param1.id] = _loc7_;
         }
         return _loc7_;
      }
      
      public static function newname_5984__END(param1:ClientObject, param2:Object = null) : TwinsShootSFXModel
      {
         var _loc3_:TwinsShootSFXCC = null;
         if(newname_5969__END == null)
         {
            newname_5969__END = new Dictionary();
         }
         if(param2 != null)
         {
            newname_5969__END[param1.id] = new TwinsShootSFXModel();
            _loc3_ = new TwinsShootSFXCC();
            _loc3_.newname_6013__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.newname_6003__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.hitMarkTexture)));
            _loc3_.newname_6015__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.muzzleFlashTexture)));
            _loc3_.newname_6006__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.newname_6014__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.shotTexture)));
            newname_5969__END[param1.id].putInitParams(_loc3_);
            newname_5969__END[param1.id].objectLoadedPost(param1);
         }
         return newname_5969__END[param1.id];
      }
      
      public static function newname_5988__END(param1:ClientObject, param2:Object = null) : IsisSFXModel
      {
         var _loc3_:IsisSFXCC = null;
         if(newname_5970__END == null)
         {
            newname_5970__END = new Dictionary();
         }
         if(param2 != null)
         {
            newname_5970__END[param1.id] = new IsisSFXModel();
            _loc3_ = new IsisSFXCC();
            _loc3_.newname_6016__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.damagingBall)));
            _loc3_.newname_6017__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.damagingRay)));
            _loc3_.newname_6018__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.damagingSound)));
            _loc3_.newname_6019__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.healingBall)));
            _loc3_.newname_6020__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.healingRay)));
            _loc3_.newname_6021__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.healingSound)));
            _loc3_.newname_6022__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.idleSound)));
            newname_5970__END[param1.id].putInitParams(_loc3_);
            newname_5970__END[param1.id].objectLoadedPost(param1);
         }
         return newname_5970__END[param1.id];
      }
      
      public static function newname_5990__END(param1:ClientObject, param2:Object = null) : ThunderShootSFXModel
      {
         var _loc3_:ThunderShootSFXCC = null;
         if(newname_5971__END == null)
         {
            newname_5971__END = new Dictionary();
         }
         if(param2 != null)
         {
            newname_5971__END[param1.id] = new ThunderShootSFXModel();
            _loc3_ = new ThunderShootSFXCC();
            _loc3_.newname_4491__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionMarkTexture)));
            _loc3_.newname_6012__END = param2.explosionSize;
            _loc3_.newname_4492__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.explosionSound)));
            _loc3_.newname_6013__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.newname_6006__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.newname_6014__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.shotTexture)));
            newname_5971__END[param1.id].putInitParams(_loc3_);
            newname_5971__END[param1.id].objectLoaded(param1);
         }
         return newname_5971__END[param1.id];
      }
      
      public static function newname_5987__END(param1:ClientObject, param2:Object = null) : FreezeSFXModel
      {
         var _loc3_:FreezeSFXCC = null;
         if(newname_5972__END == null)
         {
            newname_5972__END = new Dictionary();
         }
         if(param2 != null)
         {
            newname_5972__END[param1.id] = new FreezeSFXModel();
            _loc3_ = new FreezeSFXCC();
            _loc3_.newname_5780__END = param2.particleSpeed;
            _loc3_.newname_6023__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.particleTextureResource)));
            _loc3_.newname_6024__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.planeTextureResource)));
            _loc3_.newname_6025__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shotSoundResource)));
            newname_5972__END[param1.id].putInitParams(_loc3_);
            newname_5972__END[param1.id].objectLoaded(param1);
         }
         return newname_5972__END[param1.id];
      }
      
      public static function newname_5986__END(param1:ClientObject, param2:Object = null) : RicochetSFXModel
      {
         var _loc3_:RicochetSFXCC = null;
         if(newname_5973__END == null)
         {
            newname_5973__END = new Dictionary();
         }
         var _loc4_:RicochetSFXModel = newname_5973__END[param1.id];
         if(param2 != null)
         {
            _loc3_ = new RicochetSFXCC();
            _loc3_.newname_6026__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.bumpFlashTexture)));
            _loc3_.newname_6013__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.newname_6027__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.explosionSound)));
            _loc3_.newname_6028__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.ricochetSound)));
            _loc3_.newname_6029__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.shotFlashTexture)));
            _loc3_.newname_6006__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.newname_6014__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.shotTexture)));
            _loc3_.newname_6030__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.tailTrailTexutre)));
            _loc4_ = new RicochetSFXModel();
            _loc4_.putInitParams(_loc3_);
            _loc4_.objectLoadedPost(param1);
            newname_5973__END[param1.id] = _loc4_;
         }
         return _loc4_;
      }
      
      public static function newname_5989__END(param1:ClientObject, param2:Object = null) : ShaftShootSFXModel
      {
         var _loc3_:ShaftShootSFXModel = null;
         var _loc4_:ShaftShootSFXCC = null;
         if(newname_5974__END == null)
         {
            newname_5974__END = new Dictionary();
         }
         if(param2 != null)
         {
            newname_5974__END[param1.id] = new ShaftShootSFXModel();
            _loc4_ = new ShaftShootSFXCC();
            _loc4_.newname_4492__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.explosionSound)));
            _loc4_.newname_6013__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc4_.newname_6003__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.hitMarkTexture)));
            _loc4_.newname_6015__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.muzzleFlashTexture)));
            _loc4_.newname_6006__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shotSound)));
            _loc4_.newname_6031__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.targetingSound)));
            _loc4_.newname_6032__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.trailTexture)));
            _loc4_.newname_6033__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.zoomModeSound)));
            newname_5974__END[param1.id].putInitParams(_loc4_);
            newname_5974__END[param1.id].objectLoadedPost(param1);
         }
         return newname_5974__END[param1.id];
      }
      
      public static function newname_5991__END(param1:ClientObject, param2:Object = null) : ShotgunSFXModel
      {
         var _loc3_:ShotgunSFXCC = null;
         var _loc4_:ShotgunSFXModel = null;
         if(newname_5975__END == null)
         {
            newname_5975__END = new Dictionary();
         }
         if(param2 != null)
         {
            newname_5975__END[param1.id] = new ShotgunSFXModel();
            _loc3_ = new ShotgunSFXCC();
            _loc3_.newname_6034__END = new Vector.<ImageResource>(4);
            _loc3_.newname_6034__END[0] = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionMarkTexture0)));
            _loc3_.newname_6034__END[1] = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionMarkTexture1)));
            _loc3_.newname_6034__END[2] = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionMarkTexture2)));
            _loc3_.newname_6034__END[3] = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionMarkTexture3)));
            _loc3_.newname_6035__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.magazineReloadSound)));
            _loc3_.newname_6036__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.pelletTrailTexture)));
            _loc3_.newname_6037__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.reloadSound)));
            _loc3_.newname_6038__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.shotAcrossTexture)));
            _loc3_.newname_6039__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.shotAlongTexture)));
            _loc3_.newname_6006__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shotSound)));
            _loc3_.newname_6040__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.smokeTexture)));
            _loc3_.newname_6041__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.sparkleTexture)));
            newname_5975__END[param1.id].putInitParams(_loc3_);
            newname_5975__END[param1.id].objectLoadedPost(param1);
         }
         return newname_5975__END[param1.id];
      }
      
      public static function newname_5992__END(param1:ClientObject, param2:Object = null) : MachineGunSFXModel
      {
         var _loc3_:MachineGunSFXModel = null;
         var _loc4_:MachineGunSFXCC = null;
         if(newname_5976__END == null)
         {
            newname_5976__END = new Dictionary();
         }
         if(param2 != null)
         {
            newname_5976__END[param1.id] = new MachineGunSFXModel();
            _loc4_ = new MachineGunSFXCC();
            _loc4_.newname_6042__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.chainStartSound)));
            _loc4_.newname_6043__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.crumbsTexture)));
            _loc4_.newname_6044__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.dustTexture)));
            _loc4_.newname_6045__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.fireAcrossTexture)));
            _loc4_.newname_6046__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.fireAlongTexture)));
            _loc4_.newname_6047__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.hitSound)));
            _loc4_.newname_6048__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.longFailSound)));
            _loc4_.newname_6049__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shootEndSound)));
            _loc4_.newname_6050__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shootSound)));
            _loc4_.newname_6040__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.smokeTexture)));
            _loc4_.newname_6051__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.sparklesTexture)));
            _loc4_.newname_6052__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.tankHitSound)));
            _loc4_.newname_6053__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.tankSparklesTexture)));
            _loc4_.newname_6054__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.tracerTexture)));
            _loc4_.newname_6055__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.turbineStartSound)));
            newname_5976__END[param1.id].putInitParams(_loc4_);
            newname_5976__END[param1.id].objectLoadedPost(param1);
         }
         return newname_5976__END[param1.id];
      }
      
      public static function newname_5993__END(param1:ClientObject, param2:Object = null) : ArtillerySfxModel
      {
         var _loc3_:ArtillerySfxCC = null;
         if(newname_5977__END == null)
         {
            newname_5977__END = new Dictionary();
         }
         if(param2 != null)
         {
            _loc3_ = new ArtillerySfxCC();
            _loc3_.newname_6056__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.chargingSound)));
            _loc3_.newname_4492__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.explosionSound)));
            _loc3_.newname_6057__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.farShotSound)));
            _loc3_.newname_6058__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.flyBySound)));
            _loc3_.newname_6059__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shot1Sound)));
            _loc3_.newname_6060__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shot2Sound)));
            _loc3_.newname_6061__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shot3Sound)));
            _loc3_.newname_6062__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.shot4Sound)));
            _loc3_.newname_6037__END = SoundResource(newname_122__END.getResource(Long.getLong(0,param2.reloadSound)));
            _loc3_.newname_6063__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.streamTexture)));
            _loc3_.newname_6064__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.flameTexture)));
            _loc3_.newname_6032__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.trailTexture)));
            _loc3_.newname_6065__END = ImageResource(newname_122__END.getResource(Long.getLong(0,param2.markTexture)));
            _loc3_.newname_6013__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.explosionTexture)));
            _loc3_.newname_6040__END = MultiframeImageResource(newname_122__END.getResource(Long.getLong(0,param2.smokeTexture)));
            newname_5977__END[param1.id] = new ArtillerySfxModel();
            newname_5977__END[param1.id].putInitParams(_loc3_);
            newname_5977__END[param1.id].objectLoaded(param1);
         }
         return newname_5977__END[param1.id];
      }
      
      public static function newname_2440__END(param1:String) : ClientObject
      {
         if(newname_5978__END[param1] == null)
         {
            newname_5978__END[param1] = newname_5979__END(param1);
         }
         return newname_5978__END[param1];
      }
      
      public static function newname_2438__END(param1:ClientObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(newname_5974__END != null)
         {
            if(newname_5974__END[param1.id] != null)
            {
               newname_5974__END[param1.id].objectUnloaded(param1);
               delete newname_5974__END[param1.id];
            }
         }
         if(newname_5971__END != null)
         {
            if(newname_5971__END[param1.id] != null)
            {
               newname_5971__END[param1.id].objectUnloaded(param1);
               delete newname_5971__END[param1.id];
            }
         }
         if(newname_5973__END != null)
         {
            if(newname_5973__END[param1.id] != null)
            {
               newname_5973__END[param1.id].objectUnloaded(param1);
               delete newname_5973__END[param1.id];
            }
         }
         if(newname_5972__END != null)
         {
            if(newname_5972__END[param1.id] != null)
            {
               newname_5972__END[param1.id].objectUnloaded(param1);
               delete newname_5972__END[param1.id];
            }
         }
         if(newname_5970__END != null)
         {
            if(newname_5970__END[param1.id] != null)
            {
               newname_5970__END[param1.id].objectUnloaded(param1);
               delete newname_5970__END[param1.id];
            }
         }
         if(newname_5969__END != null)
         {
            if(newname_5969__END[param1.id] != null)
            {
               newname_5969__END[param1.id].objectUnloaded(param1);
               delete newname_5969__END[param1.id];
            }
         }
         if(newname_5968__END != null)
         {
            if(newname_5968__END[param1.id] != null)
            {
               newname_5968__END[param1.id].objectUnloaded(param1);
               delete newname_5968__END[param1.id];
            }
         }
         if(newname_5967__END != null)
         {
            if(newname_5967__END[param1.id] != null)
            {
               newname_5967__END[param1.id].objectUnloaded(param1);
               delete newname_5967__END[param1.id];
            }
         }
         if(newname_5966__END != null)
         {
            if(newname_5966__END[param1.id] != null)
            {
               newname_5966__END[param1.id].objectUnloaded(param1);
               delete newname_5966__END[param1.id];
            }
         }
         if(newname_5975__END != null)
         {
            if(newname_5975__END[param1.id] != null)
            {
               newname_5975__END[param1.id].objectUnloaded(param1);
               delete newname_5975__END[param1.id];
            }
         }
         if(newname_5976__END != null)
         {
            if(newname_5976__END[param1.id] != null)
            {
               newname_5976__END[param1.id].objectUnloaded(param1);
               delete newname_5976__END[param1.id];
            }
         }
         if(newname_5977__END != null)
         {
            if(newname_5977__END[param1.id] != null)
            {
               newname_5977__END[param1.id].objectUnloaded(param1);
               delete newname_5977__END[param1.id];
            }
         }
      }
      
      private static function newname_5979__END(param1:String) : ClientObject
      {
         return new ClientObject(param1);
      }
      
      public static function destroy() : void
      {
         newname_5970__END = null;
         newname_5969__END = null;
         newname_5968__END = null;
         newname_5967__END = null;
         newname_5966__END = null;
         newname_5971__END = null;
         newname_5973__END = null;
         newname_5972__END = null;
         newname_5974__END = null;
         newname_5975__END = null;
         newname_5977__END = null;
      }
   }
}

