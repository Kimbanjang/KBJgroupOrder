-- Config -------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local position_REF = 'CENTER'
local position_X = 500
local position_Y = 46
local position_Align = 'TOP'

local chatRepeat = 1 -- 알림챗 반복 횟수
local chatType = "SAY" -- 말하기 = SAY / 외치기 = YELL / 파티 = PARTY / 레이드 = RAID / 인스턴스 = INSTANCE_CHAT / RAID_WARNING

-- Vars ---------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local GroupOrder_Type = 0

-- Function -----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
function SetPulling(time)
    MacroEditBox:GetScript('OnEvent')(MacroEditBox, 'EXECUTE_CHAT_LINE', "/pull "..time)
    SendChatMessage("Pulling after "..time.."s!", chatType)
    C_Timer.NewTicker(1, (function()
        if time > 1 then
            time = time - 1
            SendChatMessage(time.."s!", chatType)
        else
            SendChatMessage("Pulling!!", chatType)
        end
    end), time)
end

function OutputBrief(msgdb, diff)
    local count = 1
    local timer = #GroupOrderLegionNH[msgdb][diff]
    SendChatMessage(GroupOrderLegionNH[msgdb][diff][count], chatType)
    C_Timer.NewTicker(6, (function()
        if timer > 1 then
            count = count + 1
            SendChatMessage(GroupOrderLegionNH[msgdb][diff][count], chatType)
        else
            SendChatMessage(GroupOrderLegionNH[msgdb][diff][timer], chatType)
        end
    end), timer-1)
end

function CreateButton(parent, sizeX, sixeY, positionS, positionA, positionAP, positionAX, positionAY, text)
	local btn = CreateFrame('Button', nil, parent, 'OptionsButtonTemplate')
	btn:SetSize(sizeX, sixeY)
	btn:SetPoint(positionS, positionA, positionAP, positionAX, positionAY)
	btn:SetText(text)
	return btn
end

function CreateInput(parent, sizeX, sixeY, positionS, positionA, positionAP, positionAX, positionAY, text)
	local input = CreateFrame('EditBox', nil, parent, 'InputBoxTemplate')
	input:SetAutoFocus(false)
	input:SetSize(sizeX, sixeY)
	input:SetPoint(positionS, positionA, positionAP, positionAX, positionAY)
	input:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	input:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
	input:SetText(text)
	return input
end

local ClearFrameSub = function()
    KBJGroupOrder_LegionNH_Skorpyron:Hide()
	KBJGroupOrder_LegionNH_Chronomatic:Hide()
	KBJGroupOrder_LegionNH_Trilliax:Hide()
	KBJGroupOrder_LegionNH_Spellblade:Hide()
	KBJGroupOrder_LegionNH_Tichondrius:Hide()
	KBJGroupOrder_LegionNH_Krosus:Hide()
	KBJGroupOrder_LegionNH_Botanist:Hide()
	KBJGroupOrder_LegionNH_StarAugur:Hide()
    KBJGroupOrder_LegionNH_Elisande:Hide()
	KBJGroupOrder_LegionNH_Guldan:Hide()
end

local ClearFrameAll = function()
    KBJGroupOrder_Type:Hide()
	KBJGroupOrder_KeyStone:Hide()
	KBJGroupOrder_LegionNH:Hide()
	ClearFrameSub()
end

-- Click Event --------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local OnClick_btnSelect = function(self)
    ClearFrameAll()

    if GroupOrder_Type == 1 then
        KBJGroupOrder_Type:Hide()
        GroupOrder_Type = 0
    else        
        KBJGroupOrder_Type:Show()
        GroupOrder_Type = 1
    end
end

local OnClick_btnSelectType = function(item)
    KBJGroupOrder_Type:Hide()
    KBJGroupOrder_LegionNH:Hide()

    if item == "Keystone" then
        KBJGroupOrder_KeyStone:Show()
    elseif item == "Nightmare" then    	
        GroupOrder_Type = 0
        print("Not Found")
    elseif item == "ToV" then    	
        GroupOrder_Type = 0
        print("Not Found")
    elseif item == "Nighthold" then
        KBJGroupOrder_LegionNH:Show()
    end
end

local OnClick_btnSelectLegionNH = function(item)
    KBJGroupOrder_Type:Hide()

    if item == "Skorpyron" then
        ClearFrameSub()
		KBJGroupOrder_LegionNH_Skorpyron:Show()
    elseif item == "Chronomatic" then
        ClearFrameSub()
        KBJGroupOrder_LegionNH_Chronomatic:Show()
    elseif item == "Trilliax" then
    	ClearFrameSub()
		KBJGroupOrder_LegionNH_Trilliax:Show()
    elseif item == "Spellblade" then
    	ClearFrameSub()
		KBJGroupOrder_LegionNH_Spellblade:Show()
    elseif item == "Tichondrius" then
    	ClearFrameSub()
		KBJGroupOrder_LegionNH_Tichondrius:Show()
    elseif item == "Krosus" then
    	ClearFrameSub()
    	KBJGroupOrder_LegionNH_Krosus:Show()
    elseif item == "Botanist" then
    	ClearFrameSub()
    	KBJGroupOrder_LegionNH_Botanist:Show()
    elseif item == "StarAugur" then
    	ClearFrameSub()
    	KBJGroupOrder_LegionNH_StarAugur:Show()
    elseif item == "Elisande" then
    	ClearFrameSub()
    	KBJGroupOrder_LegionNH_Elisande:Show()
    elseif item == "Guldan" then
    	ClearFrameSub()
		KBJGroupOrder_LegionNH_Guldan:Show()
    end
end

-- Main Frame ---------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local mainFrame = CreateFrame('Frame', 'KBJGroupOrder', UIParent)
mainFrame:SetSize(100, 178)
mainFrame:SetPoint(position_Align, UIParent, position_REF, position_X, position_Y)

local btnSAY = CreateButton(mainFrame, 25, 22, 'TOPLEFT', mainFrame, 'TOPRIGHT', 1, 0, "S")
btnSAY:SetScript("OnClick", function() chatType = "SAY" end)
local btnPARTY = CreateButton(mainFrame, 25, 22, 'TOP', btnSAY, 'BOTTOM', 0, 1, "P")
btnPARTY:SetScript("OnClick", function() chatType = "PARTY" end)
local btnINSTANCE = CreateButton(mainFrame, 25, 22, 'TOP', btnSAY, 'BOTTOM', 0, 1, "I")
btnINSTANCE:SetScript("OnClick", function() chatType = "INSTANCE_CHAT" end)
local btnRAID = CreateButton(mainFrame, 25, 22, 'TOP', btnINSTANCE, 'BOTTOM', 0, 1, "R")
btnRAID:SetScript("OnClick", function() chatType = "RAID_WARNING" end)

local btnPullA = CreateButton(mainFrame, 48, 22, 'TOPLEFT', mainFrame, 'TOPLEFT', 0, 0, "3초 풀")
btnPullA:SetScript("OnClick", function() SetPulling(3) end)
local btnPullB = CreateButton(mainFrame, 25, 22, 'LEFT', btnPullA, 'RIGHT', 1, 0, "5")
btnPullB:SetScript("OnClick", function() SetPulling(5) end)
local btnPullC = CreateButton(mainFrame, 25, 22, 'LEFT', btnPullB, 'RIGHT', 1, 0, "10")
btnPullC:SetScript("OnClick", function() SetPulling(10) end)
local btnCallLust = CreateButton(mainFrame, 100, 22, 'TOPLEFT', btnPullA, 'BOTTOMLEFT', 0, -2, "영웅심!")
btnCallLust:SetScript("OnClick", function() SendChatMessage("Lust!!!", chatType) end)

local btnWaitHereMark = CreateFrame('Button', 'btnWaitHereMark', mainFrame, 'SecureActionButtonTemplate, OptionsButtonTemplate')
btnWaitHereMark:SetSize(22, 22)
btnWaitHereMark:SetPoint('TOPLEFT', btnCallLust, 'BOTTOMLEFT', 0, -8)
btnWaitHereMark:SetText("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:12:12|t")
btnWaitHereMark:SetAttribute("type", "macro")
btnWaitHereMark:SetAttribute("macrotext", "/wm 1")
local btnWaitHere = CreateButton(mainFrame, 77, 22, 'LEFT', btnWaitHereMark, 'RIGHT', 1, 0, "에서 기다려")
btnWaitHere:SetScript("OnClick", function() SendChatMessage("Wait on Blue{네모} for LOS", chatType) end)

local btnMove = CreateButton(mainFrame, 100, 22, 'TOPLEFT', btnWaitHereMark, 'BOTTOMLEFT', 0, -2, "오렌지를 따라와")
btnMove:SetScript("OnClick", function() SendChatMessage("Follow Orange{동그라미}", chatType) end)
local btnStack = CreateButton(mainFrame, 100, 22, 'TOP', btnMove, 'BOTTOM', 0, -2, "오렌지에게 모여")
btnStack:SetScript("OnClick", function() SendChatMessage("Stack on Orange{동그라미}", chatType) end)
local btnBack = CreateButton(mainFrame, 100, 22, 'TOP', btnStack, 'BOTTOM', 0, -2, "물러서")
btnBack:SetScript("OnClick", function() SendChatMessage("Stay Back!!", chatType) end)
local btnSelect = CreateButton(mainFrame, 100, 22, 'TOP', btnBack, 'BOTTOM', 0, -8, "브리핑 세트")
btnSelect:SetScript("OnClick", OnClick_btnSelect)

-- List Frame ---------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local selectType = CreateFrame('Frame', 'KBJGroupOrder_Type', UIParent)
selectType:SetSize(100, 94)
selectType:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local GO_selectType = {}
for i = 1, #GroupOrderType do
    GO_selectType[i] = CreateFrame('Button', 'GO_selectType'..i, selectType, 'OptionsButtonTemplate')
    GO_selectType[i]:SetSize(100, 22)
    GO_selectType[i]:SetText(GroupOrderType[i])
    GO_selectType[i]:SetScript("OnClick", function() OnClick_btnSelectType(GroupOrderType[i]) end)

    if i == 1 then GO_selectType[i]:SetPoint('TOP', selectType, 'TOP', 0, 0)
    else GO_selectType[i]:SetPoint('TOP', GO_selectType[i-1], 'BOTTOM', 0, -2)
    end
end

local selectKeyStone = CreateFrame('Frame', 'KBJGroupOrder_KeyStone', UIParent)
selectKeyStone:SetSize(100, (24 * #GroupOrderTypeData["Keystone"]) - 2)
selectKeyStone:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local KeyStone = {}
for i = 1, #GroupOrderTypeData["Keystone"] do
    KeyStone[i] = CreateFrame('Button', 'btnKeyStone'..i, selectKeyStone, 'OptionsButtonTemplate')
    KeyStone[i]:SetSize(100, 22)
    KeyStone[i]:SetText(GroupOrderTypeData["Keystone"][i].name)
    KeyStone[i]:SetScript("OnClick", function() SendChatMessage(GroupOrderTypeData["Keystone"][i].msg, chatType) end)

    if i == 1 then KeyStone[i]:SetPoint('TOP', selectKeyStone, 'TOP', 0, 0)
    else KeyStone[i]:SetPoint('TOP', KeyStone[i-1], 'BOTTOM', 0, -2)
    end
end

local selectLegionNH = CreateFrame('Frame', 'KBJGroupOrder_LegionNH', UIParent)
selectLegionNH:SetSize(100, (24 * #GroupOrderTypeData["Nighthold"]) - 2)
selectLegionNH:SetPoint('TOP', mainFrame, 'BOTTOM', 0, -8)

local LegionNH = {}
for i = 1, #GroupOrderTypeData["Nighthold"] do
    LegionNH[i] = CreateFrame('Button', 'btnLegionNH'..i, selectLegionNH, 'OptionsButtonTemplate')
    LegionNH[i]:SetSize(100, 22)
    LegionNH[i]:SetText(GroupOrderTypeData["Nighthold"][i])
    LegionNH[i]:SetScript("OnClick", function() OnClick_btnSelectLegionNH(GroupOrderTypeData["Nighthold"][i]) end)

    if i == 1 then LegionNH[i]:SetPoint('TOP', selectLegionNH, 'TOP', 0, 0)
    else LegionNH[i]:SetPoint('TOP', LegionNH[i-1], 'BOTTOM', 0, -2)
    end
end

-- Mech Frame ---------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Skorpyron
local selectLegionNH_Skorpyron = CreateFrame('Frame', 'KBJGroupOrder_LegionNH_Skorpyron', UIParent)
selectLegionNH_Skorpyron:SetSize(80, 178)
selectLegionNH_Skorpyron:SetPoint('TOPRIGHT', mainFrame, 'TOPLEFT', -4, 0)

local selectLegionNH_Skorpyron_BriefN = CreateButton(selectLegionNH_Skorpyron, 80, 22, 'TOP', selectLegionNH_Skorpyron, 'TOP', 0, 0, "Brief N")
selectLegionNH_Skorpyron_BriefN:SetScript("OnClick", function() OutputBrief("Skorpyron", 1) end)
local selectLegionNH_Skorpyron_BriefH = CreateButton(selectLegionNH_Skorpyron, 80, 22, 'TOP', selectLegionNH_Skorpyron_BriefN, 'BOTTOM', 0, -2, "Brief H")
selectLegionNH_Skorpyron_BriefH:SetScript("OnClick", function() OutputBrief("Skorpyron", 2) end)
local selectLegionNH_Skorpyron_BriefM = CreateButton(selectLegionNH_Skorpyron, 80, 22, 'TOP', selectLegionNH_Skorpyron_BriefH, 'BOTTOM', 0, -2, "Brief M")
selectLegionNH_Skorpyron_BriefM:SetScript("OnClick", function() OutputBrief("Skorpyron", 3) end)

local selectLegionNH_Skorpyron_Blast = CreateButton(selectLegionNH_Skorpyron, 80, 22, 'TOP', selectLegionNH_Skorpyron_BriefM, 'BOTTOM', 0, -8, "Blast")
selectLegionNH_Skorpyron_Blast:SetScript("OnClick", function() SendChatMessage("Avoid |cff71d5ff|Hspell:204483:0|h[Focused Blast]|h|r!", chatType) end)
local selectLegionNH_Skorpyron_Shockwave = CreateButton(selectLegionNH_Skorpyron, 80, 22, 'TOP', selectLegionNH_Skorpyron_Blast, 'BOTTOM', 0, -2, "Shockwave")
selectLegionNH_Skorpyron_Shockwave:SetScript("OnClick", function() SendChatMessage("Income |cff71d5ff|Hspell:204316:0|h[Shockwave]|h|r! Hide behind the broken shard!!", chatType) end)

-- Chronomatic
local selectLegionNH_Chronomatic = CreateFrame('Frame', 'KBJGroupOrder_LegionNH_Chronomatic', UIParent)
selectLegionNH_Chronomatic:SetSize(80, 178)
selectLegionNH_Chronomatic:SetPoint('TOPRIGHT', mainFrame, 'TOPLEFT', -4, 0)

local selectLegionNH_Chronomatic_BriefN = CreateButton(selectLegionNH_Chronomatic, 80, 22, 'TOP', selectLegionNH_Chronomatic, 'TOP', 0, 0, "Brief N")
selectLegionNH_Chronomatic_BriefN:SetScript("OnClick", function() OutputBrief("Chronomatic", 1) end)
local selectLegionNH_Chronomatic_BriefH = CreateButton(selectLegionNH_Chronomatic, 80, 22, 'TOP', selectLegionNH_Chronomatic_BriefN, 'BOTTOM', 0, -2, "Brief H")
selectLegionNH_Chronomatic_BriefH:SetScript("OnClick", function() OutputBrief("Chronomatic", 2) end)
local selectLegionNH_Chronomatic_BriefM = CreateButton(selectLegionNH_Chronomatic, 80, 22, 'TOP', selectLegionNH_Chronomatic_BriefH, 'BOTTOM', 0, -2, "Brief M")
selectLegionNH_Chronomatic_BriefM:SetScript("OnClick", function() OutputBrief("Chronomatic", 3) end)

local selectLegionNH_Chronomatic_orderHealA = CreateInput(selectLegionNH_Chronomatic, 71, 22, 'TOP', selectLegionNH_Chronomatic_BriefM, 'BOTTOM', 3, -8, "1st")
local selectLegionNH_Chronomatic_orderHealB = CreateInput(selectLegionNH_Chronomatic, 71, 22, 'TOP', selectLegionNH_Chronomatic_orderHealA, 'BOTTOM', 0, -2, "2nd")
local selectLegionNH_Chronomatic_orderHealC = CreateInput(selectLegionNH_Chronomatic, 71, 22, 'TOP', selectLegionNH_Chronomatic_orderHealB, 'BOTTOM', 0, -2, "3rd")
local selectLegionNH_Chronomatic_orderHealD = CreateInput(selectLegionNH_Chronomatic, 71, 22, 'TOP', selectLegionNH_Chronomatic_orderHealC, 'BOTTOM', 0, -2, "4rd")

local selectLegionNH_Chronomatic_orderActHealA = CreateButton(selectLegionNH_Chronomatic, 40, 22, 'RIGHT', selectLegionNH_Chronomatic_orderHealA, 'LEFT', -9, 0, "Act")
selectLegionNH_Chronomatic_orderActHealA:SetScript("OnClick", function() SendChatMessage(selectLegionNH_Chronomatic_orderHealA:GetText()..", Cooldowns UP plz!!!!", chatType) end) 
local selectLegionNH_Chronomatic_orderActHealB = CreateButton(selectLegionNH_Chronomatic, 40, 22, 'RIGHT', selectLegionNH_Chronomatic_orderHealB, 'LEFT', -9, 0, "Act")
selectLegionNH_Chronomatic_orderActHealB:SetScript("OnClick", function() SendChatMessage(selectLegionNH_Chronomatic_orderHealB:GetText()..", Cooldowns UP plz!!!!", chatType) end) 
local selectLegionNH_Chronomatic_orderActHealC = CreateButton(selectLegionNH_Chronomatic, 40, 22, 'RIGHT', selectLegionNH_Chronomatic_orderHealC, 'LEFT', -9, 0, "Act")
selectLegionNH_Chronomatic_orderActHealC:SetScript("OnClick", function() SendChatMessage(selectLegionNH_Chronomatic_orderHealC:GetText()..", Cooldowns UP plz!!!!", chatType) end) 
local selectLegionNH_Chronomatic_orderActHealD = CreateButton(selectLegionNH_Chronomatic, 40, 22, 'RIGHT', selectLegionNH_Chronomatic_orderHealD, 'LEFT', -9, 0, "Act")
selectLegionNH_Chronomatic_orderActHealD:SetScript("OnClick", function() SendChatMessage(selectLegionNH_Chronomatic_orderHealD:GetText()..", Cooldowns UP plz!!!!", chatType) end) 

local selectLegionNH_Chronomatic_orderBriefHealA = CreateButton(selectLegionNH_Chronomatic, 22, 22, 'RIGHT', selectLegionNH_Chronomatic_orderActHealA, 'LEFT', -1, 0, "B")
selectLegionNH_Chronomatic_orderBriefHealA:SetScript("OnClick", function() SendChatMessage("1st Healing CD : "..selectLegionNH_Chronomatic_orderHealA:GetText(), chatType) end) 
local selectLegionNH_Chronomatic_orderBriefHealB = CreateButton(selectLegionNH_Chronomatic, 22, 22, 'RIGHT', selectLegionNH_Chronomatic_orderActHealB, 'LEFT', -1, 0, "B")
selectLegionNH_Chronomatic_orderBriefHealB:SetScript("OnClick", function() SendChatMessage("2nd Healing CD : "..selectLegionNH_Chronomatic_orderHealB:GetText(), chatType) end) 
local selectLegionNH_Chronomatic_orderBriefHealC = CreateButton(selectLegionNH_Chronomatic, 22, 22, 'RIGHT', selectLegionNH_Chronomatic_orderActHealC, 'LEFT', -1, 0, "B")
selectLegionNH_Chronomatic_orderBriefHealC:SetScript("OnClick", function() SendChatMessage("3rd Healing CD : "..selectLegionNH_Chronomatic_orderHealC:GetText(), chatType) end) 
local selectLegionNH_Chronomatic_orderBriefHealD = CreateButton(selectLegionNH_Chronomatic, 22, 22, 'RIGHT', selectLegionNH_Chronomatic_orderActHealD, 'LEFT', -1, 0, "B")
selectLegionNH_Chronomatic_orderBriefHealD:SetScript("OnClick", function() SendChatMessage("4rd Healing CD : "..selectLegionNH_Chronomatic_orderHealD:GetText(), chatType) end) 

local selectLegionNH_Chronomatic_moveAdd = CreateButton(selectLegionNH_Chronomatic, 80, 22, 'TOP', selectLegionNH_Chronomatic_orderHealD, 'BOTTOM', -3, -8, "Move Add")
selectLegionNH_Chronomatic_moveAdd:SetScript("OnClick", function() SendChatMessage("Tank, Move to Add!", chatType) end)
local selectLegionNH_Chronomatic_stackMoon = CreateButton(selectLegionNH_Chronomatic, 80, 22, 'TOP', selectLegionNH_Chronomatic_moveAdd, 'BOTTOM', 0, -2, "Stack |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:12:12|t")
selectLegionNH_Chronomatic_stackMoon:SetScript("OnClick", function() SendChatMessage("Stack on Moon{달} for healer's cooldowns spell", chatType) end)

-- Trilliax
local selectLegionNH_Trilliax = CreateFrame('Frame', 'KBJGroupOrder_LegionNH_Trilliax', UIParent)
selectLegionNH_Trilliax:SetSize(80, 178)
selectLegionNH_Trilliax:SetPoint('TOPRIGHT', mainFrame, 'TOPLEFT', -4, 0)

local selectLegionNH_Trilliax_BriefN = CreateButton(selectLegionNH_Trilliax, 80, 22, 'TOP', selectLegionNH_Trilliax, 'TOP', 0, 0, "Brief N")
selectLegionNH_Trilliax_BriefN:SetScript("OnClick", function() OutputBrief("Trilliax", 1) end)
local selectLegionNH_Trilliax_BriefH = CreateButton(selectLegionNH_Trilliax, 80, 22, 'TOP', selectLegionNH_Trilliax_BriefN, 'BOTTOM', 0, -2, "Brief H")
selectLegionNH_Trilliax_BriefH:SetScript("OnClick", function() OutputBrief("Trilliax", 2) end)
local selectLegionNH_Trilliax_BriefM = CreateButton(selectLegionNH_Trilliax, 80, 22, 'TOP', selectLegionNH_Trilliax_BriefH, 'BOTTOM', 0, -2, "Brief M")
selectLegionNH_Trilliax_BriefM:SetScript("OnClick", function() OutputBrief("Trilliax", 3) end)

local selectLegionNH_Trilliax_Cake = CreateButton(selectLegionNH_Trilliax, 80, 22, 'TOPLEFT', selectLegionNH_Trilliax_BriefM, 'BOTTOMLEFT', 0, -8, "CAKE")
selectLegionNH_Trilliax_Cake:SetScript("OnClick", function() SendChatMessage("EAT CAKE!!", chatType) end)
local selectLegionNH_Trilliax_Soak = CreateButton(selectLegionNH_Trilliax, 80, 22, 'TOPLEFT', selectLegionNH_Trilliax_Cake, 'BOTTOMLEFT', 0, -2, "SOAK")
selectLegionNH_Trilliax_Soak:SetScript("OnClick", function() SendChatMessage("Check and Soak the Scrubber!", chatType) end)
local selectLegionNH_Trilliax_Anni = CreateButton(selectLegionNH_Trilliax, 80, 22, 'TOPLEFT', selectLegionNH_Trilliax_Soak, 'BOTTOMLEFT', 0, -8, "Annihilation")
selectLegionNH_Trilliax_Anni:SetScript("OnClick", function() SendChatMessage("Income |cff71d5ff|Hspell:207630:0|h[Annihilation]|h|r. If u get Link, Move to the left-side of the boss", chatType) end)

-- Spellblade
local selectLegionNH_Spellblade = CreateFrame('Frame', 'KBJGroupOrder_LegionNH_Spellblade', UIParent)
selectLegionNH_Spellblade:SetSize(80, 178)
selectLegionNH_Spellblade:SetPoint('TOPRIGHT', mainFrame, 'TOPLEFT', -4, 0)

local selectLegionNH_Spellblade_BriefN = CreateButton(selectLegionNH_Spellblade, 80, 22, 'TOP', selectLegionNH_Spellblade, 'TOP', 0, 0, "Brief N")
selectLegionNH_Spellblade_BriefN:SetScript("OnClick", function() OutputBrief("Spellblade", 1) end)
local selectLegionNH_Spellblade_BriefH = CreateButton(selectLegionNH_Spellblade, 80, 22, 'TOP', selectLegionNH_Spellblade_BriefN, 'BOTTOM', 0, -2, "Brief H")
selectLegionNH_Spellblade_BriefH:SetScript("OnClick", function() OutputBrief("Spellblade", 2) end)
local selectLegionNH_Spellblade_BriefM = CreateButton(selectLegionNH_Spellblade, 80, 22, 'TOP', selectLegionNH_Spellblade_BriefH, 'BOTTOM', 0, -2, "Brief M")
selectLegionNH_Spellblade_BriefM:SetScript("OnClick", function() OutputBrief("Spellblade", 3) end)

local selectLegionNH_Spellblade_frostOut = CreateButton(selectLegionNH_Spellblade, 80, 22, 'TOP', selectLegionNH_Spellblade_BriefM, 'BOTTOM', 0, -8, "1:Out!")
selectLegionNH_Spellblade_frostOut:SetScript("OnClick", function() SendChatMessage("Move to the rainbow worldmark when got |cff71d5ff|Hspell:212587:0|h[Mark of Frost]|h|r", chatType) end)
local selectLegionNH_Spellblade_fireApart = CreateButton(selectLegionNH_Spellblade, 80, 22, 'TOP', selectLegionNH_Spellblade_frostOut, 'BOTTOM', 0, -8, "2:Apart")
selectLegionNH_Spellblade_fireApart:SetScript("OnClick", function() SendChatMessage("Fire Spawnner, 8 yards apart!", chatType) end)
local selectLegionNH_Spellblade_fireKick = CreateButton(selectLegionNH_Spellblade, 80, 22, 'TOP', selectLegionNH_Spellblade_fireApart, 'BOTTOM', 0, -2, "2:Kick!")
selectLegionNH_Spellblade_fireKick:SetScript("OnClick", function() SendChatMessage("Kill adds and interrupt the |cff71d5ff|Hspell:213281:0|h[Pyroblast]|h|r", chatType) end)
local selectLegionNH_Spellblade_arcaneStack = CreateButton(selectLegionNH_Spellblade, 80, 22, 'TOP', selectLegionNH_Spellblade_fireKick, 'BOTTOM', 0, -8, "3:Stack")
selectLegionNH_Spellblade_arcaneStack:SetScript("OnClick", function() SendChatMessage("Stack on Moon{달} worldmark", chatType) end)
local selectLegionNH_Spellblade_arcaneDCDs = CreateButton(selectLegionNH_Spellblade, 80, 22, 'TOP', selectLegionNH_Spellblade_arcaneStack, 'BOTTOM', 0, -2, "3:DCDs")
selectLegionNH_Spellblade_arcaneDCDs:SetScript("OnClick", function() SendChatMessage("Using you're Deffense CD", chatType) end)

-- Tichondrius
local selectLegionNH_Tichondrius = CreateFrame('Frame', 'KBJGroupOrder_LegionNH_Tichondrius', UIParent)
selectLegionNH_Tichondrius:SetSize(80, 178)
selectLegionNH_Tichondrius:SetPoint('TOPRIGHT', mainFrame, 'TOPLEFT', -4, 0)

local selectLegionNH_Tichondrius_BriefN = CreateButton(selectLegionNH_Tichondrius, 80, 22, 'TOP', selectLegionNH_Tichondrius, 'TOP', 0, 0, "Brief N")
selectLegionNH_Tichondrius_BriefN:SetScript("OnClick", function() OutputBrief("Tichondrius", 1) end)
local selectLegionNH_Tichondrius_BriefH = CreateButton(selectLegionNH_Tichondrius, 80, 22, 'TOP', selectLegionNH_Tichondrius_BriefN, 'BOTTOM', 0, -2, "Brief H")
selectLegionNH_Tichondrius_BriefH:SetScript("OnClick", function() OutputBrief("Tichondrius", 2) end)
local selectLegionNH_Tichondrius_BriefM = CreateButton(selectLegionNH_Tichondrius, 80, 22, 'TOP', selectLegionNH_Tichondrius_BriefH, 'BOTTOM', 0, -2, "Brief M")
selectLegionNH_Tichondrius_BriefM:SetScript("OnClick", function() OutputBrief("Tichondrius", 3) end)

local selectLegionNH_Tichondrius_movePlague = CreateButton(selectLegionNH_Tichondrius, 80, 22, 'TOP', selectLegionNH_Tichondrius_BriefM, 'BOTTOM', 0, -8, "Move |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:12:12|t")
selectLegionNH_Tichondrius_movePlague:SetScript("OnClick", function() SendChatMessage("Plague on purple side", chatType) end)
local selectLegionNH_Tichondrius_spreadPlague = CreateButton(selectLegionNH_Tichondrius, 80, 22, 'TOP', selectLegionNH_Tichondrius_movePlague, 'BOTTOM', 0, -2, "Inc Bat")
selectLegionNH_Tichondrius_spreadPlague:SetScript("OnClick", function() SendChatMessage("Income |cff71d5ff|Hspell:213238:0|h[Seeker Swarm]|h|r! Spread plague group! NEVER DUMP BRAND THIS TIME!!", chatType) end)
local selectLegionNH_Tichondrius_killAdd = CreateButton(selectLegionNH_Tichondrius, 80, 22, 'TOP', selectLegionNH_Tichondrius_spreadPlague, 'BOTTOM', 0, -2, "Kill Add")
selectLegionNH_Tichondrius_killAdd:SetScript("OnClick", function() SendChatMessage("Kill adds quickly!!", chatType) end)
local selectLegionNH_Tichondrius_dumpBrand = CreateButton(selectLegionNH_Tichondrius, 80, 22, 'TOP', selectLegionNH_Tichondrius_killAdd, 'BOTTOM', 0, -8, "Dump Brand")
selectLegionNH_Tichondrius_dumpBrand:SetScript("OnClick", function() SendChatMessage("Brand guy, Dump on group", chatType) end)
local selectLegionNH_Tichondrius_stackCenter = CreateButton(selectLegionNH_Tichondrius, 80, 22, 'TOP', selectLegionNH_Tichondrius_dumpBrand, 'BOTTOM', 0, -8, "Night")
selectLegionNH_Tichondrius_stackCenter:SetScript("OnClick", function() SendChatMessage("Stack on center but dodge |cff71d5ff|Hspell:215988:0|h[Carrion Nightmare]|h|r", chatType) end)

-- Krosus
local selectLegionNH_Krosus = CreateFrame('Frame', 'KBJGroupOrder_LegionNH_Krosus', UIParent)
selectLegionNH_Krosus:SetSize(80, 178)
selectLegionNH_Krosus:SetPoint('TOPRIGHT', mainFrame, 'TOPLEFT', -4, 0)

local selectLegionNH_Krosus_BriefN = CreateButton(selectLegionNH_Krosus, 80, 22, 'TOP', selectLegionNH_Krosus, 'TOP', 0, 0, "Brief N")
selectLegionNH_Krosus_BriefN:SetScript("OnClick", function() OutputBrief("Krosus", 1) end)
local selectLegionNH_Krosus_BriefH = CreateButton(selectLegionNH_Krosus, 80, 22, 'TOP', selectLegionNH_Krosus_BriefN, 'BOTTOM', 0, -2, "Brief H")
selectLegionNH_Krosus_BriefH:SetScript("OnClick", function() OutputBrief("Krosus", 2) end)
local selectLegionNH_Krosus_BriefM = CreateButton(selectLegionNH_Krosus, 80, 22, 'TOP', selectLegionNH_Krosus_BriefH, 'BOTTOM', 0, -2, "Brief M")
selectLegionNH_Krosus_BriefM:SetScript("OnClick", function() OutputBrief("Krosus", 3) end)

local selectLegionNH_Krosus_moveLEFT = CreateButton(selectLegionNH_Krosus, 39, 22, 'TOPLEFT', selectLegionNH_Krosus_BriefM, 'BOTTOMLEFT', 0, -8, "<<")
selectLegionNH_Krosus_moveLEFT:SetScript("OnClick", function() SendChatMessage("<<< Move to the Left", chatType) end)
local selectLegionNH_Krosus_moveRIGHT = CreateButton(selectLegionNH_Krosus, 39, 22, 'LEFT', selectLegionNH_Krosus_moveLEFT, 'RIGHT', 2, 0, ">>")
selectLegionNH_Krosus_moveRIGHT:SetScript("OnClick", function() SendChatMessage(">>> Move to the Right", chatType) end)

local selectLegionNH_Krosus_breakBridge = CreateButton(selectLegionNH_Krosus, 80, 22, 'TOPLEFT', selectLegionNH_Krosus_moveLEFT, 'BOTTOMLEFT', 0, -8, "Bridge")
selectLegionNH_Krosus_breakBridge:SetScript("OnClick", function() SendChatMessage("Break the Bridge! MOVE BACK!", chatType) end)
local selectLegionNH_Krosus_incOrb = CreateButton(selectLegionNH_Krosus, 80, 22, 'TOP', selectLegionNH_Krosus_breakBridge, 'BOTTOM', 0, -2, "Orb")
selectLegionNH_Krosus_incOrb:SetScript("OnClick", function() SendChatMessage("Income |cff71d5ff|Hspell:205361:0|h[Orb of Destruction]|h|r! Check yourself!", chatType) end)
local selectLegionNH_Krosus_incPitch = CreateButton(selectLegionNH_Krosus, 80, 22, 'TOP', selectLegionNH_Krosus_incOrb, 'BOTTOM', 0, -2, "Pitch")
selectLegionNH_Krosus_incPitch:SetScript("OnClick", function() SendChatMessage("Income |cff71d5ff|Hspell:205420:0|h[Burning Pitch]|h|r! Check your position!", chatType) end)
local selectLegionNH_Krosus_killAdd = CreateButton(selectLegionNH_Krosus, 80, 22, 'TOP', selectLegionNH_Krosus_incPitch, 'BOTTOM', 0, -2, "Kill Adds")
selectLegionNH_Krosus_killAdd:SetScript("OnClick", function() SendChatMessage("Kill Adds! Quickly! but be careful if income beam!", chatType) end)

-- Botanist
local selectLegionNH_Botanist = CreateFrame('Frame', 'KBJGroupOrder_LegionNH_Botanist', UIParent)
selectLegionNH_Botanist:SetSize(80, 178)
selectLegionNH_Botanist:SetPoint('TOPRIGHT', mainFrame, 'TOPLEFT', -4, 0)

local selectLegionNH_Botanist_BriefN = CreateButton(selectLegionNH_Botanist, 80, 22, 'TOP', selectLegionNH_Botanist, 'TOP', 0, 0, "Brief N")
selectLegionNH_Botanist_BriefN:SetScript("OnClick", function() OutputBrief("Botanist", 1) end)
local selectLegionNH_Botanist_BriefH = CreateButton(selectLegionNH_Botanist, 80, 22, 'TOP', selectLegionNH_Botanist_BriefN, 'BOTTOM', 0, -2, "Brief H")
selectLegionNH_Botanist_BriefH:SetScript("OnClick", function() OutputBrief("Botanist", 2) end)
local selectLegionNH_Botanist_BriefM = CreateButton(selectLegionNH_Botanist, 80, 22, 'TOP', selectLegionNH_Botanist_BriefH, 'BOTTOM', 0, -2, "Brief M")
selectLegionNH_Botanist_BriefM:SetScript("OnClick", function() OutputBrief("Botanist", 3) end)

local selectLegionNH_Botanist_orderDispel = CreateInput(selectLegionNH_Botanist, 71, 22, 'TOP', selectLegionNH_Botanist_BriefM, 'BOTTOM', 3, -8, "Dispel")
local selectLegionNH_Botanist_orderActDispel = CreateButton(selectLegionNH_Botanist, 40, 22, 'RIGHT', selectLegionNH_Botanist_orderDispel, 'LEFT', -9, 0, "Act")
selectLegionNH_Botanist_orderActDispel:SetScript("OnClick", function() SendChatMessage(selectLegionNH_Botanist_orderDispel:GetText()..", Dispel Lasher NOW!!", chatType) end)
local selectLegionNH_Botanist_orderBriefDispel = CreateButton(selectLegionNH_Botanist, 22, 22, 'RIGHT', selectLegionNH_Botanist_orderActDispel, 'LEFT', -1, 0, "B")
selectLegionNH_Botanist_orderBriefDispel:SetScript("OnClick", function() SendChatMessage("Dispel Lasher Healer : "..selectLegionNH_Botanist_orderDispel:GetText(), chatType) end) 
local selectLegionNH_Botanist_spreadLasher = CreateButton(selectLegionNH_Botanist, 80, 22, 'TOP', selectLegionNH_Botanist_orderDispel, 'BOTTOM', -3, -2, "Lasher")
selectLegionNH_Botanist_spreadLasher:SetScript("OnClick", function() SendChatMessage("Spreading form target of |cff71d5ff|Hspell:218424:0|h[Parasitic Fetter]|h|r", chatType) end)
local selectLegionNH_Botanist_killLasher = CreateButton(selectLegionNH_Botanist, 40, 22, 'RIGHT', selectLegionNH_Botanist_spreadLasher, 'LEFT', -1, 0, "Kill")
selectLegionNH_Botanist_killLasher:SetScript("OnClick", function() SendChatMessage("Kill 'Parasitic Lasher' ! Quickly!", chatType) end)

local selectLegionNH_Botanist_orderSphere = CreateInput(selectLegionNH_Botanist, 71, 22, 'TOP', selectLegionNH_Botanist_spreadLasher, 'BOTTOM', 3, -8, "Sphere")
local selectLegionNH_Botanist_orderActSphere = CreateButton(selectLegionNH_Botanist, 40, 22, 'RIGHT', selectLegionNH_Botanist_orderSphere, 'LEFT', -9, 0, "Act")
selectLegionNH_Botanist_orderActSphere:SetScript("OnClick", function() SendChatMessage(selectLegionNH_Botanist_orderSphere:GetText()..", Kill Plasma Sphere!!", chatType) end) 
local selectLegionNH_Botanist_orderBriefSphere = CreateButton(selectLegionNH_Botanist, 22, 22, 'RIGHT', selectLegionNH_Botanist_orderActSphere, 'LEFT', -1, 0, "B")
selectLegionNH_Botanist_orderBriefSphere:SetScript("OnClick", function() SendChatMessage("Plasma Sphere DPS : "..selectLegionNH_Botanist_orderSphere:GetText(), chatType) end) 
local selectLegionNH_Botanist_moveOrange = CreateButton(selectLegionNH_Botanist, 26, 22, 'TOPLEFT', selectLegionNH_Botanist_orderSphere, 'BOTTOMLEFT', -7, -2, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:12:12|t")
selectLegionNH_Botanist_moveOrange:SetScript("OnClick", function() SendChatMessage("Tank, Move to the Orange{동그라미}", chatType) end)
local selectLegionNH_Botanist_moveBlue = CreateButton(selectLegionNH_Botanist, 26, 22, 'LEFT', selectLegionNH_Botanist_moveOrange, 'RIGHT', 1, 0, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:12:12|t")
selectLegionNH_Botanist_moveBlue:SetScript("OnClick", function() SendChatMessage("Tank, Move to the Blue{네모}", chatType) end)
local selectLegionNH_Botanist_moveRed = CreateButton(selectLegionNH_Botanist, 26, 22, 'LEFT', selectLegionNH_Botanist_moveBlue, 'RIGHT', 1, 0, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:12:12|t")
selectLegionNH_Botanist_moveRed:SetScript("OnClick", function() SendChatMessage("Tank, Move to the Red{가위표}", chatType) end)

local selectLegionNH_Botanist_callNight = CreateButton(selectLegionNH_Botanist, 80, 22, 'TOPLEFT', selectLegionNH_Botanist_moveOrange, 'BOTTOMLEFT', 0, -8, "Night")
selectLegionNH_Botanist_callNight:SetScript("OnClick", function() SendChatMessage("Stack on has |cff71d5ff|Hspell:218807:0|h[Call of Night]|h|r player if you are unmarked", chatType) end)

-- StarAugur
local selectLegionNH_StarAugur = CreateFrame('Frame', 'KBJGroupOrder_LegionNH_StarAugur', UIParent)
selectLegionNH_StarAugur:SetSize(80, 178)
selectLegionNH_StarAugur:SetPoint('TOPRIGHT', mainFrame, 'TOPLEFT', -4, 0)

local selectLegionNH_StarAugur_BriefN = CreateButton(selectLegionNH_StarAugur, 80, 22, 'TOP', selectLegionNH_StarAugur, 'TOP', 0, 0, "Brief N")
selectLegionNH_StarAugur_BriefN:SetScript("OnClick", function() OutputBrief("StarAugur", 1) end)
local selectLegionNH_StarAugur_BriefH = CreateButton(selectLegionNH_StarAugur, 80, 22, 'TOP', selectLegionNH_StarAugur_BriefN, 'BOTTOM', 0, -2, "Brief H")
selectLegionNH_StarAugur_BriefH:SetScript("OnClick", function() OutputBrief("StarAugur", 2) end)
local selectLegionNH_StarAugur_BriefM = CreateButton(selectLegionNH_StarAugur, 80, 22, 'TOP', selectLegionNH_StarAugur_BriefH, 'BOTTOM', 0, -2, "Brief M")
selectLegionNH_StarAugur_BriefM:SetScript("OnClick", function() OutputBrief("StarAugur", 3) end)

local selectLegionNH_StarAugur_stackGR = CreateButton(selectLegionNH_StarAugur, 80, 22, 'TOP', selectLegionNH_StarAugur_BriefM, 'BOTTOM', 0, -8, "Stack 1")
selectLegionNH_StarAugur_stackGR:SetScript("OnClick", function() SendChatMessage("Stack on your group", chatType) end)
local selectLegionNH_StarAugur_spreadNow = CreateButton(selectLegionNH_StarAugur, 80, 22, 'TOP', selectLegionNH_StarAugur_stackGR, 'BOTTOM', 0, -2, "Spread 2")
selectLegionNH_StarAugur_spreadNow:SetScript("OnClick", function() SendChatMessage("Spread for phase 2", chatType) end)
local selectLegionNH_StarAugur_killAdd = CreateButton(selectLegionNH_StarAugur, 80, 22, 'TOP', selectLegionNH_StarAugur_spreadNow, 'BOTTOM', 0, -2, "Kill Add")
selectLegionNH_StarAugur_killAdd:SetScript("OnClick", function() SendChatMessage("Kill Big Add! Quickly!", chatType) end)
local selectLegionNH_StarAugur_turnAdd = CreateButton(selectLegionNH_StarAugur, 80, 22, 'TOP', selectLegionNH_StarAugur_killAdd, 'BOTTOM', 0, -2, "Witness")
selectLegionNH_StarAugur_turnAdd:SetScript("OnClick", function() SendChatMessage("Income |cff71d5ff|Hspell:207720:0|h[Witness the Void]|h|r. Turn away from the big add!", chatType) end)

-- Elisande
local selectLegionNH_Elisande = CreateFrame('Frame', 'KBJGroupOrder_LegionNH_Elisande', UIParent)
selectLegionNH_Elisande:SetSize(80, 178)
selectLegionNH_Elisande:SetPoint('TOPRIGHT', mainFrame, 'TOPLEFT', -4, 0)

local selectLegionNH_Elisande_BriefN = CreateButton(selectLegionNH_Elisande, 80, 22, 'TOP', selectLegionNH_Elisande, 'TOP', 0, 0, "Brief N")
selectLegionNH_Elisande_BriefN:SetScript("OnClick", function() OutputBrief("Elisande", 1) end)
local selectLegionNH_Elisande_BriefH = CreateButton(selectLegionNH_Elisande, 80, 22, 'TOP', selectLegionNH_Elisande_BriefN, 'BOTTOM', 0, -2, "Brief H")
selectLegionNH_Elisande_BriefH:SetScript("OnClick", function() OutputBrief("Elisande", 2) end)
local selectLegionNH_Elisande_BriefM = CreateButton(selectLegionNH_Elisande, 80, 22, 'TOP', selectLegionNH_Elisande_BriefH, 'BOTTOM', 0, -2, "Brief M")
selectLegionNH_Elisande_BriefM:SetScript("OnClick", function() OutputBrief("Elisande", 3) end)

local selectLegionNH_Elisande_dontMove = CreateButton(selectLegionNH_Elisande, 80, 22, 'TOP', selectLegionNH_Elisande_BriefM, 'BOTTOM', 0, -8, "No Move")
selectLegionNH_Elisande_dontMove:SetScript("OnClick", function() SendChatMessage("Don't move when targeted |cff71d5ff|Hspell:214278:0|h[Delphuric Beam]|h|r", chatType) end)
local selectLegionNH_Elisande_soak = CreateButton(selectLegionNH_Elisande, 80, 22, 'TOP', selectLegionNH_Elisande_dontMove, 'BOTTOM', 0, -2, "Soak")
selectLegionNH_Elisande_soak:SetScript("OnClick", function() SendChatMessage("GR5 soak |cff71d5ff|Hspell:210022:0|h[Epocheric Orb]|h|r!!", chatType) end)
local selectLegionNH_Elisande_focusSkull = CreateButton(selectLegionNH_Elisande, 80, 22, 'TOP', selectLegionNH_Elisande_soak, 'BOTTOM', 0, -8, "Focus |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:12:12|t")
selectLegionNH_Elisande_focusSkull:SetScript("OnClick", function() SendChatMessage("FOCUS SKULL{해골}!!!!", chatType) end)

local selectLegionNH_Elisande_moveAdd = CreateButton(selectLegionNH_Elisande, 80, 22, 'TOP', selectLegionNH_Elisande_focusSkull, 'BOTTOM', 0, -8, "Move Add")
selectLegionNH_Elisande_moveAdd:SetScript("OnClick", function() SendChatMessage("Tank, Move to the 'Recursive Elementals' !!", chatType) end)
local selectLegionNH_Elisande_doubleRingA = CreateButton(selectLegionNH_Elisande, 39, 22, 'TOPLEFT', selectLegionNH_Elisande_moveAdd, 'BOTTOMLEFT', 0, -2, "1/2")
selectLegionNH_Elisande_doubleRingA:SetScript("OnClick", function() SendChatMessage("1st of Double Ring", chatType) end)
local selectLegionNH_Elisande_doubleRingB = CreateButton(selectLegionNH_Elisande, 39, 22, 'LEFT', selectLegionNH_Elisande_doubleRingA, 'RIGHT', 2, 0, "2/2")
selectLegionNH_Elisande_doubleRingB:SetScript("OnClick", function() SendChatMessage("2nd of Double Ring", chatType) end)
local selectLegionNH_Elisande_singleRing = CreateButton(selectLegionNH_Elisande, 39, 22, 'RIGHT', selectLegionNH_Elisande_doubleRingA, 'LEFT', -2, 0, "1")
selectLegionNH_Elisande_singleRing:SetScript("OnClick", function() SendChatMessage("Single Ring", chatType) end)

-- Guldan
local selectLegionNH_Guldan = CreateFrame('Frame', 'KBJGroupOrder_LegionNH_Guldan', UIParent)
selectLegionNH_Guldan:SetSize(80, 178)
selectLegionNH_Guldan:SetPoint('TOPRIGHT', mainFrame, 'TOPLEFT', -4, 0)

local selectLegionNH_Guldan_BriefN = CreateButton(selectLegionNH_Guldan, 80, 22, 'TOP', selectLegionNH_Guldan, 'TOP', 0, 0, "Brief N")
selectLegionNH_Guldan_BriefN:SetScript("OnClick", function() OutputBrief("Guldan", 1) end)
local selectLegionNH_Guldan_BriefH = CreateButton(selectLegionNH_Guldan, 80, 22, 'TOP', selectLegionNH_Guldan_BriefN, 'BOTTOM', 0, -2, "Brief H")
selectLegionNH_Guldan_BriefH:SetScript("OnClick", function() OutputBrief("Guldan", 2) end)
local selectLegionNH_Guldan_BriefM = CreateButton(selectLegionNH_Guldan, 80, 22, 'TOP', selectLegionNH_Guldan_BriefH, 'BOTTOM', 0, -2, "Brief M")
selectLegionNH_Guldan_BriefM:SetScript("OnClick", function() OutputBrief("Guldan", 3) end)

local selectLegionNH_Guldan_Efflux = CreateButton(selectLegionNH_Guldan, 80, 22, 'TOP', selectLegionNH_Guldan_BriefM, 'BOTTOM', 0, -8, "Efflux")
selectLegionNH_Guldan_Efflux:SetScript("OnClick", function() SendChatMessage("Income |cff71d5ff|Hspell:206514:0|h[Fel Efflux]|h|r!!", chatType) end)

local selectLegionNH_Guldan_orderInterruptA = CreateInput(selectLegionNH_Guldan, 71, 22, 'TOP', selectLegionNH_Guldan_Efflux, 'BOTTOM', 3, -8, "ranged")
local selectLegionNH_Guldan_orderInterruptB = CreateInput(selectLegionNH_Guldan, 71, 22, 'TOP', selectLegionNH_Guldan_orderInterruptA, 'BOTTOM', 0, -2, "melee")
local selectLegionNH_Guldan_orderInterruptC = CreateInput(selectLegionNH_Guldan, 71, 22, 'TOP', selectLegionNH_Guldan_orderInterruptB, 'BOTTOM', 0, -2, "other")

local selectLegionNH_Guldan_orderActInterruptA = CreateButton(selectLegionNH_Guldan, 40, 22, 'RIGHT', selectLegionNH_Guldan_orderInterruptA, 'LEFT', -9, 0, "Act")
selectLegionNH_Guldan_orderActInterruptA:SetScript("OnClick", function() SendChatMessage("Next interrupt to big add : "..selectLegionNH_Guldan_orderInterruptA:GetText(), chatType) end) 
local selectLegionNH_Guldan_orderActInterruptB = CreateButton(selectLegionNH_Guldan, 40, 22, 'RIGHT', selectLegionNH_Guldan_orderInterruptB, 'LEFT', -9, 0, "Act")
selectLegionNH_Guldan_orderActInterruptB:SetScript("OnClick", function() SendChatMessage("Next interrupt to big add : "..selectLegionNH_Guldan_orderInterruptB:GetText(), chatType) end) 
local selectLegionNH_Guldan_orderActInterruptC = CreateButton(selectLegionNH_Guldan, 40, 22, 'RIGHT', selectLegionNH_Guldan_orderInterruptC, 'LEFT', -9, 0, "Act")
selectLegionNH_Guldan_orderActInterruptC:SetScript("OnClick", function() SendChatMessage("Next interrupt to big add : "..selectLegionNH_Guldan_orderInterruptC:GetText(), chatType) end) 

local selectLegionNH_Guldan_orderBriefInterruptA = CreateButton(selectLegionNH_Guldan, 22, 22, 'RIGHT', selectLegionNH_Guldan_orderActInterruptA, 'LEFT', -1, 0, "B")
selectLegionNH_Guldan_orderBriefInterruptA:SetScript("OnClick", function() SendChatMessage("1st interrupt to big add : "..selectLegionNH_Guldan_orderInterruptA:GetText(), chatType) end) 
local selectLegionNH_Guldan_orderBriefInterruptB = CreateButton(selectLegionNH_Guldan, 22, 22, 'RIGHT', selectLegionNH_Guldan_orderActInterruptB, 'LEFT', -1, 0, "B")
selectLegionNH_Guldan_orderBriefInterruptB:SetScript("OnClick", function() SendChatMessage("2nd interrupt to big add : "..selectLegionNH_Guldan_orderInterruptB:GetText(), chatType) end) 
local selectLegionNH_Guldan_orderBriefInterruptC = CreateButton(selectLegionNH_Guldan, 22, 22, 'RIGHT', selectLegionNH_Guldan_orderActInterruptC, 'LEFT', -1, 0, "B")
selectLegionNH_Guldan_orderBriefInterruptC:SetScript("OnClick", function() SendChatMessage("3rd interrupt to big add : "..selectLegionNH_Guldan_orderInterruptC:GetText(), chatType) end) 

local selectLegionNH_Guldan_Bonds = CreateButton(selectLegionNH_Guldan, 80, 22, 'TOP', selectLegionNH_Guldan_orderInterruptC, 'BOTTOM', -3, -2, "Bonds")
selectLegionNH_Guldan_Bonds:SetScript("OnClick", function() SendChatMessage("Help to Bonds!!!", chatType) end)
local selectLegionNH_Guldan_Eyes = CreateButton(selectLegionNH_Guldan, 80, 22, 'TOP', selectLegionNH_Guldan_Bonds, 'BOTTOM', 0, -2, "Eyes")
selectLegionNH_Guldan_Eyes:SetScript("OnClick", function() SendChatMessage("Kill Eyes! Quickly!", chatType) end)
local selectLegionNH_Guldan_stayAway = CreateButton(selectLegionNH_Guldan, 40, 46, 'TOPRIGHT', selectLegionNH_Guldan_Bonds, 'TOPLEFT', -2, 0, "Stay\nAway")
selectLegionNH_Guldan_stayAway:SetScript("OnClick", function() SendChatMessage("Stay away from tank!", chatType) end)

local selectLegionNH_Guldan_orderHealA = CreateInput(selectLegionNH_Guldan, 71, 22, 'TOP', selectLegionNH_Guldan_Eyes, 'BOTTOM', 3, -2, "1st")
local selectLegionNH_Guldan_orderHealB = CreateInput(selectLegionNH_Guldan, 71, 22, 'TOP', selectLegionNH_Guldan_orderHealA, 'BOTTOM', 0, -2, "2nd")
local selectLegionNH_Guldan_orderHealC = CreateInput(selectLegionNH_Guldan, 71, 22, 'TOP', selectLegionNH_Guldan_orderHealB, 'BOTTOM', 0, -2, "3rd")
local selectLegionNH_Guldan_orderHealD = CreateInput(selectLegionNH_Guldan, 71, 22, 'TOP', selectLegionNH_Guldan_orderHealC, 'BOTTOM', 0, -2, "4rd")

local selectLegionNH_Guldan_orderActHealA = CreateButton(selectLegionNH_Guldan, 40, 22, 'RIGHT', selectLegionNH_Guldan_orderHealA, 'LEFT', -9, 0, "Act")
selectLegionNH_Guldan_orderActHealA:SetScript("OnClick", function() SendChatMessage(selectLegionNH_Guldan_orderHealA:GetText()..", Cooldowns UP plz!!!!", chatType) end) 
local selectLegionNH_Guldan_orderActHealB = CreateButton(selectLegionNH_Guldan, 40, 22, 'RIGHT', selectLegionNH_Guldan_orderHealB, 'LEFT', -9, 0, "Act")
selectLegionNH_Guldan_orderActHealB:SetScript("OnClick", function() SendChatMessage(selectLegionNH_Guldan_orderHealB:GetText()..", Cooldowns UP plz!!!!", chatType) end) 
local selectLegionNH_Guldan_orderActHealC = CreateButton(selectLegionNH_Guldan, 40, 22, 'RIGHT', selectLegionNH_Guldan_orderHealC, 'LEFT', -9, 0, "Act")
selectLegionNH_Guldan_orderActHealC:SetScript("OnClick", function() SendChatMessage(selectLegionNH_Guldan_orderHealC:GetText()..", Cooldowns UP plz!!!!", chatType) end) 
local selectLegionNH_Guldan_orderActHealD = CreateButton(selectLegionNH_Guldan, 40, 22, 'RIGHT', selectLegionNH_Guldan_orderHealD, 'LEFT', -9, 0, "Act")
selectLegionNH_Guldan_orderActHealD:SetScript("OnClick", function() SendChatMessage(selectLegionNH_Guldan_orderHealD:GetText()..", Cooldowns UP plz!!!!", chatType) end) 

local selectLegionNH_Guldan_orderBriefHealA = CreateButton(selectLegionNH_Guldan, 22, 22, 'RIGHT', selectLegionNH_Guldan_orderActHealA, 'LEFT', -1, 0, "B")
selectLegionNH_Guldan_orderBriefHealA:SetScript("OnClick", function() SendChatMessage("1st Healing CD when |cff71d5ff|Hspell:208806:0|h[Black Harvest]|h|r : "..selectLegionNH_Guldan_orderHealA:GetText(), chatType) end) 
local selectLegionNH_Guldan_orderBriefHealB = CreateButton(selectLegionNH_Guldan, 22, 22, 'RIGHT', selectLegionNH_Guldan_orderActHealB, 'LEFT', -1, 0, "B")
selectLegionNH_Guldan_orderBriefHealB:SetScript("OnClick", function() SendChatMessage("2nd Healing CD when |cff71d5ff|Hspell:208806:0|h[Black Harvest]|h|r : "..selectLegionNH_Guldan_orderHealB:GetText(), chatType) end) 
local selectLegionNH_Guldan_orderBriefHealC = CreateButton(selectLegionNH_Guldan, 22, 22, 'RIGHT', selectLegionNH_Guldan_orderActHealC, 'LEFT', -1, 0, "B")
selectLegionNH_Guldan_orderBriefHealC:SetScript("OnClick", function() SendChatMessage("3rd Healing CD when |cff71d5ff|Hspell:208806:0|h[Black Harvest]|h|r : "..selectLegionNH_Guldan_orderHealC:GetText(), chatType) end) 
local selectLegionNH_Guldan_orderBriefHealD = CreateButton(selectLegionNH_Guldan, 22, 22, 'RIGHT', selectLegionNH_Guldan_orderActHealD, 'LEFT', -1, 0, "B")
selectLegionNH_Guldan_orderBriefHealD:SetScript("OnClick", function() SendChatMessage("4rd Healing CD when |cff71d5ff|Hspell:208806:0|h[Black Harvest]|h|r : "..selectLegionNH_Guldan_orderHealD:GetText(), chatType) end) 

local selectLegionNH_Guldan_stack = CreateButton(selectLegionNH_Guldan, 80, 22, 'TOP', selectLegionNH_Guldan_orderHealD, 'BOTTOM', -3, -2, "Stack |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:12:12|t")
selectLegionNH_Guldan_stack:SetScript("OnClick", function() SendChatMessage("Stack on Moon{달} for healer's cooldowns spell", chatType) end)
local selectLegionNH_Guldan_Souls = CreateButton(selectLegionNH_Guldan, 80, 22, 'TOP', selectLegionNH_Guldan_stack, 'BOTTOM', 0, -2, "Souls")
selectLegionNH_Guldan_Souls:SetScript("OnClick", function() SendChatMessage("Remove the souls! Hurry up!", chatType) end)

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
ClearFrameAll()

-- todo
-- DBM 연동 / 또는 직접 이벤트 체크해서 자동 메세징(따로 누르기 정신 사납다)
