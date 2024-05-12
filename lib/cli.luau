local polisher = require("polisher")

function cli(args: {string})
    local cmd = args[1]
    local module = require(`cmd/{cmd}`)

    if not module then
        print("command not found")
    end
    
    module:exec(args)
end

return cli