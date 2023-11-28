local outputChanged = {}
function outputChanged.Run(output)
    local hasData = false
    local screenoutput = output --normally: Screen.getScriptOutput()
    local screeninput = ""
    if screenoutput == "" then
        screeninput = "?"
    else
        if screenoutput == "<" then -- previous key        
            if Page > 1 then
                Page = Page - 1
            end
            if DBKeys[Page] and Databank.hasKey(DBKeys[Page]) then
                screeninput = "KEY:"..DBKeys[Page]
            end
        elseif screenoutput == ">" then -- next key
            if Page < NBKeys then
                Page = Page + 1
            end
            if DBKeys[Page] and Databank.hasKey(DBKeys[Page]) then
                screeninput = "KEY:"..DBKeys[Page]
            end
        elseif screenoutput == "KEYOK" then -- key accepted, send val now        
            if DBKeys[Page] and Databank.hasKey(DBKeys[Page]) then
                screeninput = "VAL:"..Databank.getStringValue(DBKeys[Page])
                hasData = true
            end
        --else command not understood
        end
    end
    Screen.setScriptInput(screeninput)
    Screen.clearScriptOutput()
    if DEBUG then
        P("*Screen OUT: "..screenoutput)
        local out = "*Screen IN: "
        if hasData then
            out = out .. "***"
        else
            out = out .. screeninput
        end
        P(out)
    end
end
return outputChanged