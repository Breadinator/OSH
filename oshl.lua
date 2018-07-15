local component = require("component")
local event = require("event")
local serialization = require("serialization")

local m = component.modem



local oshl = {}

function.oshl.awaitResponse()
  m.open(413)
  local _, _, from, port, _, message = event.pull("modem_message")
  m.close(413)
  return from, port, message
end

function oshl.update()
  m.broadcast(412, "UPDATE")
  from, port, message = oshl.awaitResponse()
  return serialization.unserialize(message)
end

function oshl.getScript(name)
  m.broadcast(412, "GET " .. name)
  from, port, message = oshl.awaitResponse()
  return message
end

return oshl
