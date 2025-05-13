namespace blocks {
    const registerNode = utility.registerNode;
    const blockType = types.BlockType;

    registerNode("waterSource", {
        description: "Water",
        drawtype: Drawtype.liquid,
        waving: 3,
        tiles: [{
            name: "default_water_source_animated.png",
            backface_culling: false,
            animation: {
                type: TileAnimationType.vertical_frames,
                aspect_w: 16,
                aspect_h: 16,
                length: 2,
            }
        },
        {
            name: "default_water_source_animated.png",
            backface_culling: true,
            animation: {
                type: TileAnimationType.vertical_frames,
                aspect_w: 16,
                aspect_h: 16,
                length: 2,
            }
        }],
        use_texture_alpha: TextureAlpha.blend,
        paramtype: ParamType1.light,
        walkable: false,
        pointable: false,
        diggable: false,
        buildable_to: true,
        is_ground_content: false,
        drop: "",
        drowning: 1,
        liquidtype: LiquidType.source,
        liquid_alternative_flowing: "waterFlowing",
        liquid_alternative_source: "waterSource",
        liquid_viscosity: 1,
        post_effect_color: { a: 103, r: 30, g: 60, b: 90 },
        groups: { [blockType.water]: 3, [blockType.liquid]: 3, [blockType.lava_cooling]: 3 },
        sounds: {}
    });

    registerNode("waterFlowing", {
        description: "Flowing water",
        drawtype: Drawtype.flowingliquid,
        waving: 3,
        tiles: ["default_water.png"],
        special_tiles: [{
            name: "default_water_flowing_animated.png",
            backface_culling: false,
            animation: {
                type: TileAnimationType.vertical_frames,
                aspect_w: 16,
                aspect_h: 16,
                length: 2,
            }
        },
        {
            name: "default_water_flowing_animated.png",
            backface_culling: true,
            animation: {
                type: TileAnimationType.vertical_frames,
                aspect_w: 16,
                aspect_h: 16,
                length: 2
            }
        }],
        use_texture_alpha: TextureAlpha.blend,
        paramtype: ParamType1.light,
        paramtype2: ParamType2.flowingliquid,
        walkable: false,
        pointable: false,
        diggable: false,
        buildable_to: true,
        is_ground_content: false,
        drop: "",
        liquidtype: LiquidType.flowing,
        liquid_alternative_flowing: "waterFlowing",
        liquid_alternative_source: "waterSource",
        liquid_viscosity: 1,
        post_effect_color: { a: 103, r: 30, g: 60, b: 90 },
        groups: { [blockType.water]: 3, [blockType.liquid]: 3, [blockType.lava_cooling]: 3 },
        sounds: {}

    });


}