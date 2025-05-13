// Stop minetest from COMPLAINING ABOUT EVERYTHING!
minetest.global_exists = (name: string): boolean => {
    return true;
};
// This probably won't blow everything up, maybe.
setmetatable(_G, {});