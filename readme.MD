# Forgotten Lands
 A minetest game written in TypeScript because I felt like it.

---

### Using TS with this thing

If you want to mess with this or maybe you would want to use TS for your minetest things.
 
First you need node, if you're on ubuntu it's super outdated so get it here https://github.com/nodesource/distributions#ubuntu-versions

If you don't want to do the following manually, simply run ``install_npm_deps.sh``

Next you need TypeScriptToLua
```
npm install -D typescript-to-lua typescript
```

Next you need Lua types for TS or else the compiler doesn't know what's going on.
```
npm install -D lua-types
```

(if you want my minetest helper thing)
```
npm install -D minetesthelper 
```

I HIGHLY recommend you use ``make``. It automates a BUNCH of things. There's even ``make clean`` to see if everything is working.

No make automation scripts created for windows yet though. It's cause I'm very lazy.

---

### Texture pack:

https://content.minetest.net/packages/Sharpik/sharpnet_textures/

SharpNet Photo Realism 64px

Creator: Sharpik

License: GPL-3.0-only

---

### Sounds

Sound credits are documented in the sounds mod folder. (A hint to the contentdb reviewers)

---

Join my discord to see me ramble like a maniac:
https://discord.gg/7DhNQFP3fv