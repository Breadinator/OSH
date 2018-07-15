-- CONFIG START

local repoDir = "/mnt/f7b/"

-- CONFIG END


local component = require("component")
local event = require("event")
local filesystem = require("filesystem")
local serlialization = require("serialization")

local repoContRaw = filesystem.list(repoDir)
local repoContents = {}
while true do
  local element = repoContRaw()
  if element == nil then break end
  if string.sub(element, string.len(element)-3) == ".lua" then
    table.insert(repoContents, string.sub(element, 0, string.len(element)-4))
  end
end

component.modem.open(412)
if component.modem.isOpen(412) then
  print("Port 412 open")
else
  error("Port 412 failed to open")
end

while true do
  local, _, _, from, port, _, message = event.pull("modem_message")
  print("\"" .. tostring(message) .. "\" from " .. from)
  
  if message == "UPDATE" then
    component.modem.send(from, 413, serialization.serialize(repoContents))
  elseif string.sub(message, 1, 3) == "GET" then
    local reqScr = string.sub(message, 5)
    
    local found = false
    for i, scriptName in pairs(repoContents) do
      if scriptName == reqScr then
        found = true
      end
    end
    
    if found == true then
      local script = io.open(repoDir .. reqScr .. ".lua", "r")
      io.input(script)
      local scriptContents = io.read("*a")
      io.close(script)
      component.modem.send(from, 413, scriptContents)
    else
      component.modem.send(from, 413, "ERROR 201")
    end
  end
end
