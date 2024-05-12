local strutil = require("../util/strutil")

export type PolisherSeparateResult = {
    params: {string},
    flags: {}
}

local polisher = {}
polisher.__index = polisher

function polisher.separate(args: {string}, module) : PolisherSeparateResult
    local params = {}
    local flags = module.flags

    for _,v in pairs(args) do
        if strutil.starts(v, "--") and flags[v:sub(3)] ~= nil then
            flags[v:sub(3)] = true
        else
            table.insert(params, v)
        end
    end

    return {
        params = params,
        flags = flags
    }
end

return polisher