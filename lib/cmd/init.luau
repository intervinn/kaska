local fs = require("@lune/fs")
local stdio = require("@lune/stdio")
local process = require("@lune/process")
local serde = require("@lune/serde")

local strutil = require("../../util/strutil")

local init = {
    name = "init",
    description = "create a kaska file",

    flags = {
        ["yes"] = false,
    },
    params = {}
}

function init:exec()
    local workDirSplit = strutil.split(process.cwd, "/")
    local workDir = workDirSplit[#workDirSplit] or "project"

    local package = {
        ["name"] = workDir,
        ["description"] = "",
        ["main"] = "main.luau",
        ["author"] = "",
        ["scripts"] = {
            ["start"] = "lune main.luau"
        },
        ["dependencies"] = {},
    }

    local prompt = {"name", "description", "main", "author"}

    if self.flags["yes"] then
        for _,v in pairs(prompt) do
            package[v] = stdio.prompt("text", v, package[v])
        end
    end

    fs.writeFile("kaska.luau", "return "..strutil.fromTable(package, 1))
    
    
    local rc = {}
    if fs.isFile(".luaurc") then
        serde.decode("json", fs.readFile(".luaurc"))
    end

    rc["aliases"]["kaska"] = process.cwd + "lune_modules"
    fs.writeFile(".luaurc", serde.encode("json", rc))
end

return init