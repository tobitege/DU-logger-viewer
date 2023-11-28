-- Main viewer script. Assumes Databank and Screen were already assigned!
Page = 1
local out = ""
NBKeys = Databank.getNbKeys()
if not NBKeys then
    P("[E] Databank is empty!")
else
    DBKeys = Databank.getKeyList()
    if DBKeys and #DBKeys > 0 then
        local hasKeys = true
        if #DBKeys == 1 then
            P("1 entry found.")
        else
            P(#DBKeys.." entries found.")
        end
        -- get first key+value to send to screen
        for k,v in ipairs(DBKeys) do
            if DEBUG then P("Player ID "..v.." found.") end
            if out == "" then
                out = "KEY:"..tostring(v)
            end
        end
    end
end
Screen.activate()
local screenoutput = Screen.getScriptOutput()
local screeninput = out
Screen.setScriptInput(screeninput)
Screen.clearScriptOutput()
if DEBUG then
    P("Screen OUT: " .. screenoutput)
    P("Screen IN: " .. screeninput)
end