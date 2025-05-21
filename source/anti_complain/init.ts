// Stop minetest from COMPLAINING ABOUT EVERYTHING!
core.global_exists = (name: string): boolean => {
    return true;
};
// This probably won't blow everything up, maybe.
setmetatable(_G, {});