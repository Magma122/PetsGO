local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Pets Go",
    SubTitle = "fun farm",
    TabWidth = 200,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Preview = Window:AddTab({ Title = "Preview", Icon = "eye" }),
    MiningOre = Window:AddTab({ Title = "Mining of ore", Icon = "" }),
    Fishing = Window:AddTab({ Title = "Fishing", Icon = "rbxassetid://16028878219" }),
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

-- MiningOre
loadstring(game:HttpGet("https://raw.githubusercontent.com/Magma122/PetsGO/refs/heads/main/MiningOfOre.lua"))()



SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()