
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
