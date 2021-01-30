LootRoll = LibStub("AceAddon-3.0"):NewAddon("LootRoll", "AceConsole-3.0", "AceEvent-3.0")

local options = {
    name = "LootRoll",
    handler = LootRoll,
    type = 'group',
    args = {
        msg = {
            type = "input",
            name = "Message",
            desc = "The message to be displayed when you get home.",
            usage = "<Your message>",
            get = "GetMessage",
            set = "SetMessage",
        },
        box = {
            type = "toggle",
            name = "Foo",
            desc = "The message to be displayed when you get home.",
            get = "GetMessage",
            set = "SetMessage",
        },
    },
}



function LootRoll:OnInitialize()
    LibStub("AceConfig-3.0"):RegisterOptionsTable("LootRoll", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("LootRoll", "LootRoll")
    self:RegisterChatCommand("lootroll", "ChatCommand")
    self:RegisterChatCommand("lr", "ChatCommand")
    LootRoll.message = "foobar"
end

function LootRoll:OnEnable()
    self:Print("Hello World!")
    self:RegisterEvent("CHAT_MSG_SAY")
end

function LootRoll:OnDisable()
    -- Called when the addon is disabled
end

function LootRoll:GetMessage(info)
    return self.message
end

function LootRoll:SetMessage(info, newValue)
    self.message = newValue
end

local frame = LibStub("AceGUI-3.0"):Create("Frame")
frame:SetTitle("Loot Roll")
frame:SetStatusText("AceGUI-3.0 Example Container Frame - |cff9d9d9d|Hitem:3299::::::::20:257::::::|h[Fractured Canine]|h|r")
frame:SetCallback("OnClose", function(widget) LibStub("AceGUI-3.0"):Release(widget) end)
frame:SetLayout("Flow")

local editbox = LibStub("AceGUI-3.0"):Create("EditBox")
editbox:SetLabel("Insert text:")
editbox:SetWidth(200)
frame:AddChild(editbox)

local button = LibStub("AceGUI-3.0"):Create("Button")
button:SetText("Click Me!")
button:SetWidth(200)
frame:AddChild(button)

local desc = LibStub("AceGUI-3.0"):Create("Label")
desc:SetImage("Interface\\Icons\\Spell_Nature_ElementalShields")
desc:SetText("Text here\nMore")
desc:SetFullWidth(true)
-- desc:SetJustifyH("CENTER")
-- desc:SetFont(nil, 30)
frame:AddChild(desc)

local icon = LibStub("AceGUI-3.0"):Create("Icon")
icon:SetImage("Interface\\Icons\\Spell_Nature_ElementalShields")
icon:SetCallback("OnClick", function ()
    print("foo")
end)
icon:SetCallback("OnEnter", function()
    GameTooltip:SetOwner(icon.frame, "ANCHOR_NONE")
    GameTooltip:SetPoint("BOTTOMRIGHT",icon.frame,"TOPLEFT", 30, -5)
    GameTooltip:SetHyperlink("|cff9d9d9d|Hitem:3299::::::::20:257::::::|h[Fractured Canine]|h|r")
    GameTooltip:Show()
end)
icon:SetCallback("OnLeave", function()
    GameTooltip:Hide()
end)
frame:AddChild(icon)

local foobar = LibStub("AceGUI-3.0"):Create("Icon")
foobar:SetImage("Interface\\Icons\\Spell_Nature_ElementalShields")
-- foobar:SetImageSize(20, 20)
foobar:SetCallback("OnClick", function ()
    print("foo")
end)
foobar:SetCallback("OnEnter", function()
    GameTooltip:SetOwner(foobar.frame, "ANCHOR_NONE")
    GameTooltip:SetPoint("BOTTOMRIGHT",foobar.frame,"TOPLEFT", 30, -5)
    GameTooltip:SetText("kek")
    GameTooltip:Show()
end)
foobar:SetCallback("OnLeave", function()
    GameTooltip:Hide()
end)
frame:AddChild(foobar)

function LootRoll:CHAT_MSG_SAY(event, ...)
    arg1, arg2, arg3, arg4, arg5 = ...
    self:Print(event)
    self:Print(arg1)
    self:Print(arg2)
    self:Print(arg3)
    self:Print(arg4)
    self:Print(arg5)
    desc:SetText("Event: " .. event)
end

function LootRoll:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    elseif input == "show" then
        frame:Show()
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("lr", "LootRoll", input)
    end
end