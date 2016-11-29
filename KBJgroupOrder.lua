-- Config
local position_REF = 'CENTER'
local position_X = 500
local position_Y = 46
local position_Align = 'TOP'
-- /Config

---

local GroupOrder_Type = 0

---

local function OnClick_btnPull(self)
    MacroEditBox:GetScript('OnEvent')(MacroEditBox, 'EXECUTE_CHAT_LINE', "/pull 3")
    SendChatMessage("Pulling after 3s!", "SAY")
end

local function OnClick_btnCallLust(self)
    SendChatMessage("Lust!!!", "SAY")
    SendChatMessage("Lust!!!", "SAY")
    SendChatMessage("Lust!!!", "SAY")
end

local function OnClick_btnWaitHere(self)
    SendChatMessage("Wait on Blue{네모} for LOS", "SAY")
    SendChatMessage("Wait on Blue{네모} for LOS", "SAY")
    SendChatMessage("Wait on Blue{네모} for LOS", "SAY")
end

local function OnClick_btnMove(self)
    SendChatMessage("Follow Orange{동그라미}", "SAY")
    SendChatMessage("Follow Orange{동그라미}", "SAY")
    SendChatMessage("Follow Orange{동그라미}", "SAY")
end

local function OnClick_btnStack(self)
    SendChatMessage("Stack on Orange{동그라미}", "SAY")
    SendChatMessage("Stack on Orange{동그라미}", "SAY")
    SendChatMessage("Stack on Orange{동그라미}", "SAY")
end

local function OnClick_btnBack(self)
    SendChatMessage("Stay Back!!", "SAY")
    SendChatMessage("Stay Back!!", "SAY")
    SendChatMessage("Stay Back!!", "SAY")
end

local function OnClick_btnSelect(self)
    KBJGroupOrder_Instance:Hide()
    KBJGroupOrder_Raid:Hide()

    KBJGroupOrder_Instance_VoW:Hide()
    KBJGroupOrder_Instance_BRH:Hide()
    KBJGroupOrder_Instance_NEL:Hide()
    KBJGroupOrder_Instance_CoS:Hide()
    KBJGroupOrder_Instance_ARC:Hide()
    KBJGroupOrder_Instance_EoA:Hide()
    KBJGroupOrder_Instance_DHT:Hide()
    KBJGroupOrder_Instance_MEW:Hide()
    KBJGroupOrder_Instance_VoH:Hide()
    KBJGroupOrder_Instance_KAA:Hide()
    KBJGroupOrder_Instance_KAL:Hide()

    KBJGroupOrder_Raid_NoE:Hide()
    KBJGroupOrder_Raid_ToH:Hide()
    KBJGroupOrder_Raid_HoN:Hide()

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

---

local mainFrame = CreateFrame('Frame', 'KBJGroupOrder', UIParent)
mainFrame:SetSize(100, 178)
mainFrame:SetPoint(position_Align, UIParent, position_REF, position_X, position_Y)

local btnPull = CreateFrame('Button', 'btnPull', mainFrame, 'OptionsButtonTemplate')
btnPull:SetSize(100, 22)
btnPull:SetPoint('TOP', mainFrame, 'TOP', 0, 0)
btnPull:SetText("3초후 풀링")
btnPull:SetScript("OnClick", OnClick_btnPull)

local btnCallHero = CreateFrame('Button', 'btnCallLust', mainFrame, 'OptionsButtonTemplate')
btnCallLust:SetSize(100, 22)
btnCallLust:SetPoint('TOP', btnPull, 'BOTTOM', 0, -2)
btnCallLust:SetText("영웅심!")
btnCallLust:SetScript("OnClick", OnClick_btnCallLust)

local btnWaitHereMark = CreateFrame('Button', 'btnWaitHereMark', mainFrame, 'SecureActionButtonTemplate, OptionsButtonTemplate')
btnWaitHereMark:SetSize(22, 22)
btnWaitHereMark:SetPoint('TOPLEFT', btnCallLust, 'BOTTOMLEFT', 0, -8)        
btnWaitHereMark:SetText("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:12:12|t")
btnWaitHereMark:SetAttribute("type", "macro")
btnWaitHereMark:SetAttribute("macrotext", "/wm 1")

local btnWaitHere = CreateFrame('Button', 'btnWaitHere', mainFrame, 'OptionsButtonTemplate')
btnWaitHere:SetSize(77, 22)
btnWaitHere:SetPoint('LEFT', btnWaitHereMark, 'RIGHT', 1, 0)        
btnWaitHere:SetText("에서 기다려")
btnWaitHere:SetScript("OnClick", OnClick_btnWaitHere)

local btnMove = CreateFrame('Button', 'btnMove', mainFrame, 'OptionsButtonTemplate')
btnMove:SetSize(100, 22)
btnMove:SetPoint('TOPLEFT', btnWaitHereMark, 'BOTTOMLEFT', 0, -2)        
btnMove:SetText("오렌지를 따라와")
btnMove:SetScript("OnClick", OnClick_btnMove)

local btnStack = CreateFrame('Button', 'btnStack', mainFrame, 'OptionsButtonTemplate')
btnStack:SetSize(100, 22)
btnStack:SetPoint('TOP', btnMove, 'BOTTOM', 0, -2)        
btnStack:SetText("오렌지에게 모여")
btnStack:SetScript("OnClick", OnClick_btnStack)

local btnBack = CreateFrame('Button', 'btnBack', mainFrame, 'OptionsButtonTemplate')
btnBack:SetSize(100, 22)
btnBack:SetPoint('TOP', btnStack, 'BOTTOM', 0, -2)        
btnBack:SetText("물러서")
btnBack:SetScript("OnClick", OnClick_btnBack)

local btnSelect = CreateFrame('Button', 'btnSelect', mainFrame, 'OptionsButtonTemplate')
btnSelect:SetSize(100, 22)
btnSelect:SetPoint('TOP', btnBack, 'BOTTOM', 0, -8)
btnSelect:SetText("브리핑 세트")
btnSelect:SetScript("OnClick", OnClick_btnSelect)

---

local selectType = CreateFrame('Frame', 'KBJGroupOrder_Type', UIParent)
selectType:SetSize(100, 94)
selectType:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

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

---

local selectInstance = CreateFrame('Frame', 'KBJGroupOrder_Instance', UIParent)
selectInstance:SetSize(100, (24 * #GroupOrderInstanceName) - 2)
selectInstance:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

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

local selectRaid = CreateFrame('Frame', 'KBJGroupOrder_Raid', UIParent)
selectRaid:SetSize(100, (24 * #GroupOrderRaidName) - 2)
selectRaid:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderRaid = {}
for i = 1, #GroupOrderRaidName do
    GroupOrderRaid[i] = CreateFrame('Button', 'GroupOrderRaid'..i, selectRaid, 'OptionsButtonTemplate')
    GroupOrderRaid[i]:SetSize(100, 22)
    GroupOrderRaid[i]:SetText(GroupOrderRaidName[i])
    GroupOrderRaid[i]:SetScript("OnClick", function() selectTypeRaidItem(GroupOrderRaidName[i]) end)

    if i == 1 then GroupOrderRaid[i]:SetPoint('TOP', selectRaid, 'TOP', 0, 0)
    else GroupOrderRaid[i]:SetPoint('TOP', GroupOrderRaid[i-1], 'BOTTOM', 0, -2)
    end
end

---

-- 감시관의 금고
local selectInstanceVoW = CreateFrame('Frame', 'KBJGroupOrder_Instance_VoW', UIParent)
selectInstanceVoW:SetSize(100, (24 * #GroupOrderInstanceData["감시관의 금고"]) - 2)
selectInstanceVoW:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceVoW = {}
for i = 1, #GroupOrderInstanceData["감시관의 금고"] do
    GroupOrderInstanceVoW[i] = CreateFrame('Button', 'GroupOrderInstanceVoW'..i, selectInstanceVoW, 'OptionsButtonTemplate')
    GroupOrderInstanceVoW[i]:SetSize(100, 22)
    GroupOrderInstanceVoW[i]:SetText(GroupOrderInstanceData["감시관의 금고"][i].name)
    GroupOrderInstanceVoW[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["감시관의 금고"][i].msg) end)

    if i == 1 then GroupOrderInstanceVoW[i]:SetPoint('TOP', selectInstanceVoW, 'TOP', 0, 0)
    else GroupOrderInstanceVoW[i]:SetPoint('TOP', GroupOrderInstanceVoW[i-1], 'BOTTOM', 0, -2)
    end
end

-- 검은 떼까마귀 요새
local selectInstanceBRH = CreateFrame('Frame', 'KBJGroupOrder_Instance_BRH', UIParent)
selectInstanceBRH:SetSize(100, (24 * #GroupOrderInstanceData["검은 떼까마귀"]) - 2)
selectInstanceBRH:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceBRH = {}
for i = 1, #GroupOrderInstanceData["검은 떼까마귀"] do
    GroupOrderInstanceBRH[i] = CreateFrame('Button', 'GroupOrderInstanceBRH'..i, selectInstanceBRH, 'OptionsButtonTemplate')
    GroupOrderInstanceBRH[i]:SetSize(100, 22)
    GroupOrderInstanceBRH[i]:SetText(GroupOrderInstanceData["검은 떼까마귀"][i].name)
    GroupOrderInstanceBRH[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["검은 떼까마귀"][i].msg) end)

    if i == 1 then GroupOrderInstanceBRH[i]:SetPoint('TOP', selectInstanceBRH, 'TOP', 0, 0)
    else GroupOrderInstanceBRH[i]:SetPoint('TOP', GroupOrderInstanceBRH[i-1], 'BOTTOM', 0, -2)
    end
end

-- 넬타리온의 둥지
local selectInstanceNEL = CreateFrame('Frame', 'KBJGroupOrder_Instance_NEL', UIParent)
selectInstanceNEL:SetSize(100, (24 * #GroupOrderInstanceData["넬타리온의 둥지"]) - 2)
selectInstanceNEL:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceNEL = {}
for i = 1, #GroupOrderInstanceData["넬타리온의 둥지"] do
    GroupOrderInstanceNEL[i] = CreateFrame('Button', 'GroupOrderInstanceNEL'..i, selectInstanceNEL, 'OptionsButtonTemplate')
    GroupOrderInstanceNEL[i]:SetSize(100, 22)
    GroupOrderInstanceNEL[i]:SetText(GroupOrderInstanceData["넬타리온의 둥지"][i].name)
    GroupOrderInstanceNEL[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["넬타리온의 둥지"][i].msg) end)

    if i == 1 then GroupOrderInstanceNEL[i]:SetPoint('TOP', selectInstanceNEL, 'TOP', 0, 0)
    else GroupOrderInstanceNEL[i]:SetPoint('TOP', GroupOrderInstanceNEL[i-1], 'BOTTOM', 0, -2)
    end
end

-- 별의 궁정
local selectInstanceCoS = CreateFrame('Frame', 'KBJGroupOrder_Instance_CoS', UIParent)
selectInstanceCoS:SetSize(100, (24 * #GroupOrderInstanceData["별의 궁정"]) - 2)
selectInstanceCoS:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceCoS = {}
for i = 1, #GroupOrderInstanceData["별의 궁정"] do
    GroupOrderInstanceCoS[i] = CreateFrame('Button', 'GroupOrderInstanceCoS'..i, selectInstanceCoS, 'OptionsButtonTemplate')
    GroupOrderInstanceCoS[i]:SetSize(100, 22)
    GroupOrderInstanceCoS[i]:SetText(GroupOrderInstanceData["별의 궁정"][i].name)
    GroupOrderInstanceCoS[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["별의 궁정"][i].msg) end)

    if i == 1 then GroupOrderInstanceCoS[i]:SetPoint('TOP', selectInstanceCoS, 'TOP', 0, 0)
    else GroupOrderInstanceCoS[i]:SetPoint('TOP', GroupOrderInstanceCoS[i-1], 'BOTTOM', 0, -2)
    end
end

-- 비전로
local selectInstanceARC = CreateFrame('Frame', 'KBJGroupOrder_Instance_ARC', UIParent)
selectInstanceARC:SetSize(100, (24 * #GroupOrderInstanceData["비전로"]) - 2)
selectInstanceARC:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceARC = {}
for i = 1, #GroupOrderInstanceData["비전로"] do
    GroupOrderInstanceARC[i] = CreateFrame('Button', 'GroupOrderInstanceARC'..i, selectInstanceARC, 'OptionsButtonTemplate')
    GroupOrderInstanceARC[i]:SetSize(100, 22)
    GroupOrderInstanceARC[i]:SetText(GroupOrderInstanceData["비전로"][i].name)
    GroupOrderInstanceARC[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["비전로"][i].msg) end)

    if i == 1 then GroupOrderInstanceARC[i]:SetPoint('TOP', selectInstanceARC, 'TOP', 0, 0)
    else GroupOrderInstanceARC[i]:SetPoint('TOP', GroupOrderInstanceARC[i-1], 'BOTTOM', 0, -2)
    end
end

-- 아즈샤라의 눈
local selectInstanceEoA = CreateFrame('Frame', 'KBJGroupOrder_Instance_EoA', UIParent)
selectInstanceEoA:SetSize(100, (24 * #GroupOrderInstanceData["아즈샤라의 눈"]) - 2)
selectInstanceEoA:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceEoA = {}
for i = 1, #GroupOrderInstanceData["아즈샤라의 눈"] do
    GroupOrderInstanceEoA[i] = CreateFrame('Button', 'GroupOrderInstanceEoA'..i, selectInstanceEoA, 'OptionsButtonTemplate')
    GroupOrderInstanceEoA[i]:SetSize(100, 22)
    GroupOrderInstanceEoA[i]:SetText(GroupOrderInstanceData["아즈샤라의 눈"][i].name)
    GroupOrderInstanceEoA[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["아즈샤라의 눈"][i].msg) end)

    if i == 1 then GroupOrderInstanceEoA[i]:SetPoint('TOP', selectInstanceEoA, 'TOP', 0, 0)
    else GroupOrderInstanceEoA[i]:SetPoint('TOP', GroupOrderInstanceEoA[i-1], 'BOTTOM', 0, -2)
    end
end

-- 어둠심장 숲
local selectInstanceDHT = CreateFrame('Frame', 'KBJGroupOrder_Instance_DHT', UIParent)
selectInstanceDHT:SetSize(100, (24 * #GroupOrderInstanceData["어둠심장 숲"]) - 2)
selectInstanceDHT:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceDHT = {}
for i = 1, #GroupOrderInstanceData["어둠심장 숲"] do
    GroupOrderInstanceDHT[i] = CreateFrame('Button', 'GroupOrderInstanceDHT'..i, selectInstanceDHT, 'OptionsButtonTemplate')
    GroupOrderInstanceDHT[i]:SetSize(100, 22)
    GroupOrderInstanceDHT[i]:SetText(GroupOrderInstanceData["어둠심장 숲"][i].name)
    GroupOrderInstanceDHT[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["어둠심장 숲"][i].msg) end)

    if i == 1 then GroupOrderInstanceDHT[i]:SetPoint('TOP', selectInstanceDHT, 'TOP', 0, 0)
    else GroupOrderInstanceDHT[i]:SetPoint('TOP', GroupOrderInstanceDHT[i-1], 'BOTTOM', 0, -2)
    end
end

-- 영혼의 아귀
local selectInstanceMEW = CreateFrame('Frame', 'KBJGroupOrder_Instance_MEW', UIParent)
selectInstanceMEW:SetSize(100, (24 * #GroupOrderInstanceData["영혼의 아귀"]) - 2)
selectInstanceMEW:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceMEW = {}
for i = 1, #GroupOrderInstanceData["영혼의 아귀"] do
    GroupOrderInstanceMEW[i] = CreateFrame('Button', 'GroupOrderInstanceMEW'..i, selectInstanceMEW, 'OptionsButtonTemplate')
    GroupOrderInstanceMEW[i]:SetSize(100, 22)
    GroupOrderInstanceMEW[i]:SetText(GroupOrderInstanceData["영혼의 아귀"][i].name)
    GroupOrderInstanceMEW[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["영혼의 아귀"][i].msg) end)

    if i == 1 then GroupOrderInstanceMEW[i]:SetPoint('TOP', selectInstanceMEW, 'TOP', 0, 0)
    else GroupOrderInstanceMEW[i]:SetPoint('TOP', GroupOrderInstanceMEW[i-1], 'BOTTOM', 0, -2)
    end
end

-- 용맹의 전당
local selectInstanceVoH = CreateFrame('Frame', 'KBJGroupOrder_Instance_VoH', UIParent)
selectInstanceVoH:SetSize(100, (24 * #GroupOrderInstanceData["용맹의 전당"]) - 2)
selectInstanceVoH:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceVoH = {}
for i = 1, #GroupOrderInstanceData["용맹의 전당"] do
    GroupOrderInstanceVoH[i] = CreateFrame('Button', 'GroupOrderInstanceVoH'..i, selectInstanceVoH, 'OptionsButtonTemplate')
    GroupOrderInstanceVoH[i]:SetSize(100, 22)
    GroupOrderInstanceVoH[i]:SetText(GroupOrderInstanceData["용맹의 전당"][i].name)
    GroupOrderInstanceVoH[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["용맹의 전당"][i].msg) end)

    if i == 1 then GroupOrderInstanceVoH[i]:SetPoint('TOP', selectInstanceVoH, 'TOP', 0, 0)
    else GroupOrderInstanceVoH[i]:SetPoint('TOP', GroupOrderInstanceVoH[i-1], 'BOTTOM', 0, -2)
    end
end

-- 카라잔 올클리어
local selectInstanceKAA = CreateFrame('Frame', 'KBJGroupOrder_Instance_KAA', UIParent)
selectInstanceKAA:SetSize(100, (24 * #GroupOrderInstanceData["카라잔 올클리어"]) - 2)
selectInstanceKAA:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceKAA = {}
for i = 1, #GroupOrderInstanceData["카라잔 올클리어"] do
    GroupOrderInstanceKAA[i] = CreateFrame('Button', 'GroupOrderInstanceKAA'..i, selectInstanceKAA, 'OptionsButtonTemplate')
    GroupOrderInstanceKAA[i]:SetSize(100, 22)
    GroupOrderInstanceKAA[i]:SetText(GroupOrderInstanceData["카라잔 올클리어"][i].name)
    GroupOrderInstanceKAA[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["카라잔 올클리어"][i].msg) end)

    if i == 1 then GroupOrderInstanceKAA[i]:SetPoint('TOP', selectInstanceKAA, 'TOP', 0, 0)
    else GroupOrderInstanceKAA[i]:SetPoint('TOP', GroupOrderInstanceKAA[i-1], 'BOTTOM', 0, -2)
    end
end

-- 카라잔 파멸
local selectInstanceKAL = CreateFrame('Frame', 'KBJGroupOrder_Instance_KAL', UIParent)
selectInstanceKAL:SetSize(100, (24 * #GroupOrderInstanceData["카라잔 파멸"]) - 2)
selectInstanceKAL:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceKAL = {}
for i = 1, #GroupOrderInstanceData["카라잔 파멸"] do
    GroupOrderInstanceKAL[i] = CreateFrame('Button', 'GroupOrderInstanceKAL'..i, selectInstanceKAL, 'OptionsButtonTemplate')
    GroupOrderInstanceKAL[i]:SetSize(100, 22)
    GroupOrderInstanceKAL[i]:SetText(GroupOrderInstanceData["카라잔 파멸"][i].name)
    GroupOrderInstanceKAL[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderInstanceData["카라잔 파멸"][i].msg) end)

    if i == 1 then GroupOrderInstanceKAL[i]:SetPoint('TOP', selectInstanceKAL, 'TOP', 0, 0)
    else GroupOrderInstanceKAL[i]:SetPoint('TOP', GroupOrderInstanceKAL[i-1], 'BOTTOM', 0, -2)
    end
end

---

-- 에메랄드의 악몽
local selectRaidNoE = CreateFrame('Frame', 'KBJGroupOrder_Raid_NoE', UIParent)
selectRaidNoE:SetSize(100, (24 * #GroupOrderRaidData["에메랄드의 악몽"]) - 2)
selectRaidNoE:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderRaidNoE = {}
for i = 1, #GroupOrderRaidData["에메랄드의 악몽"] do
    GroupOrderRaidNoE[i] = CreateFrame('Button', 'GroupOrderRaidNoE'..i, selectRaidNoE, 'OptionsButtonTemplate')
    GroupOrderRaidNoE[i]:SetSize(100, 22)
    GroupOrderRaidNoE[i]:SetText(GroupOrderRaidData["에메랄드의 악몽"][i].name)
    GroupOrderRaidNoE[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderRaidData["에메랄드의 악몽"][i].msg) end)

    if i == 1 then GroupOrderRaidNoE[i]:SetPoint('TOP', selectRaidNoE, 'TOP', 0, 0)
    else GroupOrderRaidNoE[i]:SetPoint('TOP', GroupOrderRaidNoE[i-1], 'BOTTOM', 0, -2)
    end
end

-- 용맹의 시험
local selectInstanceToH = CreateFrame('Frame', 'KBJGroupOrder_Raid_ToH', UIParent)
selectInstanceToH:SetSize(100, (24 * #GroupOrderRaidData["용맹의 시험"]) - 2)
selectInstanceToH:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceToH = {}
for i = 1, #GroupOrderRaidData["용맹의 시험"] do
    GroupOrderInstanceToH[i] = CreateFrame('Button', 'GroupOrderInstanceToH'..i, selectInstanceToH, 'OptionsButtonTemplate')
    GroupOrderInstanceToH[i]:SetSize(100, 22)
    GroupOrderInstanceToH[i]:SetText(GroupOrderRaidData["용맹의 시험"][i].name)
    GroupOrderInstanceToH[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderRaidData["용맹의 시험"][i].msg) end)

    if i == 1 then GroupOrderInstanceToH[i]:SetPoint('TOP', selectInstanceToH, 'TOP', 0, 0)
    else GroupOrderInstanceToH[i]:SetPoint('TOP', GroupOrderInstanceToH[i-1], 'BOTTOM', 0, -2)
    end
end

-- 밤의 요새
local selectInstanceHoN = CreateFrame('Frame', 'KBJGroupOrder_Raid_HoN', UIParent)
selectInstanceHoN:SetSize(100, (24 * #GroupOrderRaidData["밤의 요새"]) - 2)
selectInstanceHoN:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GroupOrderInstanceHoN = {}
for i = 1, #GroupOrderRaidData["밤의 요새"] do
    GroupOrderInstanceHoN[i] = CreateFrame('Button', 'GroupOrderInstanceHoN'..i, selectInstanceHoN, 'OptionsButtonTemplate')
    GroupOrderInstanceHoN[i]:SetSize(100, 22)
    GroupOrderInstanceHoN[i]:SetText(GroupOrderRaidData["밤의 요새"][i].name)
    GroupOrderInstanceHoN[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderRaidData["밤의 요새"][i].msg) end)

    if i == 1 then GroupOrderInstanceHoN[i]:SetPoint('TOP', selectInstanceHoN, 'TOP', 0, 0)
    else GroupOrderInstanceHoN[i]:SetPoint('TOP', GroupOrderInstanceHoN[i-1], 'BOTTOM', 0, -2)
    end
end

---

function selectTypeInstanceItem(item)
    KBJGroupOrder_Instance:Hide()

    if item == "감시관의 금고" then
        KBJGroupOrder_Instance_VoW:Show()
    elseif item == "검은 떼까마귀" then
        KBJGroupOrder_Instance_BRH:Show()
    elseif item == "넬타리온의 둥지" then
        KBJGroupOrder_Instance_NEL:Show()
    elseif item == "별의 궁정" then
        KBJGroupOrder_Instance_CoS:Show()
    elseif item == "비전로" then
        KBJGroupOrder_Instance_ARC:Show()
    elseif item == "아즈샤라의 눈" then
        KBJGroupOrder_Instance_EoA:Show()
    elseif item == "어둠심장 숲" then
        KBJGroupOrder_Instance_DHT:Show()
    elseif item == "영혼의 아귀" then
        KBJGroupOrder_Instance_MEW:Show()
    elseif item == "용맹의 전당" then
        KBJGroupOrder_Instance_VoH:Show()
    elseif item == "카라잔 올클리어" then
        KBJGroupOrder_Instance_KAA:Show()
    elseif item == "카라잔 파멸" then
        KBJGroupOrder_Instance_KAL:Show()
    end
end

---

function selectTypeRaidItem(item)
    KBJGroupOrder_Raid:Hide()

    if item == "에메랄드의 악몽" then
        KBJGroupOrder_Raid_NoE:Show()
    elseif item == "용맹의 시험" then
        KBJGroupOrder_Raid_ToH:Show()
    elseif item == "밤의 요새" then
        KBJGroupOrder_Raid_HoN:Show()
    end
end

---

KBJGroupOrder_Type:Hide()
KBJGroupOrder_Instance:Hide()
KBJGroupOrder_Raid:Hide()

KBJGroupOrder_Instance_VoW:Hide()
KBJGroupOrder_Instance_BRH:Hide()
KBJGroupOrder_Instance_NEL:Hide()
KBJGroupOrder_Instance_CoS:Hide()
KBJGroupOrder_Instance_ARC:Hide()
KBJGroupOrder_Instance_EoA:Hide()
KBJGroupOrder_Instance_DHT:Hide()
KBJGroupOrder_Instance_MEW:Hide()
KBJGroupOrder_Instance_VoH:Hide()
KBJGroupOrder_Instance_KAA:Hide()
KBJGroupOrder_Instance_KAL:Hide()

KBJGroupOrder_Raid_NoE:Hide()
KBJGroupOrder_Raid_ToH:Hide()
KBJGroupOrder_Raid_HoN:Hide()
