import * as FS from "node:fs";

//? Copy media assets into the build.
["models", "sounds", "schematics", "textures"].forEach((id: string) => {
    FS.cpSync(`source/${id}/${id}`, `mods/${id}/${id}`, { recursive: true });
})

