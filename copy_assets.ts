import * as FS from "node:fs";

//? Copy media assets into the build.
["models", "sounds", "schematics", "textures"].forEach((id: string) => {
    FS.cpSync(`source/${id}/${id}`, `mods/${id}/${id}`, { recursive: true });
});

//? Copy the config files.
FS.readdirSync("source/", { recursive: false }).forEach((item: string | Buffer, index: number) => {
    if (item instanceof Buffer) return;
    if (!FS.statSync(`source/${item}`).isDirectory()) return;
    if (!FS.existsSync(`source/${item}/mod.conf`)) throw new Error(`mod ${item} is missing a mod.conf!`);
    console.log(`dir: ${item}`);

});
