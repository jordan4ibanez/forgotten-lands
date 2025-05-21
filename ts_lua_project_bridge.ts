import * as FS from "node:fs";
import * as Exec from "node:child_process";

//? Check if the project should be fully rebuilt.
const fullRebuild: boolean = (() => {
    const args = process.argv.slice(2);
    if (!args) return false;
    if (args.length == 0) return false;
    if (args[0] === "--full-rebuild") return true;
    return false;
})();

//? Remove the mods directory and recompile the entire program.
if (fullRebuild) {
    FS.rmSync("mods/", { recursive: true, force: true });
    Exec.execSync("npx tstl");
}

//? Copy media assets into the build.
["models", "sounds", "schematics", "textures"].forEach((id: string) => {
    FS.cpSync(`source/${id}/${id}`, `mods/${id}/${id}`, { recursive: true });
});

//? Copy the config files.
FS.readdirSync("source/", { recursive: false }).forEach((item: string | Buffer) => {
    // Basic checks to make sure nothing explodes.
    if (item instanceof Buffer) return;
    if (!FS.statSync(`source/${item}`).isDirectory()) return;
    if (!FS.existsSync(`source/${item}/mod.conf`)) throw new Error(`mod ${item} is missing a mod.conf!`);
    // So now, if the folder doesn't exist it needs to be made.
    if (!FS.existsSync(`mods/${item}`)) {
        FS.mkdirSync(`mods/${item}`);
    } else {
        // If a file is accidentally put in the mods folder during testing, this needs manual intervention.
        if (!FS.statSync(`source/${item}`).isDirectory()) throw new Error(`mod ${item} is a file in the mods folder!`);
    }
    FS.copyFileSync(`source/${item}/mod.conf`, `mods/${item}/mod.conf`,);
});
