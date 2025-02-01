repeat task.wait(0.1) until game:IsLoaded() and game.Players.LocalPlayer and game:GetService("HttpService")

local currentTime = os.date("%H:%M:%S|%d.%m")
print("Work|" .. currentTime)

queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

if syn and syn.queue_on_teleport then
    syn.queue_on_teleport([[
        repeat task.wait(0.1) until game:IsLoaded() and game.Players.LocalPlayer and game:GetService("HttpService")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Magma122/TradingPlaza/refs/heads/main/adsd.lua"))()
    ]])
elseif queue_on_teleport then
    queue_on_teleport([[
        repeat task.wait(0.1) until game:IsLoaded() and game.Players.LocalPlayer and game:GetService("HttpService")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Magma122/TradingPlaza/refs/heads/main/adsd.lua"))()
    ]])
end

--Main
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Pets Go",
    SubTitle = "fun farm",
    TabWidth = 200,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Preview = Window:AddTab({ Title = "Preview", Icon = "eye" }),
    General = Window:AddTab({ Title = "General", Icon = "swords" }),
    MiningOre = Window:AddTab({ Title = "Mining of ore", Icon = "rbxassetid://127838018891006" }),
    Fishing = Window:AddTab({ Title = "Fishing", Icon = "rbxassetid://16028878947" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- Preview
do
    Tabs.Preview:AddParagraph({
        Title = "Pets GO",
        Content = "This script was created for fun."
    })

    Tabs.Preview:AddButton({
        Title = "Discord",
        Description = "subscribe",
        Callback = function()
            print("nope")
        end
    })
end


-- General
local General = loadstring(game:HttpGet("https://raw.githubusercontent.com/Magma122/PetsGO/refs/heads/main/General.lua"))()
General(Tabs, Options)
-- MiningOre
local MiningOre = loadstring(game:HttpGet("https://raw.githubusercontent.com/Magma122/PetsGO/refs/heads/main/MiningOre.lua"))()
MiningOre(Tabs, Options)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("PetsGO_FUN")
SaveManager:SetFolder("PetsGO_FUN/Config")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "PetsGO_FUN",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()