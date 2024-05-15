local process = require("@lune/process")
local fs = require("@lune/fs")

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
   local result = process.spawn("git", {"clone", package, `{process.env.HOME}/.kaska/cache/{package}`})
   if not result.ok then
    print(result.stderr)
   end

   local kaska = require(`/tmp/{package}/kaska.luau`)
   if not kaska then
    print("kaska file is missing")
    return
   end
   -- move up
   if not fs.isDir(`{process.cwd}kaska_modules`) then
    fs.writeDir(`{process.cwd}kaska_modules/`)
   end

   fs.move(`{process.env.HOME}/.kaska/cache/{package}/`, `{process.cwd}kaska_modules/{kaska.name}/`)
end

return install