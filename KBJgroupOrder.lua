-- Config
local position_REF = 'CENTER'
local position_X = 500
local position_Y = 46
local position_Align = 'TOP'
-- /Config

---

local GroupOrder_Type = 0
local GroupOrder_InstanceItem = 0
local GroupOrder_Raid
local GroupOrder_BG

local framepool = {}
 
local function removeframe(f)
    f:Hide()
    tinsert(framepool, f)
end
---

local function OnClick_btnPull(self)
    SendChatMessage("Pull after 4s!", "GUILD") 
end

local function OnClick_btnWaitHere(self)
    SendChatMessage("Wait on Orange{동그라미}", "GUILD") 
end

local function OnClick_btnMove(self)
    SendChatMessage("Move! Move!", "GUILD") 
end

local function OnClick_btnSelect(self)
    removeframe(KBJGroupOrder_SubFrame)
    KBJGroupOrder_Instance:Hide()
    KBJGroupOrder_Raid:Hide()
    KBJGroupOrder_BG:Hide()

    if GroupOrder_Type == 1 then
        KBJGroupOrder_Type:Hide()
        GroupOrder_Type = 0
    else        
        KBJGroupOrder_Type:Show()
        GroupOrder_Type = 1
    end
end

local function OnClick_selectTypeInstance(self)
    KBJGroupOrder_Type:Hide()
    KBJGroupOrder_Instance:Show()      
    GroupOrder_Type = 0
end

local function OnClick_selectTypeRaid(self)
    KBJGroupOrder_Type:Hide()
    KBJGroupOrder_Raid:Show()      
    GroupOrder_Type = 0
end

local function OnClick_selectTypeBG(self)
    KBJGroupOrder_Type:Hide()
    KBJGroupOrder_BG:Show()      
    GroupOrder_Type = 0
end

---

local mainFrame = CreateFrame('Frame', 'KBJGroupOrder', UIParent)
mainFrame:SetSize(100, 102)
mainFrame:SetPoint(position_Align, UIParent, position_REF, position_X, position_Y)

local subFrame = CreateFrame('Frame', 'KBJGroupOrder_SubFrame', UIParent)
subFrame:SetSize(100, 22)
subFrame:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -10)

local btnPull = CreateFrame('Button', 'btnPull', mainFrame, 'OptionsButtonTemplate')
btnPull:SetSize(100, 22)
btnPull:SetPoint('TOP', mainFrame, 'TOP', 0, 0)
btnPull:SetText("Pull")
btnPull:SetScript("OnClick", OnClick_btnPull)

local btnWaitHere = CreateFrame('Button', 'btnWaitHere', mainFrame, 'OptionsButtonTemplate')
btnWaitHere:SetSize(100, 22)
btnWaitHere:SetPoint('TOP', btnPull, 'BOTTOM', 0, -2)        
btnWaitHere:SetText("Wait Here")
btnWaitHere:SetScript("OnClick", OnClick_btnWaitHere) 

local btnMove = CreateFrame('Button', 'btnMove', mainFrame, 'OptionsButtonTemplate')
btnMove:SetSize(100, 22)
btnMove:SetPoint('TOP', btnWaitHere, 'BOTTOM', 0, -2)        
btnMove:SetText("Move")
btnMove:SetScript("OnClick", OnClick_btnMove)

local btnSelect = CreateFrame('Button', 'btnSelect', mainFrame, 'OptionsButtonTemplate')
btnSelect:SetSize(100, 22)
btnSelect:SetPoint('TOP', btnMove, 'BOTTOM', 0, -10)
btnSelect:SetText("Select")
btnSelect:SetScript("OnClick", OnClick_btnSelect)

---

local selectType = CreateFrame('Frame', 'KBJGroupOrder_Type', UIParent)
selectType:SetSize(100, 94)
selectType:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -10)

local selectTypeInstance = CreateFrame('Button', 'selectTypeInstance', selectType, 'OptionsButtonTemplate')
selectTypeInstance:SetSize(100, 22)
selectTypeInstance:SetPoint('TOP', selectType, 'TOP', 0, 0)
selectTypeInstance:SetText("Instance")
selectTypeInstance:SetScript("OnClick", OnClick_selectTypeInstance)

local selectTypeRaid = CreateFrame('Button', 'selectTypeRaid', selectType, 'OptionsButtonTemplate')
selectTypeRaid:SetSize(100, 22)
selectTypeRaid:SetPoint('TOP', selectTypeInstance, 'BOTTOM', 0, -2)
selectTypeRaid:SetText("Raid")
selectTypeRaid:SetScript("OnClick", OnClick_selectTypeRaid)

local selectTypeBG = CreateFrame('Button', 'selectTypeBG', selectType, 'OptionsButtonTemplate')
selectTypeBG:SetSize(100, 22)
selectTypeBG:SetPoint('TOP', selectTypeRaid, 'BOTTOM', 0, -2)
selectTypeBG:SetText("BattleGround")
selectTypeBG:SetScript("OnClick", OnClick_selectTypeBG)

---

local selectInstance = CreateFrame('Frame', 'KBJGroupOrder_Instance', UIParent)
selectInstance:SetSize(100, (24 * #GroupOrderInstanceName) - 2)
selectInstance:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -10)

local GroupOrderInstance = {}
for i = 1, #GroupOrderInstanceName do
    GroupOrderInstance[i] = CreateFrame('Button', 'GroupOrderInstance'..i, selectInstance, 'OptionsButtonTemplate')
    GroupOrderInstance[i]:SetSize(100, 22)
    GroupOrderInstance[i]:SetText(GroupOrderInstanceName[i])
    GroupOrderInstance[i]:SetScript("OnClick", function() selectTypeInstanceItem(GroupOrderInstanceName[i]) end)

    if i == 1 then GroupOrderInstance[i]:SetPoint('TOP', selectInstance, 'TOP', 0, 0)
    else GroupOrderInstance[i]:SetPoint('TOP', GroupOrderInstance[i-1], 'BOTTOM', 0, -2)
    end
end

---

local selectRaid = CreateFrame('Frame', 'KBJGroupOrder_Raid', UIParent)
selectRaid:SetSize(100, (24 * #GroupOrderRaidName) - 2)
selectRaid:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -10)

local GroupOrderRaid = {}
for i = 1, #GroupOrderRaidName do
    GroupOrderRaid[i] = CreateFrame('Button', 'GroupOrderRaid'..i, selectRaid, 'OptionsButtonTemplate')
    GroupOrderRaid[i]:SetSize(100, 22)
    GroupOrderRaid[i]:SetText(GroupOrderRaidName[i])

    if i == 1 then GroupOrderRaid[i]:SetPoint('TOP', selectRaid, 'TOP', 0, 0)
    else GroupOrderRaid[i]:SetPoint('TOP', GroupOrderRaid[i-1], 'BOTTOM', 0, -2)
    end
end

---

local selectBG = CreateFrame('Frame', 'KBJGroupOrder_BG', UIParent)
selectBG:SetSize(100, (24 * #GroupOrderBGName) - 2)
selectBG:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -10)

local GroupOrderBG = {}
for i = 1, #GroupOrderBGName do
    GroupOrderBG[i] = CreateFrame('Button', 'GroupOrderBG'..i, selectBG, 'OptionsButtonTemplate')
    GroupOrderBG[i]:SetSize(100, 22)
    GroupOrderBG[i]:SetText(GroupOrderBGName[i])

    if i == 1 then GroupOrderBG[i]:SetPoint('TOP', selectBG, 'TOP', 0, 0)
    else GroupOrderBG[i]:SetPoint('TOP', GroupOrderBG[i-1], 'BOTTOM', 0, -2)
    end
end

---

function selectTypeInstanceItem(item)  
    KBJGroupOrder_Instance:Hide()
    KBJGroupOrder_SubFrame:Show()
    SendChatMessage(item, "GUILD")

    local numm = GroupOrderInstanceData[item]
    subFrame:SetSize(100, (24 * #numm) - 2)
    
    local GroupOrderInstanceDB = { }   
    for i = 1, #numm do
        GroupOrderInstanceDB[i] = CreateFrame('Button', 'GroupOrderInstanceData'..i, subFrame, 'OptionsButtonTemplate')
        GroupOrderInstanceDB[i]:SetSize(100, 22)
        GroupOrderInstanceDB[i]:SetText(numm[i].name)
        --GroupOrderInstanceData[i]:SetScript("OnClick", function() selectTypeInstanceItem(GroupOrderInstanceName[i]) end)

        if i == 1 then GroupOrderInstanceDB[i]:SetPoint('TOP', subFrame, 'TOP', 0, 0)
        else GroupOrderInstanceDB[i]:SetPoint('TOP', GroupOrderInstanceDB[i-1], 'BOTTOM', 0, -2)
        end
    end
end

---

local selectInstanceA = CreateFrame('Frame', 'KBJGroupOrder_Instance', UIParent)
selectInstanceA:SetSize(100, (24 * #GroupOrderInstanceName) - 2)
selectInstanceA:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -10)

local GroupOrderInstanceA = {}
local GroupOrderInstanceB = {}
local GroupOrderInstanceC = {}
local GroupOrderInstanceD = {}
local GroupOrderInstanceE = {}
local GroupOrderInstanceF = {}
local GroupOrderInstanceG = {}
local GroupOrderInstanceH = {}
local GroupOrderInstanceI = {}
local GroupOrderInstanceJ = {}
for i = 1, #GroupOrderInstanceName[] do
    GroupOrderInstanceA[i] = CreateFrame('Button', 'GroupOrderInstanceA'..i, selectInstanceA, 'OptionsButtonTemplate')
    GroupOrderInstanceA[i]:SetSize(100, 22)
    GroupOrderInstanceA[i]:SetText(GroupOrderInstanceName[i])
    GroupOrderInstanceA[i]:SetScript("OnClick", function() selectTypeInstanceItem(GroupOrderInstanceName[i]) end)

    if i == 1 then GroupOrderInstanceA[i]:SetPoint('TOP', selectInstanceA, 'TOP', 0, 0)
    else GroupOrderInstanceA[i]:SetPoint('TOP', GroupOrderInstanceA[i-1], 'BOTTOM', 0, -2)
    end
end

---

KBJGroupOrder_Type:Hide()
KBJGroupOrder_Instance:Hide()
KBJGroupOrder_Raid:Hide()
KBJGroupOrder_BG:Hide()
