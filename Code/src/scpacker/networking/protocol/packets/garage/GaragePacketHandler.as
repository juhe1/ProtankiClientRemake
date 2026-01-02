package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import newname_4898__END.RentItemCC;
   import alternativa.tanks.model.item.present.PresentItemModel;
   import alternativa.tanks.model.ItemModel;
   import alternativa.model.timeperiod.TimePeriodModel;
   import alternativa.tanks.model.item.kit.GarageKitModel;
   import projects.tanks.client.garage.models.item.view.ItemViewCategoryCC;
   import projects.tanks.client.garage.models.item.discount.DiscountCC;
   import platform.client.models.commons.periodtime.TimePeriodModelCC;
   import alternativa.tanks.model.presents.NewPresentsShowingModel;
   import platform.client.models.commons.description.DescriptionModelCC;
   import projects.tanks.client.garage.models.item.countable.CountableItemCC;
   import alternativa.tanks.model.item.discount.DiscountCollectorModel;
   import alternativa.tanks.model.item.discount.DiscountModel;
   import projects.tanks.client.garage.models.item.buyable.BuyableCC;
   import alternativa.tanks.model.item.buyable.BuyableModel;
   import alternativa.tanks.model.item.modification.ModificationModel;
   import projects.tanks.client.garage.models.item.properties.ItemGaragePropertyData;
   import projects.tanks.client.garage.models.item.properties.ItemPropertiesCC;
   import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyData;
   import projects.tanks.client.garage.models.item.upgradeable.types.PropertyData;
   import alternativa.types.Long;
   import projects.tanks.client.garage.models.item.modification.ModificationCC;
   import projects.tanks.client.garage.models.item.item.ItemModelCC;
   import alternativa.model.description.DescriptionModel;
   import newname_6521__END.newname_6522__END;
   import projects.tanks.client.garage.models.item.delaymount.DelayMountCategoryCC;
   import alternativa.tanks.model.item.countable.CountableItemModel;
   import projects.tanks.client.garage.models.item.item3d.Item3DCC;
   import alternativa.tanks.model.item.item.ItemModel;
   import projects.tanks.client.garage.models.item.kit.GarageKitCC;
   import projects.tanks.client.garage.models.item.kit.KitItem;
   import projects.tanks.client.garage.models.item.upgradeable.calculators.LinearParams;
   import projects.tanks.client.garage.models.item.present.PresentItemCC;
   import alternativa.tanks.model.item.discount.DiscountForUpgradeModel;
   import projects.tanks.client.garage.models.item.temporary.TemporaryItemCC;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.model.garage.ItemCategoryModel;
   import alternativa.tanks.model.item.upgradable.UpgradeableParamsConstructorModel;
   import alternativa.tanks.service.achievement.IAchievementService;
   import alternativa.tanks.model.item.properties.Object3DSModel;
   import newname_1668__END.RentModel;
   import scpacker.utils.EnumUtils;
   import alternativa.tanks.model.item.grouped.GroupedItemModel;
   import alternativa.tanks.model.item.fitting.ItemFittingModel;
   import alternativa.tanks.model.garage.present.PresentGivenModel;
   import alternativa.tanks.model.garage.present.PresentPurchaseModel;
   import alternativa.tanks.model.item.temporary.TemporaryItemModel;
   import scpacker.networking.protocol.AbstractPacket;
   import alternativa.tanks.model.item.object3ds.Object3DSModel;
   import projects.tanks.clients.flash.commons.models.coloring.ColoringModel;
   import projects.tanks.client.garage.models.item.grouped.GroupedCC;
   import projects.tanks.client.garage.models.item.category.ItemCategoryCC;
   import platform.client.fp10.core.model.impl.*;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.newname_3133__END;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.IGameClass;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
   import projects.tanks.client.garage.models.item.category.GarageModelCC;
   import projects.tanks.client.garage.models.item.upgradeable.UpgradableParamsCC;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import alternativa.tanks.model.item.category.ItemCategoryModel;
   import alternativa.tanks.model.item.category.ItemViewCategoryModel;
   import projects.tanks.client.commons.models.coloring.ColoringCC;
   import alternativa.tanks.model.item.rename.RenameModel;
   import projects.tanks.client.garage.models.item.object3ds.Object3DSCC;
   import platform.client.fp10.core.type.ISpace;
   import alternativa.tanks.model.item3d.Object3DSModel;
   import projects.tanks.client.garage.models.item.upgradeable.UpgradeableParamsConstructorModelBase;
   import alternativa.tanks.model.item.upgradable.UpgradeParamsModel;
   import scpacker.utils.EnumUtils;
   import projects.tanks.client.garage.models.item.upgradeable.UpgradeParamsCC;
   import projects.tanks.client.garage.models.item.upgradeable.types.UpgradeParamsData;
   import projects.tanks.client.garage.models.item.upgradeable.types.GaragePropertyParams;
   import alternativa.tanks.model.garage.GarageModel;
   import projects.tanks.client.garage.models.item.category.ItemCategoryModelBase;
   import projects.tanks.client.garage.models.item.item.ItemModelBase;
   import projects.tanks.client.garage.models.item.view.ItemViewCategoryModelBase;
   import platform.client.models.commons.description.DescriptionModelBase;
   import projects.tanks.client.garage.models.item.buyable.BuyableModelBase;
   import projects.tanks.client.garage.models.item.modification.ModificationModelBase;
   import projects.tanks.client.garage.models.item.item3d.Item3DModelBase;
   import projects.tanks.client.garage.models.item.countable.CountableItemModelBase;
   import projects.tanks.client.garage.models.item.object3ds.Object3DSModelBase;
   import projects.tanks.client.commons.models.coloring.ColoringModelBase;
   import projects.tanks.client.garage.models.item.temporary.TemporaryItemModelBase;
   import projects.tanks.client.garage.models.item.discount.DiscountModelBase;
   import projects.tanks.client.garage.models.item.discount.DiscountCollectorModelBase;
   import projects.tanks.client.garage.models.item.kit.GarageKitModelBase;
   import platform.client.models.commons.periodtime.TimePeriodModelBase;
   import projects.tanks.client.garage.models.item.fitting.ItemFittingModelBase;
   import projects.tanks.client.garage.models.garage.present.PresentGivenModelBase;
   import projects.tanks.client.garage.models.garage.present.PresentPurchaseModelBase;
   import projects.tanks.client.garage.models.item.present.PresentItemModelBase;
   import projects.tanks.client.garage.models.item.upgradeable.discount.DiscountForUpgradeModelBase;
   import projects.tanks.client.panel.model.presents.NewPresentsShowingModelBase;
   import projects.tanks.client.garage.models.item.grouped.GroupedItemModelBase;
   import projects.tanks.client.garage.prototypes.item.renameitem.RenameModelBase;
   import projects.tanks.client.garage.models.garage.GarageModelBase;
   
   public class GaragePacketHandler extends AbstractPacketHandler
   {
      private var itemCategoryModel:ItemCategoryModel;
      private var itemModel:ItemModel;
      private var itemCategoryModel2:ItemCategoryModel;
      private var itemViewCategoryModel:ItemViewCategoryModel;
      private var descriptionModel:DescriptionModel;
      private var buyableModel:BuyableModel;
      private var modificationModel:ModificationModel;
      private var object3dsModel:Object3DSModel;
      private var upgradeParamsModel:UpgradeParamsModel;
      private var countableItemModel:CountableItemModel;
      private var object3dsModel2:Object3DSModel;
      private var coloringModel:ColoringModel;
      private var temporaryItemModel:TemporaryItemModel;
      private var discountModel:DiscountModel;
      private var discountCollectorModel:DiscountCollectorModel;
      private var garageKitModel:GarageKitModel;
      private var timePeriodModel:TimePeriodModel;
      private var itemFittingModel:ItemFittingModel;
      private var presentGivenModel:PresentGivenModel;
      private var presentPurchaseModel:PresentPurchaseModel;
      private var presentItemModel:PresentItemModel;
      private var discountForUpgradeModel:DiscountForUpgradeModel;
      private var itemModel2:ItemModel;
      private var newPresentsShowingModel:NewPresentsShowingModel;
      private var groupedItemModel:GroupedItemModel;
      private var rentModel:RentModel;
      private var renameModel:RenameModel;
      private var garageModel:GarageModel;
      private var achievementService:IAchievementService;
      private var itemGameClass:IGameClass;
      private var newname_6559__END:IGameClass;
      private var garageSpace:ISpace;
      private var newname_6561__END:IGameObject;
      
      public function GaragePacketHandler()
      {
         super();
         this.id = 34;
         this.itemCategoryModel = ItemCategoryModel(modelRegistry.getModel(ItemCategoryModelBase.modelId));
         this.itemModel = ItemModel(modelRegistry.getModel(ItemModelBase.modelId));
         this.itemCategoryModel2 = ItemCategoryModel(modelRegistry.getModel(ItemCategoryModelBase.modelId));
         this.itemViewCategoryModel = ItemViewCategoryModel(modelRegistry.getModel(ItemViewCategoryModelBase.modelId));
         this.descriptionModel = DescriptionModel(modelRegistry.getModel(DescriptionModelBase.modelId));
         this.buyableModel = BuyableModel(modelRegistry.getModel(BuyableModelBase.modelId));
         this.modificationModel = ModificationModel(modelRegistry.getModel(ModificationModelBase.modelId));
         this.object3dsModel = Object3DSModel(modelRegistry.getModel(Item3DModelBase.modelId));
         this.upgradeParamsModel = UpgradeParamsModel(modelRegistry.getModel(UpgradeableParamsConstructorModelBase.modelId));
         this.countableItemModel = CountableItemModel(modelRegistry.getModel(CountableItemModelBase.modelId));
         this.object3dsModel2 = Object3DSModel(modelRegistry.getModel(Object3DSModelBase.modelId));
         this.coloringModel = ColoringModel(modelRegistry.getModel(ColoringModelBase.modelId));
         this.temporaryItemModel = TemporaryItemModel(modelRegistry.getModel(TemporaryItemModelBase.modelId));
         this.discountModel = DiscountModel(modelRegistry.getModel(DiscountModelBase.modelId));
         this.discountCollectorModel = DiscountCollectorModel(modelRegistry.getModel(DiscountCollectorModelBase.modelId));
         this.garageKitModel = GarageKitModel(modelRegistry.getModel(GarageKitModelBase.modelId));
         this.timePeriodModel = TimePeriodModel(modelRegistry.getModel(TimePeriodModelBase.modelId));
         this.itemFittingModel = ItemFittingModel(modelRegistry.getModel(ItemFittingModelBase.modelId));
         this.presentGivenModel = PresentGivenModel(modelRegistry.getModel(PresentGivenModelBase.modelId));
         this.presentPurchaseModel = PresentPurchaseModel(modelRegistry.getModel(PresentPurchaseModelBase.modelId));
         this.presentItemModel = PresentItemModel(modelRegistry.getModel(PresentItemModelBase.modelId));
         this.discountForUpgradeModel = DiscountForUpgradeModel(modelRegistry.getModel(DiscountForUpgradeModelBase.modelId));
         this.itemModel2 = ItemModel(modelRegistry.getModel(Item3DModelBase.modelId));
         this.newPresentsShowingModel = NewPresentsShowingModel(modelRegistry.getModel(NewPresentsShowingModelBase.modelId));
         this.groupedItemModel = GroupedItemModel(modelRegistry.getModel(GroupedItemModelBase.modelId));
         this.rentModel = RentModel(modelRegistry.getModel(Long.getLong(253893127,1551357191)));
         this.renameModel = RenameModel(modelRegistry.getModel(RenameModelBase.modelId));
         this.garageModel = GarageModel(modelRegistry.getModel(GarageModelBase.modelId));
         var _loc1_:Vector.<Long> = new Vector.<Long>();
         var renameGameClass:Vector.<Long> = new Vector.<Long>();
         _loc1_.push(this.itemModel.id);
         _loc1_.push(this.itemViewCategoryModel.id);
         _loc1_.push(this.itemCategoryModel2.id);
         _loc1_.push(this.descriptionModel.id);
         _loc1_.push(this.buyableModel.id);
         _loc1_.push(this.modificationModel.id);
         _loc1_.push(this.object3dsModel.id);
         _loc1_.push(this.upgradeParamsModel.id);
         _loc1_.push(this.countableItemModel.id);
         _loc1_.push(this.object3dsModel2.id);
         _loc1_.push(this.coloringModel.id);
         _loc1_.push(this.temporaryItemModel.id);
         _loc1_.push(this.discountModel.id);
         _loc1_.push(this.discountCollectorModel.id);
         _loc1_.push(this.garageKitModel.id);
         _loc1_.push(this.timePeriodModel.id);
         _loc1_.push(this.itemFittingModel.id);
         _loc1_.push(this.itemCategoryModel.id);
         _loc1_.push(this.presentGivenModel.id);
         _loc1_.push(this.presentPurchaseModel.id);
         _loc1_.push(this.presentItemModel.id);
         _loc1_.push(this.discountForUpgradeModel.id);
         _loc1_.push(this.groupedItemModel.id);
         _loc1_.push(this.rentModel.id);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            renameGameClass.push(_loc1_[_loc3_]);
            _loc3_++;
         }
         this.itemGameClass = gameTypeRegistry.createClass(Long.getLong(15025,684360),_loc1_);
         renameGameClass.push(this.renameModel.id);
         this.newname_6559__END = gameTypeRegistry.createClass(Long.getLong(15026,684361),renameGameClass);
         this.garageSpace = ISpace(spaceRegistry.getSpace(Long.getLong(884380667,214)));
         this.achievementService = IAchievementService(OSGi.getInstance().getService(IAchievementService));
      }
      
      public function invoke(param1:AbstractPacket) : void
      {
         switch(param1.getId())
         {
            case LoadOwnedGarageItemsInPacket.id:
               this.loadOwnedGarageItems(param1 as LoadOwnedGarageItemsInPacket);
               break;
            case LoadPurchasableItemsInPacket.id:
               this.loadPurchasableItems(param1 as LoadPurchasableItemsInPacket);
               break;
            case UnloadGarageSpaceInPacket.id:
               this.unloadGarageSpace();
               break;
            case CheckItemMountedInPacket.id:
               this.initMounted(param1 as CheckItemMountedInPacket);
               break;
            case RenameFailedInPacket.id:
               this.renameFail();
               break;
            case RenameSuccessfulInPacket.id:
               this.renameSuccessfull(param1 as RenameSuccessfulInPacket);
               break;
            case SelectFirstDepotItemInPacket.id:
               this.selectFirstItemInDepot();
               break;
            case SelectItemInPacket.id:
               this.selectItem(param1 as SelectItemInPacket);
               break;
            case ShowGarageCategoryInPacket.id:
               this.showCategory(param1 as ShowGarageCategoryInPacket);
               break;
            case ShowNewPresentsAlertInPacket.id:
               this.showAlert();
         }
      }
      
      private function loadOwnedGarageItems(param1:LoadOwnedGarageItemsInPacket) : void
      {
         var itemGarageProperties:Vector.<ItemGaragePropertyData> = null;
         var garageProperties:Vector.<UpgradeParamsData> = null;
         var subProperties:Vector.<PropertyData> = null;
         var modificationId:int = 0;
         var gameObject:IGameObject = null;
         var depotItems:Vector.<IGameObject> = new Vector.<IGameObject>();
         var presentItems:Vector.<IGameObject> = new Vector.<IGameObject>();
         var parsedJson:Object = JSON.parse(param1.battlesJson);
         for each(var item in parsedJson.items)
         {
            itemGarageProperties = new Vector.<ItemGaragePropertyData>();
            garageProperties = new Vector.<UpgradeParamsData>();
            for each(var property in item.properts)
            {
               subProperties = new Vector.<PropertyData>();
               itemGarageProperties.push(new ItemGaragePropertyData(EnumUtils.stringToItemGarageProperty(property.property),property.value));
               if(property.subproperties != null)
               {
                  for each(var subProperty in property.subproperties)
                  {
                     subProperties.push(new PropertyData(subProperty.value,subProperty.value,EnumUtils.stringToItemProperty(subProperty.property)));
                  }
               }
               else
               {
                  subProperties.push(new PropertyData(property.value,property.value,EnumUtils.stringToItemProperty(property.property)));
               }
               garageProperties.push(new GaragePropertyData(new LinearParams(property.value,property.value),0,0,25,subProperties,EnumUtils.stringToItemGarageProperty(property.property),0,0,new LinearParams(property.value,property.value)));
            }
            modificationId = int(item.modificationID);
            gameObject = this.garageSpace.createObject(Long.getLong(0,EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.GIVEN_PRESENT ? int(item.present.date + item.previewResourceId) : int(item.previewResourceId)),this.itemGameClass,item.id + "_m" + modificationId);
            
            Model.object = gameObject;
            if(item.price == 8000 && item.index > 10000)
            {
               item.index = 9897;
            }
            this.itemModel.putInitParams(new ItemModelCC(30,item.rank,item.index,ImageResource(resourceRegistry.getResource(Long.getLong(0,item.previewResourceId)))));
            this.itemViewCategoryModel.putInitParams(new ItemViewCategoryCC(EnumUtils.stringToItemViewCategoryEnum(item.category)));
            this.itemCategoryModel2.putInitParams(new ItemCategoryCC(EnumUtils.intToItemCategoryEnum(item.type)));
            this.descriptionModel.putInitParams(new DescriptionModelCC(item.description,item.name));
            this.buyableModel.putInitParams(new BuyableCC(true,item.price));
            this.modificationModel.putInitParams(new ModificationCC(Long.getLong(0,item.baseItemId),item.modificationID == null ? -1 : int(item.modificationID)));
            this.object3dsModel.putInitParams(new ItemPropertiesCC(itemGarageProperties));
            this.upgradeParamsModel.putInitParams(new UpgradeParamsCC(null,garageProperties));
            this.countableItemModel.putInitParams(new CountableItemCC(item.count == null ? -1 : int(item.count)));
            this.object3dsModel2.putInitParams(new Object3DSCC(Long.getLong(0,item.object3ds)));
            this.coloringModel.putInitParams(new ColoringCC(null,ImageResource(newname_122__END.getResource(Long.getLong(0,item.coloring)))));
            this.temporaryItemModel.putInitParams(new TemporaryItemCC(0,item.remainingTimeInSec > 0 ? item.remainingTimeInSec : 0));
            this.discountModel.putInitParams(new DiscountCC(item.discount.percent,item.discount.timeLeftInSeconds,0));
            if(EnumUtils.newname_6575__END(item.type) == ItemCategoryEnum.GIVEN_PRESENT)
            {
               this.presentItemModel.putInitParams(new PresentItemCC(item.present.date,ImageResource(newname_122__END.getResource(Long.getLong(0,item.present.image))),item.present.presenter,item.present.text,item.present.presentId));
            }
            this.rentModel.putInitParams(new RentItemCC(item.isForRent));
            this.discountModel.objectLoadedPost();
            this.countableItemModel.objectLoaded();
            this.temporaryItemModel.objectLoaded();
            this.upgradeParamsModel.objectLoadedPost();
            Model.popObject();
            if(EnumUtils.newname_6575__END(item.type) == ItemCategoryEnum.GIVEN_PRESENT)
            {
               presentItems[presentItems.length] = gameObject;
            }
            else
            {
               depotItems[depotItems.length] = gameObject;
            }
         }
         this.itemCategoryModel.putInitParams(new GarageModelCC(Tanks3DSResource(newname_122__END.getResource(Long.getLong(0,parsedJson.garageBoxId))))));
         this.itemCategoryModel.objectLoaded();
         this.itemCategoryModel.initDepot(depotItems);
         this.itemCategoryModel.initPresents(presentItems);
      }

      private function loadOwnedGarageItemsNew(param1:LoadOwnedGarageItemsInPacket) : void
      {
         var itemGarageProperties:Vector.<ItemGaragePropertyData> = null;
         var garageProperties:Vector.<GaragePropertyParams > = null;
         var subProperties:Vector.<PropertyData> = null;
         var modificationId:int = 0;
         var gameObject:IGameObject = null;
         var depotItems:Vector.<IGameObject> = new Vector.<IGameObject>();
         var presentItems:Vector.<IGameObject> = new Vector.<IGameObject>();
         var parsedJson:Object = JSON.parse(param1.battlesJson);
         for each(var item in parsedJson.items)
         {
            itemGarageProperties = new Vector.<ItemGaragePropertyData>();
            garageProperties = new Vector.<GaragePropertyParams >();
            for each(var property in item.properts)
            {
               subProperties = new Vector.<PropertyData>();
               itemGarageProperties.push(new ItemGaragePropertyData(EnumUtils.stringToItemGarageProperty(property.property),property.value));
               if(property.subproperties != null)
               {
                  for each(var subProperty in property.subproperties)
                  {
                     subProperties.push(new PropertyData(subProperty.value,subProperty.value,EnumUtils.stringToItemProperty(subProperty.property)));
                  }
               }
               else
               {
                  subProperties.push(new PropertyData(property.value,property.value,EnumUtils.stringToItemProperty(property.property)));
               }


               var garagePropertyParams:GaragePropertyParams = new GaragePropertyParams();
               garagePropertyParams.precision = 0;
               garagePropertyParams.properties = subProperties
               garagePropertyParams.property = EnumUtils.stringToItemGarageProperty(property.property);
               garagePropertyParams.visibleInInfo = true;
               garageProperties.push(garagePropertyParams);
            }
            modificationId = int(item.modificationID);
            gameObject = this.garageSpace.createObject(Long.getLong(0,EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.GIVEN_PRESENT ? int(item.present.date + item.previewResourceId) : int(item.previewResourceId)),this.itemGameClass,item.id + "_m" + modificationId);
            
            Model.object = gameObject;
            if(item.price == 8000 && item.index > 10000)
            {
               item.index = 9897;
            }
            this.itemModel.putInitParams(new ItemModelCC(30,item.rank,item.index,ImageResource(resourceRegistry.getResource(Long.getLong(0,item.previewResourceId)))));
            this.itemViewCategoryModel.putInitParams(new ItemViewCategoryCC(EnumUtils.stringToItemViewCategoryEnum(item.category)));
            this.itemCategoryModel2.putInitParams(new ItemCategoryCC(EnumUtils.intToItemCategoryEnum(item.type)));
            this.descriptionModel.putInitParams(new DescriptionModelCC(item.description,item.name));
            this.buyableModel.putInitParams(new BuyableCC(true,item.price));
            this.modificationModel.putInitParams(new ModificationCC(Long.getLong(0,item.baseItemId),item.modificationID == null ? -1 : int(item.modificationID)));
            this.object3dsModel.putInitParams(new ItemPropertiesCC(itemGarageProperties));
            
            var upgradeParamsData:UpgradeParamsData = new UpgradeParamsData();
            upgradeParamsData.properties = garageProperties;
            this.upgradeParamsModel.putInitParams(new UpgradeParamsCC(0,upgradeParamsData));

            this.countableItemModel.putInitParams(new CountableItemCC(item.count == null ? -1 : int(item.count)));
            this.object3dsModel2.putInitParams(new Object3DSCC(Long.getLong(0,item.object3ds)));
            this.coloringModel.putInitParams(new ColoringCC(null,ImageResource(resourceRegistry.getResource(Long.getLong(0,item.coloring)))));
            this.temporaryItemModel.putInitParams(new TemporaryItemCC(0,item.remainingTimeInSec > 0 ? item.remainingTimeInSec : 0));
            this.discountModel.putInitParams(new DiscountCC(item.discount.percent,item.discount.timeLeftInSeconds,0));
            //if(EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.GIVEN_PRESENT)
            //{
            //   this.presentItemModel.putInitParams(new PresentItemCC(item.present.date,ImageResource(resourceRegistry.getResource(Long.getLong(0,item.present.image))),item.present.presenter,item.present.text,item.present.presentId));
            //}
            //this.rentModel.putInitParams(new RentItemCC(item.isForRent));
            this.discountModel.objectLoadedPost();
            this.countableItemModel.objectLoaded();
            this.temporaryItemModel.objectLoaded();
            //this.upgradeParamsModel.objectLoadedPost();
            Model.popObject();
            if(EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.GIVEN_PRESENT)
            {
               presentItems[presentItems.length] = gameObject;
            }
            else
            {
               depotItems[depotItems.length] = gameObject;
            }
         }
         this.itemCategoryModel.putInitParams(new GarageModelCC(Tanks3DSResource(newname_122__END.getResource(Long.getLong(0,parsedJson.garageBoxId))))));
         //this.itemCategoryModel.objectLoaded();
         this.itemCategoryModel.initDepot(depotItems);
         this.itemCategoryModel.initPresents(presentItems);
      }
      
      private function loadPurchasableItems(param1:LoadPurchasableItemsInPacket) : void
      {
         var _loc12_:* = undefined;
         var _loc14_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc6_:* = undefined;
         var _loc3_:IGameObject = null;
         var _loc13_:* = 0;
         var _loc8_:Object = JSON.parse(param1.battlesJson);
         var _loc7_:Vector.<IGameObject> = new Vector.<IGameObject>();
         for each(var _loc4_ in _loc8_.items)
         {
            _loc12_ = new Vector.<ItemGaragePropertyData>();
            _loc14_ = new Vector.<GaragePropertyData>();
            _loc10_ = new Vector.<PropertyData>();
            _loc11_ = new Vector.<KitItem>();
            if(EnumUtils.newname_6575__END(_loc4_.type) == ItemCategoryEnum.KIT)
            {
               for each(var _loc2_ in _loc4_.kit.kitItems)
               {
                  _loc11_.push(new KitItem(_loc2_.count,this.garageSpace.getObjectByName(_loc2_.id),false));
               }
            }
            for each(var _loc9_ in _loc4_.properts)
            {
               _loc6_ = new Vector.<PropertyData>();
               _loc12_.push(new ItemGaragePropertyData(EnumUtils.stringToItemGarageProperty(_loc9_.property),_loc9_.value));
               if(_loc9_.subproperties != null)
               {
                  for each(var _loc5_ in _loc9_.subproperties)
                  {
                     _loc6_.push(new PropertyData(_loc5_.value,_loc5_.value,EnumUtils.stringToItemProperty(_loc5_.property)));
                  }
               }
               else
               {
                  _loc6_.push(new PropertyData(_loc9_.value,_loc9_.value,EnumUtils.stringToItemProperty(_loc9_.property)));
               }
               _loc14_.push(new GaragePropertyData(new LinearParams(_loc9_.value,_loc9_.value),0,0,25,_loc6_,EnumUtils.stringToItemGarageProperty(_loc9_.property),0,0,new LinearParams(_loc9_.value,_loc9_.value)));
            }
            _loc3_ = this.garageSpace.createObject(Long.getLong(0,_loc4_.previewResourceId),_loc4_.id == "rename" ? this.newname_6559__END : this.itemGameClass,_loc4_.id + "_m" + (_loc4_.modificationID == undefined ? "0" : _loc4_.modificationID));
            Model.object = _loc3_;
            this.itemModel.putInitParams(new ItemModelCC(30,_loc4_.rank,_loc4_.index,ImageResource(newname_122__END.getResource(Long.getLong(0,_loc4_.previewResourceId)))));
            this.itemViewCategoryModel.putInitParams(new ItemViewCategoryCC(EnumUtils.stringToItemViewCategoryEnum(_loc4_.category)));
            this.itemCategoryModel2.putInitParams(new ItemCategoryCC(EnumUtils.newname_6575__END(_loc4_.type)));
            this.descriptionModel.putInitParams(new DescriptionModelCC(_loc4_.description,_loc4_.name));
            this.buyableModel.putInitParams(new BuyableCC(true,_loc4_.price));
            this.modificationModel.putInitParams(new ModificationCC(Long.getLong(0,_loc4_.baseItemId),_loc4_.modificationID == null ? -1 : int(_loc4_.modificationID)));
            this.object3dsModel.putInitParams(new ItemPropertiesCC(_loc12_));
            this.upgradeParamsModel.putInitParams(new UpgradableParamsCC(null,_loc14_));
            this.countableItemModel.putInitParams(new CountableItemCC(EnumUtils.newname_6575__END(_loc4_.type) == ItemCategoryEnum.INVENTORY ? 0 : -1));
            this.object3dsModel2.putInitParams(new Object3DSCC(Long.getLong(0,_loc4_.object3ds)));
            this.coloringModel.putInitParams(new ColoringCC(null,ImageResource(newname_122__END.getResource(Long.getLong(0,_loc4_.coloring)))));
            _loc13_ = Math.max(0,_loc4_.remainingTimeInSec);
            this.temporaryItemModel.putInitParams(new TemporaryItemCC(_loc13_,_loc13_));
            this.discountModel.putInitParams(new DiscountCC(_loc4_.discount.percent,_loc4_.discount.timeLeftInSeconds,_loc4_.discount.timeToStartInSeconds));
            this.groupedItemModel.putInitParams(new GroupedCC(_loc4_.grouped));
            this.rentModel.putInitParams(new RentItemCC(_loc4_.isForRent));
            this.discountModel.objectLoadedPost();
            if(_loc4_.id == "rename")
            {
               this.renameModel.objectLoaded();
            }
            else if(EnumUtils.newname_6575__END(_loc4_.type) == ItemCategoryEnum.KIT)
            {
               this.garageKitModel.putInitParams(new GarageKitCC(_loc4_.kit.discountInPercent,ImageResource(newname_122__END.getResource(Long.getLong(0,_loc4_.kit.image))),_loc11_));
               this.timePeriodModel.putInitParams(new TimePeriodModelCC(true,_loc4_.kit.isTimeless,_loc4_.kit.timeLeftInSeconds,10));
               this.timePeriodModel.objectLoaded();
            }
            this.countableItemModel.objectLoaded();
            this.upgradeParamsModel.objectLoadedPost();
            _loc7_[_loc7_.length] = _loc3_;
            Model.popObject();
         }
         var _loc26_:* = this.newname_6561__END = this.garageSpace.createObject(newname_6522__END.newname_6577__END(),this.itemGameClass,"garageObject");
         Model.object = _loc26_;
         this.discountForUpgradeModel.putInitParams(new DelayMountCategoryCC(_loc8_.delayMountArmorInSec,_loc8_.delayMountColorInSec,_loc8_.delayMountWeaponInSec));
         this.discountForUpgradeModel.objectLoadedPost();
         this.itemCategoryModel.initMarket(_loc7_);
         this.itemCategoryModel.selectFirstItemInDepot();
         this.achievementService.setPanelPartition(1);
         Model.popObject();
      }
      
      private function unloadGarageSpace() : void
      {
         var _loc2_:IGameObject = null;
         var _loc3_:IGameObject = null;
         this.itemCategoryModel.objectUnloaded();
         var _loc1_:Vector.<IGameObject> = new Vector.<IGameObject>();
         for each(_loc2_ in this.garageSpace.objects)
         {
            _loc1_.push(_loc2_);
         }
         for each(_loc3_ in _loc1_)
         {
            this.garageSpace.destroyObject(_loc3_.id);
         }
      }
      
      private function initMounted(param1:CheckItemMountedInPacket) : void
      {
         var _loc2_:Vector.<IGameObject> = new Vector.<IGameObject>();
         var _loc3_:IGameObject = this.garageSpace.getObjectByName(param1.itemId);
         _loc2_.push(_loc3_);
         Model.object = _loc3_;
         this.itemModel2.putInitParams(new Item3DCC(param1.mounted));
         this.itemModel2.objectLoaded();
         Model.popObject();
         if(param1.mounted)
         {
            this.itemCategoryModel.initMounted(_loc2_);
         }
      }
      
      private function renameFail() : void
      {
         this.renameModel.renameFail();
      }
      
      private function renameSuccessfull(param1:RenameSuccessfulInPacket) : void
      {
         this.renameModel.renameSuccessfull(param1.newName,param1.userId);
      }
      
      private function selectFirstItemInDepot() : void
      {
         this.itemCategoryModel.selectFirstItemInDepot();
      }
      
      private function selectItem(param1:SelectItemInPacket) : void
      {
         var _loc2_:IGameObject = this.garageSpace.getObjectByName(param1.itemId);
         this.itemCategoryModel.select(_loc2_);
      }
      
      private function showCategory(param1:ShowGarageCategoryInPacket) : void
      {
         this.itemCategoryModel.showCategory(EnumUtils.stringToItemViewCategoryEnum(param1.categoryId));
      }
      
      private function showAlert() : void
      {
         this.newPresentsShowingModel.showAlert();
      }
   }
}

