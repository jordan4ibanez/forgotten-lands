-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["79"] = 1,["81"] = 3,["82"] = 4,["83"] = 5,["84"] = 6,["85"] = 7,["86"] = 8,["87"] = 9,["95"] = 1,["96"] = 1,["97"] = 20,["98"] = 26,["99"] = 21,["100"] = 22,["101"] = 23,["102"] = 24,["103"] = 27,["104"] = 26,["105"] = 30,["106"] = 31,["107"] = 32,["108"] = 33,["109"] = 34,["110"] = 35,["111"] = 36,["112"] = 38,["113"] = 39,["114"] = 40,["115"] = 41,["116"] = 42,["117"] = 43,["118"] = 44,["119"] = 45,["120"] = 30,["121"] = 48,["122"] = 49,["123"] = 50,["124"] = 51,["125"] = 52,["126"] = 48,["127"] = 55,["128"] = 56,["129"] = 56,["130"] = 56,["131"] = 56,["132"] = 56,["133"] = 56,["134"] = 56,["135"] = 56,["136"] = 56,["137"] = 57,["138"] = 58,["139"] = 58,["140"] = 59,["141"] = 60,["142"] = 61,["143"] = 62,["144"] = 63,["145"] = 64,["147"] = 66,["148"] = 67,["150"] = 69,["151"] = 70,["152"] = 71,["153"] = 72,["154"] = 73,["155"] = 55,["156"] = 77,["157"] = 78,["158"] = 79,["159"] = 80,["160"] = 77});
utility = utility or ({})
do
    local sin = math.sin
    local cosFromSin = math.cosFromSin
    local fma = math.fma
    local abs = math.abs
    local atan2 = math.atan2
    local invsqrt = math.invsqrt
    local safeAsin = math.safeAsin
    --- The only reason this exists is to smoothly interpolate euler rotation.
    -- Anything else is just a bonus.
    -- 
    -- This is translated from D from Java into Typescript.
    -- https://github.com/jordan4ibanez/doml/blob/main/source/doml/quaternion_d.d
    -- 
    -- This also tends to mutate in place to reduce garbage collector pressure.
    utility.Quaternion = __TS__Class()
    local Quaternion = utility.Quaternion
    Quaternion.name = "Quaternion"
    function Quaternion.prototype.____constructor(self, vec)
        self.x = 0
        self.y = 0
        self.z = 0
        self.w = 1
        self:fromVec(vec)
    end
    function Quaternion.prototype.fromVec(self, vec)
        local sx = sin(vec.x * 0.5)
        local cx = cosFromSin(sx, vec.x * 0.5)
        local sy = sin(vec.y * 0.5)
        local cy = cosFromSin(sy, vec.y * 0.5)
        local sz = sin(vec.z * 0.5)
        local cz = cosFromSin(sz, vec.z * 0.5)
        local cycz = cy * cz
        local sysz = sy * sz
        local sycz = sy * cz
        local cysz = cy * sz
        self.w = cx * cycz - sx * sysz
        self.x = sx * cycz + cx * sysz
        self.y = cx * sycz - sx * cysz
        self.z = cx * cysz + sx * sycz
    end
    function Quaternion.prototype.identity(self)
        self.x = 0
        self.y = 0
        self.z = 0
        self.w = 0
    end
    function Quaternion.prototype.slerp(self, target, alpha, mutation)
        local cosom = fma(
            self.x,
            target.x,
            fma(
                self.y,
                target.y,
                fma(self.z, target.z, self.w * target.w)
            )
        )
        local absCosom = abs(cosom)
        local scale0
        local scale1
        if 1 - absCosom > 0.000001 then
            local sinSqr = 1 - absCosom * absCosom
            local sinom = invsqrt(sinSqr)
            local omega = atan2(sinSqr * sinom, absCosom)
            scale0 = sin((1 - alpha) * omega) * sinom
            scale1 = sin(alpha * omega) * sinom
        else
            scale0 = 1 - alpha
            scale1 = alpha
        end
        scale1 = cosom >= 0 and scale1 or -scale1
        mutation.x = fma(scale0, self.x, scale1 * target.x)
        mutation.y = fma(scale0, self.y, scale1 * target.y)
        mutation.z = fma(scale0, self.z, scale1 * target.z)
        mutation.w = fma(scale0, self.w, scale1 * target.w)
    end
    function Quaternion.prototype.toVec3(self, mutation)
        mutation.x = atan2(self.x * self.w - self.y * self.z, 0.5 - self.x * self.x - self.y * self.y)
        mutation.y = safeAsin(2 * (self.x * self.z + self.y * self.w))
        mutation.z = atan2(self.z * self.w - self.x * self.y, 0.5 - self.y * self.y - self.z * self.z)
    end
end
