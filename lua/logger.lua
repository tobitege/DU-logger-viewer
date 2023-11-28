-- DU-Logger-Viewer by tobitege, based on Jason Bloomer's LUA scripts.
-- Wrapper for logging programming board script to log information of the
-- current "Player" (and their org's IDs) into 2 separate databanks.
-- This is basically a wrapper around the actual, main script in logger-main.k

-- First some setup code to allow debugging in VSCode
---@diagnostic disable: param-type-mismatch
package.path = "lua/?.lua;util/?.lua;"..package.path

require('globals')

Config.s_required = false
local status, err, _ = xpcall(function() require('startup') end, traceback)
if not status then
    P("[E] Error in startup!")
    if err then P(err) end
    unit.exit()
    return
end

if #Config.databanks ~= 2 then
    P("[E] 2 databanks must be linked!")
else
    status, err, _ = xpcall(function() require('logger-library') end, traceback)
    if not status then
        P("[E] Error in startup!")
        if err then P(err) end
        unit.exit()
        return
    end

    SysData = Config.databanks[1]
    OrgData = Config.databanks[2]
    status, err, _ = xpcall(function() require('logger-main') end, traceback)
    if not status then
        P("[E] Error in logger-main!")
        if err then P(err) end
    end
end
unit.exit()