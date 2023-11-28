---@diagnostic disable: param-type-mismatch
--local P=system.print

local klist = SysData.getKeyList()
if DEBUG and klist then
    P("SysData keys:\r\n"..DumpTable(klist))
end

local MplayerID = player.getId()
local MplayerName = player.getName()
local MplayerMass = player.getNanopackMass()
local MplayerVolume = player.getNanopackVolume()
local MplayerMaxVolume = player.getNanopackMaxVolume()
local MplayerWrldPos = player.getWorldPosition()
local MplayerWrldVelo = player.getWorldVelocity()
local MplayerOrgIDs = player.getOrgIds()
local MplayerTime = system.getUtcTime()
local MplayerTimeOffset = system.getUtcOffset()

local MplayerParentID = player.getParent()
local MplayerIsSeated = player.isSeated()
local MplayerSeatID = player.getSeatId()
local MplayerSprinting = player.isSprinting()
local MplayerIsJetpackOn = player.isJetpackOn()
local MplayerIsHeadlightOn = player.isHeadlightOn()

if type(klist) == "table" then
    for _, v in pairs(klist) do
        if MplayerID == v then
            NameRecorded = 1
        end
    end
end

if DEBUG then P("Orgs: "..#MplayerOrgIDs) end
for k, v in pairs(MplayerOrgIDs) do
    local orginfo = system.getOrganization(v)
    local dump = DumpTable(orginfo)
    if DEBUG then P(k..": "..dump) end
    OrgData.setStringValue(v,dump)
end

P("ID "..MplayerID.." "..MplayerName.." recorded")
local t = TableConstructor(MplayerName,MplayerMass,MplayerVolume,MplayerMaxVolume,MplayerOrgIDs,MplayerTime,MplayerTimeOffset,MplayerWrldPos,MplayerWrldVelo,MplayerParentID,MplayerIsSeated,MplayerSeatID,MplayerSprinting,MplayerIsJetpackOn,MplayerIsHeadlightOn)
SysData.setStringValue(MplayerID, DumpTable(t))
if DEBUG then P(SysData.getStringValue(MplayerID)) end