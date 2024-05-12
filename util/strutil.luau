
local strutil = {}
strutil.__index = strutil

function strutil.starts(String: string,Start: string): boolean
   return string.sub(String,1,string.len(Start))==Start
end

function strutil.split(str: string, sep: string) : {string}
   local result = {}
   local regex = ("([^%s]+)"):format(sep)
   for each in str:gmatch(regex) do
      table.insert(result, each)
   end
   return result
end

function strutil.fromTable(table: {[string]: any}, step)
   local str = `\{\n`

   for k,v in pairs(table) do
      local value = v
      if typeof(v) == "string" then
         value = `\"{v}\"`
      end
      if typeof(v) == "table" then
         value = strutil.fromTable(v, step+1)
      end

      str = str..`{string.rep("\t", step)}[\"{k}\"] = {value},\n`
   end

   str..=`{string.rep("\t", step-1)}}`

   return str
end

return strutil