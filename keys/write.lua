JSON = (loadfile "JSON.lua")() -- one-time load of the routines

local function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local dump = readAll("hf-mf-87E83912-dump.json")
local data = JSON:decode(dump)
local outString =""
local sectorExemptList = {0}
for sectorIndex = 0, 15 do
    if not has_value(sectorExemptList, sectorIndex) then
        for blockIndex = 0, 3 do
            local index = blockIndex + sectorIndex * 4
            outString = outString .. "hf mf wrbl --blk ".. index .." -k " .. data["SectorKeys"][tostring(0)]["KeyA"] .." -d ".. data['blocks'][tostring(index)] .. "\n"
        end
    end
   
end
local of = io.open("out.txt", "w")
of:write(outString)
of:close()