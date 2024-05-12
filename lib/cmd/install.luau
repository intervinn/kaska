
local install = {
    flags = {},
    params = {}
}

function install:exec()
    local package = self.params[2]
    if not package then
        print("package name not stated")
    end

    -- i guess git clone
end

return install