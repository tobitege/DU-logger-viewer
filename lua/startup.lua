-- startup for initial config like slots detection
local status, err=false,nil
if INGAME then
    ---@diagnostic disable-next-line: undefined-global
    status, err, _ = xpcall(function()
        if Config.c_required then
            Config.core = library.getCoreUnit()
        end
        if Config.db_required then
            Config.databanks = library.getLinksByClass('DataBank', true) -- true is important!
        end
        if Config.s_required then
            Config.screens = library.getLinksByClass('Screen', true)
        end
    end, traceback)
    if not status then
        P("Error in Link Detection:\n" .. err)
        unit.exit()
        return
    end
else
    -- use mocks
    Config.core = unit.core
    Config.databanks =  { unit.databank }
    Config.screens =  { unit.screen }
end

if #Config.databanks > 0 then
    local plural = ""
    if #Config.databanks > 1 then plural = "s" else plural = " '"..Config.databanks[1].getName().."'" end
    P(#Config.databanks .. " databank" .. plural .. " connected.")
else
    P("[E] DataBank not found.")
end
if #Config.screens > 0 then
    local plural = ""
    if #Config.screens > 1 then plural = "s" end
    P(#Config.screens .. " screen" .. plural .. " connected.")
end