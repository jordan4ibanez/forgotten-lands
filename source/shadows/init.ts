namespace shadows {
  // I stole this: https://github.com/rollerozxa/minetest-enable-shadows/blob/master/init.lua
  // License: MIT
  const defaultIntensity = tonumber(minetest.settings.get("enable_shadows_default_intensity")) || 0.33;

  minetest.register_on_joinplayer((player: ObjectRef, _: string) => {
    player.set_lighting({
      shadows: {
        intensity: defaultIntensity
      }
    });
  });
}