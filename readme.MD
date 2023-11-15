# Forgotten Lands
 This game has already gone from lua, to teal, and finally TS.

 If you want to mess with this or maybe you would want to use TS for your minetest things.
 
First you need node, if you're on ubuntu it's super outdated so get it here https://github.com/nodesource/distributions#ubuntu-versions

Next you need TypeScriptToLua
```
sudo npm install --save-dev typescript-to-lua typescript
```

Next you need Lua types for TS or else the compiler doesn't know what's going on.
```
sudo npm install --save-dev lua-types
```

(if you want my minetest helper thing)
```
sudo npm install --save-dev minetesthelper 
```