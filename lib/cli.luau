local polisher = require("polisher")

function cli(args: {string})
    local cmd = args[1]
    local module = require(`cmd/{cmd}`)

    if not module then
        print("command not found")
    end

    local result = polisher.separate(args, module)
    module.flags = result.flags
    module.params = result.params

    module:exec(args)
end

return cli