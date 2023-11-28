-- Initialize globals and constants
Config = { core = nil, c_required=true, databanks = {}, db_required=true, screens = {}, s_required=true }
DEBUG = false
INGAME = system ~= nil

if not INGAME then
---@if DEBUG true
    --require("mocks")
---@end
    function traceback(o)
        if o then P(tostring(o)) end
    end
else
    --require 'mockfuncs'
    print=system.print
end
P=print