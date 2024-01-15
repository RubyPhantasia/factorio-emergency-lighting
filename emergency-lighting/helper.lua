-- Functions
local function copy_prototype(type, internal_name)
    return table.deepcopy(data.raw[type][internal_name])
end

local export = {
    copy_prototype = copy_prototype
}

return export