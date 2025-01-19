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
do
    local FarmOreDropdown = Tabs.MiningOre:AddDropdown("MultiDropdown", {
        Title = "Mining of Ore",
        Description = "You can choose the ore to mine.",
        Values = {  "Dirty", "Stone", "Copper", "Iron", "Gold", "Emerald", "Obsidian1", "Obsidian2",
                    "Runic1", "Runic2", "Magma" },
        Multi = true,
        Default = {},
    })

    local ore = { Dirty = 6, Stone = 5, Copper = 3, Iron = 2, Gold = 1,
                    Emerald = 4, Obsidian1 = 10, Obsidian2 = 9,
                    Runic1 = 8, Runic2 = 7, Magma = 11 }

    FarmOreDropdown:OnChanged(function(Value)
        getgenv().FarmOres = {}
        table.clear(getgenv().FarmOres)

        for Value, _ in pairs(Value) do
            table.insert(getgenv().FarmOres, ore[Value])
        end
        while #getgenv().FarmOres ~= 0 do
            for _, n in ipairs(getgenv().FarmOres) do
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(n)
                wait(getgenv().miningSpeed)
            end
        end
    end)

    local waitSlider = Tabs.MiningOre:AddSlider("Slider", {
        Title = "Mining speed",
        Description = "This is a slider for changing the mining speed.",
        Default = 0.01,
        Min = 0.001,
        Max = 0.1,
        Rounding = 3,
        Callback = function(Value)
            getgenv().miningSpeed = Value
        end
    })

    local Toggle = Tabs.MiningOre:AddToggle("MiningMerchant", {
        Title = "Mining Merchant Buy ALL", Default = false
    })

    Toggle:OnChanged(function()
        while Options.MiningMerchant.Value do
            for i = 1, 8 do
                local args = {
                    [1] = "MiningMerchant",
                    [2] = i
                }
                
                pcall(game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CustomMerchants_Purchase"):InvokeServer(unpack(args)))
            end
        end
    end)

    Options.MiningMerchant:SetValue(false)    
end


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