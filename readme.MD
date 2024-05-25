# Forgotten Lands
 A minetest game written in TypeScript because I felt like it.


This be for minetest 5.9.0-dev (or 5.9.0 release) and if you use 5.8.0 anything it'll probably blow up.
---

### How to make this show up in the online content browser

Go here: https://content.minetest.net/help/non_free/

Follow the instructions in ``How can I show non-free packages in the client?``

If you don't like this, don't complain to me.

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

https://content.minetest.net/packages/MysticTempest/refi_textures/

Name: REFI Textures 

Creator: MysticTempest

License: CC-BY-SA-4.0

---

### Sounds

Sound credits are documented in the sounds mod folder.

---

Join my discord to see me ramble like a maniac:
https://discord.gg/7DhNQFP3fv