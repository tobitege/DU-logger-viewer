---@diagnostic disable: lowercase-global
--json = require("dkjson")
if not init then
    init = true
    Displaystringkey = ""
    Lastinput = ""
    Scrollpos = 0
    Valuetable = ""
    imagebg = 1
    passwordstring = ""
    displaystringdefault = "NO KEYS FOUND"
    displaystringvalue = ""
    color1R, color1G, color1B, color1A = 0, 0, 0, 0.85 --background
    color2R, color2G, color2B, color2A = 0.1, 0.1, 0.1, 0.5 --button BG
    color3R, color3G, color3B, color3A = 0.5, 0.3, 0.1, 0.5 --button border
    color4R, color4G, color4B, color4A = 0.5, 0.3, 0.1, 0.5 --button BG hover
    color5R, color5G, color5B, color5A = 0.9, 0.7, 0.1, 0.5 --button BG click
    color6R, color6G, color6B, color6A = 1, 1, 1, 0.75 --button text
    color7R, color7G, color7B, color7A = 0.15, 0.15, 0.15, 1 --scrollbar BG
    --local color8R, color8G, color8B, color8A = 0.25, 0.75, 0.25, 0.15 --scrollbar grabber BG
    --local color9R, color9G, color9B, color9A = 1, 1, 1, 0.75 --scrollbar grabber border
    color10R, color10G, color10B, color10A = 0.05, 0.05, 0.05, 1 --UI Panel BG
    color11R, color11G, color11B, color11A = 1, 1, 0, 1 --Data Value Text

    Column2 = 175   -- 2nd data column offset from left
    linespacing = 0 -- extra linespacing in dots between lines, default 0
    lineheight = 20 -- line height in dots, default 20
end
rx, ry = getResolution()
local layer = createLayer() --  Main Background
local layer4 = createLayer() -- key value text
local layer5 = createLayer() -- UI
local fontL = loadFont("Play", lineheight*6)
local fontH = loadFont("Play", lineheight*5)
local fontB = loadFont("Play", lineheight*3)
local fontM = loadFont("Play", lineheight*2)
local fontS = loadFont("Play", lineheight)
local curx, cury = getCursor()
local scriptinput = ""
local drawposx, drawposy = 30,30 -- top left corner starting point for data
local scale = ry -- was originally 2048

setNextFillColor(layer, color1R, color1G, color1B, 1)
addBox(layer,0,0,rx,ry)

-- process PB input
if getInput() then
    scriptinput = getInput()
    if scriptinput == "?" then
        -- do nothing
    elseif string.sub(scriptinput,1,4) == "KEY:" then
        Displaystringkey = scriptinput:sub(5)
        setOutput("KEYOK")
    elseif string.sub(scriptinput,1,4) == "VAL:" then
        scriptinput = scriptinput:sub(5)
        Valuetable = scriptinput
        setOutput("VALOK")
    end
    Lastinput = scriptinput
end

function DrawKeypadButton(btnx, btny, btnw, btnh, btntxt)
    setNextFillColor(layer5, color2R, color2G, color2B, color2A)
    if curx > btnx then
        if curx < btnx+btnw then
            if cury > btny then
                if cury < (btny+btnh) then
                    if getCursorReleased() == true then
                        setNextFillColor(layer5, color5R, color5G, color5B, color5A)
                        setOutput(btntxt)
                    else
                        setNextFillColor(layer5, color4R, color4G, color4B, color4A)
                    end
                end
            end
        end
    end
    setNextStrokeColor(layer5, color3R, color3G, color3B, color3A)
    setNextStrokeWidth(layer5, 5)
    addBoxRounded(layer5, btnx, btny, btnw, btnh, 5)
    setNextFillColor(layer5, color6R, color6G, color6B, color6A)
    addText(layer5, fontM, btntxt, btnx + (rx*0.015), btny + (ry*0.0625))
end

function DrawScrollBar(btnx, btny, btnw, btnh)
    setNextFillColor(layer5, color7R, color7G, color7B, color7A)
    addBox(layer5, btnx, btny, btnw, btnh)
    setNextFillColor(layer5, color2R, color2G, color2B, color2A)
    if curx > btnx then
        if curx < (btnx + btnw) then
            if cury > btny then
                if cury < (btny + btnh) then
                    if getCursorDown() == true then
                        --drag scrollbar
                        setNextFillColor(layer5, color5R, color5G, color5B, color5A)
                        Scrollpos = ((cury - btny) / btnh) * scale
                    else
                        setNextFillColor(layer5, color4R, color4G, color4B, color4A)
                    end
                end
            end
        end
    end
    setNextStrokeColor(layer5, color3R, color3G, color3B, color3A)
    setNextStrokeWidth(layer5, 5)
    addBox(layer5, btnx, (((Scrollpos/scale) * btnh) ), btnw, rx*0.025)
end

function DrawInterface()
    --Control bar, bottom
    setNextFillColor(layer5, color10R, color10G, color10B, color10A)
    addBox(layer5, 0, ry*0.8, rx, ry*0.2)

    DrawKeypadButton(rx*0.05, ry*0.85, rx*0.045, ry*0.08, "<")
    DrawKeypadButton(rx*0.75, ry*0.85, rx*0.045, ry*0.08, ">")

    addText(layer5, fontM, Displaystringkey, rx*0.1 + 15, ry*0.855 + 35) --0.815 + 35
end

function DrawText1(s, x, y)
    if (y < -(lineheight)) or (y > (ry + lineheight)) then return end
    setNextFillColor(layer4, color11R, color11G, color11B, color11A)
    addText(layer4, fontS, s, x, y)
end

function DrawJson(json)
    local tempstring = string.sub(json, 2, #json - 1)
    local tempchar = string.sub(json, 1, 1)
    local charsleft = 0
    local namebuffer = ""
    local isname = 0
    local valuebuffer = ""
    local isvalue = 0
    local decIndent = false
    repeat
        tempchar = string.sub(tempstring, 1, 1)
        tempstring = string.sub(tempstring, 2, string.len(tempstring))
        charsleft = string.len(tempstring)
        if tempchar == "{" then
            --increase indentation
            drawposx = drawposx + 25
            drawposy = drawposy + lineheight
            namebuffer = ""
            valuebuffer = ""
        elseif tempchar == "]" then
            --stop accumulating chars in buffer and print
            isname = 0
            DrawText1(namebuffer, drawposx, drawposy - Scrollpos)
            drawposy = drawposy + linespacing
            namebuffer = ""
        end
        if isname == 1 then
            --accumulate chars in buffer
            namebuffer = namebuffer .. tempchar
        end
        if tempchar == "[" then
            --accumulate chars in buffer until the end of the name is reached
            isname = 1
        end
        if tempchar == "," and isvalue == 1 then
            --stop accumulating chars in buffer and print
            isvalue = 0
            DrawText1(valuebuffer, drawposx + Column2, drawposy - Scrollpos)
            drawposy = drawposy + lineheight
            valuebuffer = ""
            --decrease indentation if flagged
            if decIndent then
                decIndent = false
                drawposx = drawposx - 25
            end
        end
        if tempchar == "}" then
            --increase indentation
            tempchar = ""
            decIndent = true
        end
        if tempchar == "{" and isvalue == 1 then
            --stop accumulating chars in buffer
            isvalue = 0
            valuebuffer = ""
        end
        if isvalue == 1 then
            --accumulate chars in buffer
            valuebuffer = valuebuffer .. tempchar
        end
        if tempchar == "=" then
            --accumulate chars in buffer until the end of the value is reached
            isvalue = 1
        end
    until(charsleft == 0)
end

--draw key value
DrawJson(Valuetable)

--draw UI
DrawScrollBar(rx*0.95,0,rx*0.1,ry*0.8)
DrawInterface()

requestAnimationFrame(1)