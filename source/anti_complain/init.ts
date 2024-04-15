// Stop minetest from COMPLAINING ABOUT EVERYTHING!
minetest.global_exists = (name: string): boolean => {
  return true;
}