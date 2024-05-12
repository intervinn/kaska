local strutil = require("../util/strutil")

export type PolisherSeparateResult = {
    params: {string},
    flags: {}
}

local polisher = {}
polisher.__index = polisher

function polisher.separate(args: {string}, flagsTemplate: {[string]: boolean}) : PolisherSeparateResult

    local params = {}
    local flags = flagsTemplate

    for _,v in pairs(args) do
        if strutil.starts(v, "--") and flags[v:sub(3)] then
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