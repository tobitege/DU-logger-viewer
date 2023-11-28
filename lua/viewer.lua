-- DU-Logger-Viewer by tobitege, based on Jason Bloomer LUA scripts.
-- Programming board script to display data on screen which is 
-- stored in a databank by the logger script.
-- This is basically a wrapper around the actual, main script in viewer-main.lua

-- First some setup code to allow debugging in VSCode
---@diagnostic disable: param-type-mismatch
package.path = "lua/?.lua;util/?.lua;"..package.path

require('globals')

-- startup has all the Config setup with links detection
Config.core_required = false
local status, err, _ = xpcall(function() require('startup') end, traceback)
if not status then
    P("[E] Error in startup!")
    if err then P(err) end
    unit.exit()
    return
end

Databank = Config.databanks[1]
Screen = Config.screens[1]

local screenEvent = require('viewer-screen.onOutputChanged')
if screenEvent ~= nil then
    Screen:onEvent('onOutputChanged', function (self, output) screenEvent.Run(output) end)
end

status, err, _ = xpcall(function() require('viewer-main') end, traceback)
if not status then
    P("[E] Error in viewer-main!")
    if err then P(err) end
    unit.exit()
end