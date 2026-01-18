package scpacker.networking.protocol.packets.garage
{
   import scpacker.networking.protocol.AbstractPacketHandler;
   import alternativa.tanks.model.item.present.PresentItemModel;
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
   import projects.tanks.client.garage.models.item.upgradeable.types.PropertyData;
   import alternativa.types.Long;
   import projects.tanks.client.garage.models.item.modification.ModificationCC;
   import projects.tanks.client.garage.models.item.item.ItemModelCC;
   import alternativa.model.description.DescriptionModel;
   import projects.tanks.client.garage.models.item.delaymount.DelayMountCategoryCC;
   import alternativa.tanks.model.item.countable.CountableItemModel;
   import projects.tanks.client.garage.models.item.item3d.Item3DCC;
   import alternativa.tanks.model.item.item.ItemModel;
   import projects.tanks.client.garage.models.item.kit.GarageKitCC;
   import projects.tanks.client.garage.models.item.kit.KitItem;
   import projects.tanks.client.garage.models.item.present.PresentItemCC;
   import alternativa.tanks.model.item.discount.DiscountForUpgradeModel;
   import projects.tanks.client.garage.models.item.temporary.TemporaryItemCC;
   import alternativa.osgi.OSGi;
   import alternativa.tanks.service.achievement.IAchievementService;
   import scpacker.utils.EnumUtils;
   import alternativa.tanks.model.item.grouped.GroupedItemModel;
   import alternativa.tanks.model.item.fitting.ItemFittingModel;
   import alternativa.tanks.model.garage.present.PresentGivenModel;
   import alternativa.tanks.model.garage.present.PresentPurchaseModel;
   import alternativa.tanks.model.item.temporary.TemporaryItemModel;
   import scpacker.networking.protocol.AbstractPacket;
   import projects.tanks.clients.flash.commons.models.coloring.ColoringModel;
   import projects.tanks.client.garage.models.item.grouped.GroupedCC;
   import projects.tanks.client.garage.models.item.category.ItemCategoryCC;
   import platform.client.fp10.core.model.impl.*;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.type.IGameObject;
   import platform.client.fp10.core.type.IGameClass;
   import projects.tanks.client.commons.types.ItemCategoryEnum;
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
   import projects.tanks.client.garage.models.garage.GarageModelCC;
   import alternativa.tanks.model.garage.upgrade.UpgradeGarageItemModel;
   import projects.tanks.client.garage.models.garage.upgrade.UpgradeGarageItemModelBase;
   import scpacker.utils.IdTool;
   import alternativa.tanks.model.item3d.Item3DModel;
   import projects.tanks.clients.flash.commons.models.detach.DetachModel;
   import projects.tanks.client.commons.models.detach.DetachModelBase;
   import alternativa.tanks.model.item.properties.ItemPropertiesModel;
   import projects.tanks.client.garage.models.item.properties.ItemPropertiesModelBase;
   import alternativa.tanks.model.item.delaymountcategory.DelayMountCategoryModel;
   import projects.tanks.client.garage.models.item.delaymount.DelayMountCategoryModelBase;
   
   public class GaragePacketHandler extends AbstractPacketHandler
   {
      private var itemModel:ItemModel;
      private var itemCategoryModel:ItemCategoryModel;
      private var itemViewCategoryModel:ItemViewCategoryModel;
      private var descriptionModel:DescriptionModel;
      private var buyableModel:BuyableModel;
      private var modificationModel:ModificationModel;
      private var object3dsModel:Object3DSModel;
      private var upgradeParamsModel:UpgradeParamsModel;
      private var countableItemModel:CountableItemModel;
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
      private var item3dModel:Item3DModel;
      private var newPresentsShowingModel:NewPresentsShowingModel;
      private var groupedItemModel:GroupedItemModel;
      private var upgradeGarageItemModel:UpgradeGarageItemModel;
      //private var rentModel:RentModel;
      private var renameModel:RenameModel;
      private var garageModel:GarageModel;
      private var detachModel:DetachModel;
      private var itemPropertiesModel:ItemPropertiesModel;
      private var delayMountCategoryModel:DelayMountCategoryModel;
   
      private var achievementService:IAchievementService;

      private var temporaryItemGameClass:IGameClass;
      private var _3dsItemGameClass:IGameClass;
      private var coloringItemGameClass:IGameClass;
      private var countableItemGameClass:IGameClass;
      private var presentItemGameClass:IGameClass;
      private var renameItemGameClass:IGameClass;
      private var kitItemGameClass:IGameClass;
      private var garageGameObject:IGameObject;
      private var garageGameClass:IGameClass;

      private var garageSpace:ISpace;

      public function GaragePacketHandler()
      {
         super();
         this.id = 34;
         this.itemModel = ItemModel(modelRegistry.getModel(ItemModelBase.modelId));
         this.itemCategoryModel = ItemCategoryModel(modelRegistry.getModel(ItemCategoryModelBase.modelId));
         this.itemViewCategoryModel = ItemViewCategoryModel(modelRegistry.getModel(ItemViewCategoryModelBase.modelId));
         this.descriptionModel = DescriptionModel(modelRegistry.getModel(DescriptionModelBase.modelId));
         this.buyableModel = BuyableModel(modelRegistry.getModel(BuyableModelBase.modelId));
         this.modificationModel = ModificationModel(modelRegistry.getModel(ModificationModelBase.modelId));
         this.object3dsModel = Object3DSModel(modelRegistry.getModel(Object3DSModelBase.modelId));
         this.upgradeParamsModel = UpgradeParamsModel(modelRegistry.getModel(UpgradeableParamsConstructorModelBase.modelId));
         this.countableItemModel = CountableItemModel(modelRegistry.getModel(CountableItemModelBase.modelId));
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
         this.item3dModel = Item3DModel(modelRegistry.getModel(Item3DModelBase.modelId));
         this.newPresentsShowingModel = NewPresentsShowingModel(modelRegistry.getModel(NewPresentsShowingModelBase.modelId));
         this.groupedItemModel = GroupedItemModel(modelRegistry.getModel(GroupedItemModelBase.modelId));
         this.upgradeGarageItemModel = UpgradeGarageItemModel(modelRegistry.getModel(UpgradeGarageItemModelBase.modelId));
         this.detachModel = DetachModel(modelRegistry.getModel(DetachModelBase.modelId));
         //this.rentModel = RentModel(modelRegistry.getModel(Long.getLong(253893127,1551357191)));
         this.renameModel = RenameModel(modelRegistry.getModel(RenameModelBase.modelId));
         this.garageModel = GarageModel(modelRegistry.getModel(GarageModelBase.modelId));
         this.itemPropertiesModel = ItemPropertiesModel(modelRegistry.getModel(ItemPropertiesModelBase.modelId));
         this.delayMountCategoryModel = DelayMountCategoryModel(modelRegistry.getModel(DelayMountCategoryModelBase.modelId));

         this.garageSpace = ISpace(spaceRegistry.getSpace(Long.getLong(884380667,214)));

         var garageGameClassVector:Vector.<Long> = new Vector.<Long>();
         garageGameClassVector.push(this.garageModel.id);
         garageGameClassVector.push(this.upgradeGarageItemModel.id);
         garageGameClassVector.push(this.presentPurchaseModel.id);
         garageGameClassVector.push(this.delayMountCategoryModel.id);
         this.garageGameClass = gameTypeRegistry.createClass(Long.getLong(15025,68455646),garageGameClassVector);
         this.garageGameObject = null;

         var temporaryItemModelVector:Vector.<Long> = new Vector.<Long>();
         temporaryItemModelVector.push(this.temporaryItemModel.id);
         temporaryItemModelVector.push(this.itemModel.id);
         temporaryItemModelVector.push(this.discountModel.id);
         temporaryItemModelVector.push(this.buyableModel.id);
         temporaryItemModelVector.push(this.timePeriodModel.id);
         temporaryItemModelVector.push(this.descriptionModel.id);
         temporaryItemModelVector.push(this.itemCategoryModel.id);
         temporaryItemModelVector.push(this.discountCollectorModel.id);
         temporaryItemModelVector.push(this.itemViewCategoryModel.id);
         this.temporaryItemGameClass = gameTypeRegistry.createClass(Long.getLong(15725,684360),temporaryItemModelVector);

         var _3dItemModelVector:Vector.<Long> = new Vector.<Long>();
         _3dItemModelVector.push(this.itemModel.id);
         _3dItemModelVector.push(this.groupedItemModel.id);
         _3dItemModelVector.push(this.itemFittingModel.id);
         _3dItemModelVector.push(this.discountModel.id);
         _3dItemModelVector.push(this.buyableModel.id);
         _3dItemModelVector.push(this.descriptionModel.id);
         _3dItemModelVector.push(this.itemCategoryModel.id);
         _3dItemModelVector.push(this.discountCollectorModel.id);
         _3dItemModelVector.push(this.itemViewCategoryModel.id);
         _3dItemModelVector.push(this.item3dModel.id);
         _3dItemModelVector.push(this.object3dsModel.id);
         _3dItemModelVector.push(this.detachModel.id);
         _3dItemModelVector.push(this.timePeriodModel.id);
         _3dItemModelVector.push(this.upgradeParamsModel .id);
         _3dItemModelVector.push(this.modificationModel .id);
         this._3dsItemGameClass = gameTypeRegistry.createClass(Long.getLong(14725,684360),_3dItemModelVector);

         var coloringItemModelVector:Vector.<Long> = new Vector.<Long>();
         coloringItemModelVector.push(this.itemModel.id);
         coloringItemModelVector.push(this.groupedItemModel.id);
         coloringItemModelVector.push(this.itemFittingModel.id);
         coloringItemModelVector.push(this.discountModel.id);
         coloringItemModelVector.push(this.buyableModel.id);
         coloringItemModelVector.push(this.descriptionModel.id);
         coloringItemModelVector.push(this.itemCategoryModel.id);
         coloringItemModelVector.push(this.discountCollectorModel.id);
         coloringItemModelVector.push(this.itemViewCategoryModel.id);
         coloringItemModelVector.push(this.coloringModel.id);
         coloringItemModelVector.push(this.timePeriodModel.id);
         coloringItemModelVector.push(this.item3dModel.id);
         coloringItemModelVector.push(this.detachModel.id);
         coloringItemModelVector.push(this.upgradeParamsModel .id);
         this.coloringItemGameClass = gameTypeRegistry.createClass(Long.getLong(15726,684360),coloringItemModelVector);

         var countableItemModelVector:Vector.<Long> = new Vector.<Long>();
         countableItemModelVector.push(this.itemModel.id);
         countableItemModelVector.push(this.groupedItemModel.id);
         countableItemModelVector.push(this.itemFittingModel.id);
         countableItemModelVector.push(this.discountModel.id);
         countableItemModelVector.push(this.buyableModel.id);
         countableItemModelVector.push(this.descriptionModel.id);
         countableItemModelVector.push(this.itemCategoryModel.id);
         countableItemModelVector.push(this.discountCollectorModel.id);
         countableItemModelVector.push(this.itemViewCategoryModel.id);
         countableItemModelVector.push(this.timePeriodModel.id);
         countableItemModelVector.push(this.countableItemModel.id);
         countableItemModelVector.push(this.upgradeParamsModel .id);
         this.countableItemGameClass = gameTypeRegistry.createClass(Long.getLong(15727,684360),countableItemModelVector);

         var presentItemModelVector:Vector.<Long> = new Vector.<Long>();
         presentItemModelVector.push(this.itemModel.id);
         presentItemModelVector.push(this.discountModel.id);
         presentItemModelVector.push(this.buyableModel.id);
         presentItemModelVector.push(this.descriptionModel.id);
         presentItemModelVector.push(this.itemCategoryModel.id);
         presentItemModelVector.push(this.discountCollectorModel.id);
         presentItemModelVector.push(this.presentItemModel.id);
         presentItemModelVector.push(this.timePeriodModel.id);
         presentItemModelVector.push(this.itemViewCategoryModel.id);
         this.presentItemGameClass = gameTypeRegistry.createClass(Long.getLong(15728,684360),presentItemModelVector);

         var renameItemModelVector:Vector.<Long> = new Vector.<Long>();
         renameItemModelVector.push(this.itemModel.id);
         renameItemModelVector.push(this.countableItemModel.id);
         renameItemModelVector.push(this.itemPropertiesModel.id);
         renameItemModelVector.push(this.discountModel.id);
         renameItemModelVector.push(this.buyableModel.id);
         renameItemModelVector.push(this.descriptionModel.id);
         renameItemModelVector.push(this.itemCategoryModel.id);
         renameItemModelVector.push(this.discountCollectorModel.id);
         renameItemModelVector.push(this.renameModel.id);
         renameItemModelVector.push(this.timePeriodModel.id);
         renameItemModelVector.push(this.itemViewCategoryModel.id);
         this.renameItemGameClass = gameTypeRegistry.createClass(Long.getLong(15730,684360),renameItemModelVector);

         var kitItemModelVector:Vector.<Long> = new Vector.<Long>();
         kitItemModelVector.push(this.itemModel.id);
         kitItemModelVector.push(this.discountModel.id);
         kitItemModelVector.push(this.buyableModel.id);
         kitItemModelVector.push(this.descriptionModel.id);
         kitItemModelVector.push(this.itemCategoryModel.id);
         kitItemModelVector.push(this.discountCollectorModel.id);
         kitItemModelVector.push(this.garageKitModel.id);
         kitItemModelVector.push(this.timePeriodModel.id);
         kitItemModelVector.push(this.itemViewCategoryModel.id);
         this.kitItemGameClass = gameTypeRegistry.createClass(Long.getLong(15731,684360),kitItemModelVector);

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
         this.garageGameObject = this.garageSpace.createObject(Long.getLong(55,4523824),this.garageGameClass,"garage_main_object");
         var itemGarageProperties:Vector.<ItemGaragePropertyData> = null;
         var garageProperties:Vector.<GaragePropertyParams > = null;
         var modificationId:int = 0;
         var gameObject:IGameObject = null;

         var presentItems:Vector.<IGameObject> = new Vector.<IGameObject>();
         var depotItems:Vector.<IGameObject> = new Vector.<IGameObject>();

         var parsedJson:Object = JSON.parse(param1.battlesJson);
         for each(var item in parsedJson.items)
         {
            itemGarageProperties = new Vector.<ItemGaragePropertyData>();
            garageProperties = this.buildGarageProperties(item,itemGarageProperties);
            modificationId = int(item.modificationID);

            var gameClass:IGameClass = this.getGameClassForItem(item);
            gameObject = this.garageSpace.createObject(Long.getLong(0,EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.GIVEN_PRESENT ? int(item.present.date + item.previewResourceId) : int(item.previewResourceId)),gameClass,item.id + "_m" + modificationId);
            
            Model.object = gameObject;
            if(item.price == 8000 && item.index > 10000)
            {
               item.index = 9897;
            }
            this.itemModel.putInitParams(new ItemModelCC(30,item.rank,item.index,ImageResource(resourceRegistry.getResource(Long.getLong(0,item.previewResourceId)))));
            this.itemViewCategoryModel.putInitParams(new ItemViewCategoryCC(EnumUtils.stringToItemViewCategoryEnum(item.category)));
            this.itemCategoryModel.putInitParams(new ItemCategoryCC(EnumUtils.intToItemCategoryEnum(item.type)));
            this.descriptionModel.putInitParams(new DescriptionModelCC(item.description,item.name));
            this.buyableModel.putInitParams(new BuyableCC(true,item.price));
            this.modificationModel.putInitParams(new ModificationCC(Long.getLong(0,item.baseItemId),item.modificationID == null ? -1 : int(item.modificationID)));
            this.itemPropertiesModel.putInitParams(new ItemPropertiesCC(itemGarageProperties));
            
            var upgradeParamsData:UpgradeParamsData = new UpgradeParamsData();
            upgradeParamsData.properties = garageProperties;
            this.upgradeParamsModel.putInitParams(new UpgradeParamsCC(0,upgradeParamsData));

            this.countableItemModel.putInitParams(new CountableItemCC(item.count == null ? -1 : int(item.count)));
            this.object3dsModel.putInitParams(new Object3DSCC(Long.getLong(0,item.object3ds)));
            this.coloringModel.putInitParams(new ColoringCC(null,ImageResource(resourceRegistry.getResource(Long.getLong(0,item.coloring)))));

            if(item.remainingTimeInSec > 0)
            {
               this.temporaryItemModel.putInitParams(new TemporaryItemCC(false,item.remainingTimeInSec,item.remainingTimeInSec));
               this.temporaryItemModel.objectLoaded();
            }

            if(EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.GIVEN_PRESENT)
            {
               this.presentItemModel.putInitParams(new PresentItemCC(item.present.date,ImageResource(resourceRegistry.getResource(Long.getLong(0,item.present.image))),item.present.presenter,item.present.text));
            }
            //this.rentModel.putInitParams(new RentItemCC(item.isForRent));
            //this.discountModel.objectLoadedPost();
            this.countableItemModel.objectLoaded();
            Model.popObject();
            depotItems[depotItems.length] = gameObject;
         }
         
         Model.object = this.garageGameObject;
         var mountableCategorys:Vector.<ItemCategoryEnum> = new Vector.<ItemCategoryEnum>();
         mountableCategorys.push(ItemCategoryEnum.WEAPON);
         mountableCategorys.push(ItemCategoryEnum.ARMOR);
         mountableCategorys.push(ItemCategoryEnum.COLOR);
         this.garageModel.putInitParams(new GarageModelCC(0, -730, 1.5707963267948966, -135, Tanks3DSResource(resourceRegistry.getResource(Long.getLong(0,parsedJson.garageBoxId))), false, mountableCategorys));
         this.garageModel.objectLoaded();
         this.garageModel.initDepot(depotItems);
         //this.garageModel.initPresents(presentItems);
         Model.popObject();
      }

      private function buildGarageProperties(item:Object, itemGarageProperties:Vector.<ItemGaragePropertyData>) : Vector.<GaragePropertyParams>
      {
         var garageProperties:Vector.<GaragePropertyParams > = new Vector.<GaragePropertyParams>();
         var subProperties:Vector.<PropertyData> = null;
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
            garagePropertyParams.properties = subProperties;
            garagePropertyParams.property = EnumUtils.stringToItemGarageProperty(property.property);
            garagePropertyParams.visibleInInfo = true;
            garageProperties.push(garagePropertyParams);
         }
         return garageProperties;
      }
      
      private function loadPurchasableItems(packet:LoadPurchasableItemsInPacket) : void
      {
         var itemPropsForModel:Vector.<ItemGaragePropertyData> = null;
         var propertyValues:Vector.<PropertyData> = null;
         var kitItems:Vector.<KitItem> = null;
         var propertyValueList:Vector.<PropertyData> = null;
         var gameObject:IGameObject = null;
         var remainingTime:int = 0;
         var parsed:Object = JSON.parse(packet.battlesJson);
         var marketItems:Vector.<IGameObject> = new Vector.<IGameObject>();
         for each(var item in parsed.items)
         {
            itemPropsForModel = new Vector.<ItemGaragePropertyData>();
            propertyValues = new Vector.<PropertyData>();
            kitItems = new Vector.<KitItem>();
            if(EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.KIT)
            {
               for each(var kit in item.kit.kitItems)
               {
                  kitItems.push(new KitItem(kit.count,this.garageSpace.getObjectByName(kit.id),false));
               }
            }

            var gameClass:IGameClass = this.getGameClassForItem(item);
            gameObject = this.garageSpace.createObject(Long.getLong(0,item.previewResourceId),gameClass,item.id + "_m" + (item.modificationID == undefined ? "0" : item.modificationID));
            Model.object = gameObject;

            var garagePropertyDataList:Vector.<GaragePropertyParams> = this.buildGarageProperties(item,itemPropsForModel);

            this.itemModel.putInitParams(new ItemModelCC(30,item.rank,item.index,ImageResource(resourceRegistry.getResource(Long.getLong(0,item.previewResourceId)))));
            this.itemViewCategoryModel.putInitParams(new ItemViewCategoryCC(EnumUtils.stringToItemViewCategoryEnum(item.category)));
            this.itemCategoryModel.putInitParams(new ItemCategoryCC(EnumUtils.intToItemCategoryEnum(item.type)));
            this.descriptionModel.putInitParams(new DescriptionModelCC(item.description,item.name));
            this.buyableModel.putInitParams(new BuyableCC(true,item.price));
            this.modificationModel.putInitParams(new ModificationCC(Long.getLong(0,item.baseItemId),item.modificationID == null ? -1 : int(item.modificationID)));
            this.itemPropertiesModel.putInitParams(new ItemPropertiesCC(itemPropsForModel));

            var upgradeParamsData:UpgradeParamsData = new UpgradeParamsData();
            upgradeParamsData.properties = garagePropertyDataList;
            this.upgradeParamsModel.putInitParams(new UpgradeParamsCC(0,upgradeParamsData));

            this.countableItemModel.putInitParams(new CountableItemCC(EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.INVENTORY ? 0 : -1));
            this.object3dsModel.putInitParams(new Object3DSCC(Long.getLong(0,item.object3ds)));
            this.coloringModel.putInitParams(new ColoringCC(null,ImageResource(resourceRegistry.getResource(Long.getLong(0,item.coloring)))));

            remainingTime = Math.max(0,item.remainingTimeInSec);
            this.temporaryItemModel.putInitParams(new TemporaryItemCC(remainingTime,remainingTime));

            this.discountModel.putInitParams(new DiscountCC(item.discount.percent,item.discount.timeLeftInSeconds,item.discount.timeToStartInSeconds));
            this.groupedItemModel.putInitParams(new GroupedCC(item.grouped));
            //this.rentModel.putInitParams(new RentItemCC(item.isForRent));
            this.discountModel.objectLoadedPost();
            if(item.id == "rename")
            {
               this.renameModel.objectLoaded();
            }
            else if(EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.KIT)
            {
               this.garageKitModel.putInitParams(new GarageKitCC(item.kit.discountInPercent,ImageResource(resourceRegistry.getResource(Long.getLong(0,item.kit.image))),kitItems));
               this.timePeriodModel.putInitParams(new TimePeriodModelCC(true,item.kit.isTimeless,item.kit.timeLeftInSeconds,10));
               this.timePeriodModel.objectLoaded();
            }
            this.countableItemModel.objectLoaded();
            //this.upgradeParamsModel.objectLoadedPost();
            marketItems[marketItems.length] = gameObject;
            Model.popObject();
         }
         Model.object = this.garageGameObject;
         this.delayMountCategoryModel.putInitParams(new DelayMountCategoryCC(parsed.delayMountArmorInSec,0,parsed.delayMountColorInSec,parsed.delayMountWeaponInSec));
         this.delayMountCategoryModel.objectLoadedPost();
         this.upgradeGarageItemModel.objectLoaded();
         this.upgradeGarageItemModel.objectLoadedPost();

         this.garageModel.initMarket(marketItems);
         this.garageModel.selectFirstItemInDepot();
         //this.achievementService.setPanelPartition(1);
         Model.popObject();
      }
      
      private function unloadGarageSpace() : void
      {
         Model.object = this.garageGameObject;
         this.garageModel.objectUnloadedPost();
         Model.popObject();

         var _loc2_:IGameObject = null;
         var _loc3_:IGameObject = null;
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

         if(_loc3_.hasModel(Item3DModel))
         {
            Model.object = _loc3_;
            this.item3dModel.putInitParams(new Item3DCC(param1.mounted));
            this.item3dModel.objectLoaded();
            Model.popObject();
         }

         Model.object = this.garageGameObject;
         if(param1.mounted)
         {
            this.garageModel.initMounted(_loc2_);
         }
         Model.popObject();
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
         this.garageModel.selectFirstItemInDepot();
      }
      
      private function selectItem(param1:SelectItemInPacket) : void
      {
         var _loc2_:IGameObject = this.garageSpace.getObjectByName(param1.itemId);
         this.garageModel.select(_loc2_);
      }
      
      private function showCategory(param1:ShowGarageCategoryInPacket) : void
      {
         this.garageModel.showCategory(EnumUtils.stringToItemViewCategoryEnum(param1.categoryId));
      }
      
      private function showAlert() : void
      {
         this.newPresentsShowingModel.showAlert();
      }
      
      private function getGameClassForItem(item:Object) : IGameClass
      {
         if(item.remainingTimeInSec > 0)
         {
            return this.temporaryItemGameClass;
         }
         else if (EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.COLOR)
         {
            return this.coloringItemGameClass;
         }
         else if (
            EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.GIVEN_PRESENT || 
            EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.PRESENT
         )
         {
            return this.presentItemGameClass;
         }
         else if (
            EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.ARMOR || 
            EnumUtils.intToItemCategoryEnum(item.type) == ItemCategoryEnum.WEAPON
         )
         {
            return this._3dsItemGameClass;
         }
         else if (item.inventory || item.count != null)
         {
            return this.countableItemGameClass;
         }
         return this.countableItemGameClass;
      }
   }
}

