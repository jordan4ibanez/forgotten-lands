-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
        dispose = __TS__Symbol("Symbol.dispose"),
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
end

local Map
do
    Map = __TS__Class()
    Map.name = "Map"
    function Map.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "Map"
        self.items = {}
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[1], value[2])
            end
        else
            local array = entries
            for ____, kvp in ipairs(array) do
                self:set(kvp[1], kvp[2])
            end
        end
    end
    function Map.prototype.clear(self)
        self.items = {}
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Map.prototype.delete(self, key)
        local contains = self:has(key)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[key]
            local previous = self.previousKey[key]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[key] = nil
            self.previousKey[key] = nil
        end
        self.items[key] = nil
        return contains
    end
    function Map.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, self.items[key], key, self)
        end
    end
    function Map.prototype.get(self, key)
        return self.items[key]
    end
    function Map.prototype.has(self, key)
        return self.nextKey[key] ~= nil or self.lastKey == key
    end
    function Map.prototype.set(self, key, value)
        local isNewValue = not self:has(key)
        if isNewValue then
            self.size = self.size + 1
        end
        self.items[key] = value
        if self.firstKey == nil then
            self.firstKey = key
            self.lastKey = key
        elseif isNewValue then
            self.nextKey[self.lastKey] = key
            self.previousKey[key] = self.lastKey
            self.lastKey = key
        end
        return self
    end
    Map.prototype[Symbol.iterator] = function(self)
        return self:entries()
    end
    function Map.prototype.entries(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, items[key]}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.values(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = items[key]}
                key = nextKey[key]
                return result
            end
        }
    end
    Map[Symbol.species] = Map
end

local Set
do
    Set = __TS__Class()
    Set.name = "Set"
    function Set.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "Set"
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self:add(result.value)
            end
        else
            local array = values
            for ____, value in ipairs(array) do
                self:add(value)
            end
        end
    end
    function Set.prototype.add(self, value)
        local isNewValue = not self:has(value)
        if isNewValue then
            self.size = self.size + 1
        end
        if self.firstKey == nil then
            self.firstKey = value
            self.lastKey = value
        elseif isNewValue then
            self.nextKey[self.lastKey] = value
            self.previousKey[value] = self.lastKey
            self.lastKey = value
        end
        return self
    end
    function Set.prototype.clear(self)
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Set.prototype.delete(self, value)
        local contains = self:has(value)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[value]
            local previous = self.previousKey[value]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[value] = nil
            self.previousKey[value] = nil
        end
        return contains
    end
    function Set.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, key, key, self)
        end
    end
    function Set.prototype.has(self, value)
        return self.nextKey[value] ~= nil or self.lastKey == value
    end
    Set.prototype[Symbol.iterator] = function(self)
        return self:values()
    end
    function Set.prototype.entries(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, key}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.values(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    Set[Symbol.species] = Set
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local __TS__Match = string.match

local function __TS__SourceMapTraceBack(fileName, sourceMap)
    _G.__TS__sourcemap = _G.__TS__sourcemap or ({})
    _G.__TS__sourcemap[fileName] = sourceMap
    if _G.__TS__originalTraceback == nil then
        local originalTraceback = debug.traceback
        _G.__TS__originalTraceback = originalTraceback
        debug.traceback = function(thread, message, level)
            local trace
            if thread == nil and message == nil and level == nil then
                trace = originalTraceback()
            elseif __TS__StringIncludes(_VERSION, "Lua 5.0") then
                trace = originalTraceback((("[Level " .. tostring(level)) .. "] ") .. tostring(message))
            else
                trace = originalTraceback(thread, message, level)
            end
            if type(trace) ~= "string" then
                return trace
            end
            local function replacer(____, file, srcFile, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (srcFile .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            local result = string.gsub(
                trace,
                "(%S+)%.lua:(%d+)",
                function(file, line) return replacer(nil, file .. ".lua", file .. ".ts", line) end
            )
            local function stringReplacer(____, file, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local chunkName = (__TS__Match(file, "%[string \"([^\"]+)\"%]"))
                    local sourceName = string.gsub(chunkName, ".lua$", ".ts")
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (sourceName .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            result = string.gsub(
                result,
                "(%[string \"[^\"]+\"%]):(%d+)",
                function(file, line) return stringReplacer(nil, file, line) end
            )
            return result
        end
    end
end
-- End of Lua Library inline imports
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["416"] = 1,["418"] = 3,["419"] = 4,["420"] = 5,["422"] = 1,["423"] = 1,["424"] = 10,["426"] = 11,["427"] = 12,["428"] = 12,["429"] = 12,["430"] = 12,["431"] = 11,["432"] = 17,["433"] = 17,["434"] = 17,["435"] = 17,["436"] = 11,["437"] = 22,["438"] = 22,["439"] = 22,["440"] = 22,["441"] = 11,["442"] = 11,["443"] = 10,["444"] = 29,["445"] = 30,["446"] = 31,["447"] = 32,["448"] = 33,["450"] = 35,["451"] = 36,["452"] = 37,["453"] = 38,["455"] = 40,["456"] = 41,["457"] = 42,["458"] = 43,["460"] = 29,["461"] = 47,["462"] = 48,["463"] = 49,["465"] = 51,["466"] = 52,["467"] = 53,["468"] = 47,["469"] = 55,["470"] = 56,["471"] = 57,["473"] = 59,["474"] = 60,["475"] = 61,["476"] = 55,["477"] = 63,["478"] = 64,["479"] = 65,["481"] = 67,["482"] = 68,["483"] = 69,["484"] = 63,["486"] = 87,["487"] = 87,["489"] = 88,["490"] = 89,["491"] = 90,["492"] = 87,["493"] = 95,["494"] = 96,["495"] = 97,["496"] = 98,["497"] = 99,["498"] = 100,["499"] = 101,["500"] = 102,["501"] = 103,["502"] = 104,["503"] = 95,["504"] = 110,["505"] = 111,["506"] = 112,["507"] = 113,["508"] = 114,["509"] = 115,["510"] = 116,["511"] = 117,["512"] = 118,["513"] = 119,["514"] = 110,["515"] = 154,["516"] = 155,["517"] = 157,["518"] = 157,["519"] = 157,["520"] = 157,["521"] = 158,["522"] = 158,["523"] = 158,["524"] = 158,["525"] = 159,["526"] = 159,["527"] = 159,["528"] = 159,["529"] = 160,["530"] = 1,["532"] = 1,["533"] = 1,["534"] = 167,["536"] = 171,["537"] = 175,["538"] = 167,["539"] = 177,["540"] = 179,["541"] = 180,["542"] = 180,["543"] = 180,["544"] = 180,["546"] = 185,["547"] = 187,["548"] = 188,["550"] = 191,["551"] = 177,["552"] = 194,["553"] = 195,["554"] = 196,["556"] = 198,["557"] = 194,["558"] = 201,["559"] = 202,["560"] = 203,["561"] = 204,["562"] = 205,["565"] = 208,["567"] = 210,["568"] = 211,["569"] = 212,["571"] = 214,["572"] = 215,["573"] = 216,["575"] = 218,["576"] = 219,["577"] = 220,["579"] = 222,["580"] = 223,["581"] = 224,["582"] = 225,["583"] = 201,["584"] = 228,["585"] = 229,["586"] = 230,["587"] = 231,["588"] = 232,["591"] = 235,["593"] = 237,["594"] = 238,["595"] = 239,["597"] = 241,["598"] = 242,["599"] = 243,["601"] = 245,["602"] = 246,["603"] = 247,["605"] = 249,["606"] = 250,["607"] = 251,["608"] = 252,["609"] = 228,["610"] = 258,["611"] = 260,["612"] = 261,["613"] = 269,["614"] = 270,["615"] = 271,["616"] = 272,["617"] = 274,["618"] = 278,["619"] = 258});
animationStation = animationStation or ({})
do
    local create3d = vector.create3d
    local Quaternion = utility.Quaternion
    local tickRate = utility.tickRate
    --- And the final processor, this guy.
    animationStation.BoneOverrideWorker = __TS__Class()
    local BoneOverrideWorker = animationStation.BoneOverrideWorker
    BoneOverrideWorker.name = "BoneOverrideWorker"
    function BoneOverrideWorker.prototype.____constructor(self)
        self.override = {
            position = {
                vec = create3d(0, 0, 0),
                interpolation = tickRate,
                absolute = false
            },
            rotation = {
                vec = create3d(0, 0, 0),
                interpolation = tickRate,
                absolute = false
            },
            scale = {
                vec = create3d(1, 1, 1),
                interpolation = tickRate,
                absolute = true
            }
        }
    end
    function BoneOverrideWorker.prototype.identity(self)
        if self.override.position ~= nil then
            self.override.position.vec.x = 0
            self.override.position.vec.y = 0
            self.override.position.vec.z = 0
        end
        if self.override.rotation ~= nil then
            self.override.rotation.vec.x = 0
            self.override.rotation.vec.y = 0
            self.override.rotation.vec.z = 0
        end
        if self.override.scale ~= nil then
            self.override.scale.vec.x = 1
            self.override.scale.vec.y = 1
            self.override.scale.vec.z = 1
        end
    end
    function BoneOverrideWorker.prototype.setPosition(self, vec)
        if self.override.position == nil then
            error("Position went null in bone override worker.")
        end
        self.override.position.vec.x = vec.x
        self.override.position.vec.y = vec.y
        self.override.position.vec.z = vec.z
    end
    function BoneOverrideWorker.prototype.setRotation(self, vec)
        if self.override.rotation == nil then
            error("Rotation went null in bone override worker.")
        end
        self.override.rotation.vec.x = vec.x
        self.override.rotation.vec.y = vec.y
        self.override.rotation.vec.z = vec.z
    end
    function BoneOverrideWorker.prototype.setScale(self, vec)
        if self.override.scale == nil then
            error("Scale went null in bone override worker.")
        end
        self.override.scale.vec.x = vec.x
        self.override.scale.vec.y = vec.y
        self.override.scale.vec.z = vec.z
    end
    --- Internal keyframe worker container
    local AnimationWorker = __TS__Class()
    AnimationWorker.name = "AnimationWorker"
    function AnimationWorker.prototype.____constructor(self)
        self.translation = vector.create3d(0, 0, 0)
        self.rotation = vector.create3d(0, 0, 0)
        self.scale = vector.create3d(1, 1, 1)
    end
    function AnimationWorker.prototype.identity(self)
        self.translation.x = 0
        self.translation.y = 0
        self.translation.z = 0
        self.rotation.x = 0
        self.rotation.y = 0
        self.rotation.z = 0
        self.scale.x = 1
        self.scale.y = 1
        self.scale.z = 1
    end
    function AnimationWorker.prototype.set(self, trsObject)
        self.translation.x = trsObject.translation.x
        self.translation.y = trsObject.translation.y
        self.translation.z = trsObject.translation.z
        self.rotation.x = trsObject.rotation.x
        self.rotation.y = trsObject.rotation.y
        self.rotation.z = trsObject.rotation.z
        self.scale.x = trsObject.scale.x
        self.scale.y = trsObject.scale.y
        self.scale.z = trsObject.scale.z
    end
    local workerAnimationStart = __TS__New(AnimationWorker)
    local workerAnimationEnd = __TS__New(AnimationWorker)
    local rotationStart = __TS__New(
        Quaternion,
        vector.create3d(0, 0, 0)
    )
    local rotationEnd = __TS__New(
        Quaternion,
        vector.create3d(0, math.pi, 0)
    )
    local outputRotation = __TS__New(
        Quaternion,
        vector.create3d(0, 0, 0)
    )
    local workerVec = vector.create3d(0, 0, 0)
    local outputOverride = __TS__New(animationStation.BoneOverrideWorker)
    --- Holds the Models.
    animationStation.ModelContainer = __TS__Class()
    local ModelContainer = animationStation.ModelContainer
    ModelContainer.name = "ModelContainer"
    function ModelContainer.prototype.____constructor(self)
        self.models = __TS__New(Map)
        self.bones = __TS__New(Map)
    end
    function ModelContainer.prototype.registerAnimation(self, modelName, animationName, definition)
        if not self.models:has(modelName) then
            self.models:set(
                modelName,
                {animations = __TS__New(Map)}
            )
        end
        local container = self.models:get(modelName)
        if container.animations:has(animationName) then
            error(((("Tried to redefine animation [" .. animationName) .. "] for model [") .. modelName) .. "].")
        end
        container.animations:set(animationName, definition)
    end
    function ModelContainer.prototype.registerBones(self, modelName, bones)
        if self.bones:has(modelName) then
            error(("AnimationStation: Tried to redefine bones for model [" .. modelName) .. "].")
        end
        self.bones:set(modelName, bones)
    end
    function ModelContainer.prototype.getStart(self, modelName, animationName, boneName)
        if self.bones:has(modelName) then
            local gotten = self.bones:get(modelName)
            if not gotten:has(boneName) then
                error(((("Model [" .. modelName) .. "] bone [") .. boneName) .. "] is not registered.")
            end
        else
            error(("Model [" .. modelName) .. "] has no registered bones.")
        end
        workerAnimationStart:identity()
        if not self.models:has(modelName) then
            return workerAnimationStart
        end
        local modelContainer = self.models:get(modelName)
        if not modelContainer.animations:has(animationName) then
            return workerAnimationStart
        end
        local animationContainer = modelContainer.animations:get(animationName)
        if not animationContainer:has(boneName) then
            return workerAnimationStart
        end
        local boneContainer = animationContainer:get(boneName)
        local startKeyframe = boneContainer.start
        workerAnimationStart:set(startKeyframe)
        return workerAnimationStart
    end
    function ModelContainer.prototype.getEnd(self, modelName, animationName, boneName)
        if self.bones:has(modelName) then
            local gotten = self.bones:get(modelName)
            if not gotten:has(boneName) then
                error(((("Model [" .. modelName) .. "] bone [") .. boneName) .. "] is not registered.")
            end
        else
            error(("Model [" .. modelName) .. "] has no registered bones.")
        end
        workerAnimationEnd:identity()
        if not self.models:has(modelName) then
            return workerAnimationEnd
        end
        local modelContainer = self.models:get(modelName)
        if not modelContainer.animations:has(animationName) then
            return workerAnimationEnd
        end
        local animationContainer = modelContainer.animations:get(animationName)
        if not animationContainer:has(boneName) then
            return workerAnimationEnd
        end
        local boneContainer = animationContainer:get(boneName)
        local endKeyframe = boneContainer["end"]
        workerAnimationEnd:set(endKeyframe)
        return workerAnimationEnd
    end
    function ModelContainer.prototype.applyBoneAnimation(self, object, animationProgress, modelName, animationName, boneName)
        self:getStart(modelName, animationName, boneName)
        self:getEnd(modelName, animationName, boneName)
        rotationStart:fromVec(workerAnimationStart.rotation)
        rotationEnd:fromVec(workerAnimationEnd.rotation)
        rotationStart:slerp(rotationEnd, animationProgress, outputRotation)
        outputRotation:toVec3(workerVec)
        outputOverride:setRotation(workerVec)
        object:set_bone_override(boneName, outputOverride.override)
    end
end
