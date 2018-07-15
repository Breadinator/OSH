local shell = require("shell")
local serialization = require("serialization")
local oshl = require("oshl")

local args, opts = shell.parse(...)
if #args == 1 then
  if args[1] == "update" then
    local scripts = oshl.update()
    
    print("Available scripts:")
    for i, script in pairs(scripts) do
      print(script)
    end
  elseif opts.i == true then
    local scriptContents = oshl.getScript(args[1])
    if string.sub(scriptContents, 1, 5) == "ERROR" then
      print(scriptContents)
    else
      if opts.l == true then
        script = io.open(args[1] .. ".lua", "w")
      else
        script = io.open("/bin/" .. args[1] .. ".lua", "w")
      end
      io.output(script)
      io.write(scriptContents)
      io.close(script)
    end
  end
  
else
  print("Usage: WIP)
end
