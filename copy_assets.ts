import * as FS from "node:fs";

function copyMediaAssets(id: string): void {
    FS.cpSync(`source/${id}/${id}`, `mods/${id}/${id}`, { recursive: true });
}

["sounds", "schematics"].forEach((id: string) => {
    copyMediaAssets(id);
})

