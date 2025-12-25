package scpacker.networking.protocol.codec.custom
{
   import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMineCC;
   import projects.tanks.client.battlefield.models.battle.battlefield.mine.BattleMine;
   import flash.utils.ByteArray;
   import scpacker.networking.protocol.ProtocolInitializer;
   import platform.client.fp10.core.resource.types.ImageResource;
   import platform.client.fp10.core.resource.types.MultiframeImageResource;
   import platform.client.fp10.core.resource.types.SoundResource;
   import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
   import scpacker.networking.protocol.codec.ICodec;
   
   public class CodecBattleMineCC implements ICodec
   {
      public const optionalVector:Boolean = false;
      
      public const element:Class = BattleMineCC;
      
      private var newname_4467__END:ICodec;
      
      private var newname_4468__END:ICodec;
      
      private var newname_4469__END:ICodec;
      
      private var newname_4470__END:ICodec;
      
      private var newname_4471__END:ICodec;
      
      private var newname_4472__END:ICodec;
      
      private var newname_4473__END:ICodec;
      
      private var newname_4474__END:ICodec;
      
      private var newname_4475__END:ICodec;
      
      private var newname_4476__END:ICodec;
      
      private var newname_4477__END:ICodec;
      
      private var newname_4478__END:ICodec;
      
      private var newname_4479__END:ICodec;
      
      private var newname_4480__END:ICodec;
      
      private var newname_4481__END:ICodec;
      
      private var newname_4482__END:ICodec;
      
      private var newname_4483__END:ICodec;
      
      private var newname_4484__END:ICodec;
      
      public function CodecBattleMineCC(param1:ProtocolInitializer)
      {
         super();
         this.newname_4467__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4468__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.IntCodec");
         this.newname_4469__END = param1.getCodec("scpacker.networking.protocol.codec.custom.VectorCodecBattleMine");
         this.newname_4470__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4471__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4472__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4473__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4474__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4475__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4476__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4477__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4478__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4479__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4480__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4481__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
         this.newname_4482__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4483__END = param1.getCodec("scpacker.networking.protocol.codec.primitive.FloatCodec");
         this.newname_4484__END = param1.getCodec("scpacker.networking.protocol.codec.custom.ResourceGetterCodec");
      }
      
      public function decode(param1:ByteArray) : Object
      {
         var _loc2_:BattleMineCC = new BattleMineCC();
         _loc2_.activateSound = this.newname_4467__END.decode(param1) as SoundResource;
         _loc2_.activateTimeMsec = this.newname_4468__END.decode(param1) as int;
         _loc2_.battleMines = this.newname_4469__END.decode(param1) as Vector.<BattleMine>;
         _loc2_.blueMineTexture = this.newname_4470__END.decode(param1) as ImageResource;
         _loc2_.deactivateSound = this.newname_4471__END.decode(param1) as SoundResource;
         _loc2_.enemyMineTexture = this.newname_4472__END.decode(param1) as ImageResource;
         _loc2_.explosionMarkTexture = this.newname_4473__END.decode(param1) as ImageResource;
         _loc2_.explosionSound = this.newname_4474__END.decode(param1) as SoundResource;
         _loc2_.farVisibilityRadius = this.newname_4475__END.decode(param1) as Number;
         _loc2_.friendlyMineTexture = this.newname_4476__END.decode(param1) as ImageResource;
         _loc2_.idleExplosionTexture = this.newname_4477__END.decode(param1) as MultiframeImageResource;
         _loc2_.impactForce = this.newname_4478__END.decode(param1) as Number;
         _loc2_.mainExplosionTexture = this.newname_4479__END.decode(param1) as MultiframeImageResource;
         _loc2_.minDistanceFromBase = this.newname_4480__END.decode(param1) as Number;
         _loc2_.model3ds = this.newname_4481__END.decode(param1) as Tanks3DSResource;
         _loc2_.nearVisibilityRadius = this.newname_4482__END.decode(param1) as Number;
         _loc2_.radius = this.newname_4483__END.decode(param1) as Number;
         _loc2_.redMineTexture = this.newname_4484__END.decode(param1) as ImageResource;
         return _loc2_;
      }
      
      public function encode(param1:ByteArray, param2:Object) : int
      {
         if(param2 == null)
         {
            throw new Error("Object is null. Use @ProtocolOptional annotation.");
         }
         var _loc3_:BattleMineCC = BattleMineCC(param2);
         this.newname_4467__END.encode(param1,_loc3_.activateSound);
         this.newname_4468__END.encode(param1,_loc3_.activateTimeMsec);
         this.newname_4469__END.encode(param1,_loc3_.battleMines);
         this.newname_4470__END.encode(param1,_loc3_.blueMineTexture);
         this.newname_4471__END.encode(param1,_loc3_.deactivateSound);
         this.newname_4472__END.encode(param1,_loc3_.enemyMineTexture);
         this.newname_4473__END.encode(param1,_loc3_.explosionMarkTexture);
         this.newname_4474__END.encode(param1,_loc3_.explosionSound);
         this.newname_4475__END.encode(param1,_loc3_.farVisibilityRadius);
         this.newname_4476__END.encode(param1,_loc3_.friendlyMineTexture);
         this.newname_4477__END.encode(param1,_loc3_.idleExplosionTexture);
         this.newname_4478__END.encode(param1,_loc3_.impactForce);
         this.newname_4479__END.encode(param1,_loc3_.mainExplosionTexture);
         this.newname_4480__END.encode(param1,_loc3_.minDistanceFromBase);
         this.newname_4481__END.encode(param1,_loc3_.model3ds);
         this.newname_4482__END.encode(param1,_loc3_.nearVisibilityRadius);
         this.newname_4483__END.encode(param1,_loc3_.radius);
         this.newname_4484__END.encode(param1,_loc3_.redMineTexture);
         return 4;
      }
   }
}

