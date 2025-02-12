return function(Tabs, Options)
    local FishingPools = Tabs.Fishing:AddDropdown("FishingPools", {
        Title = "Fishing Pools",
        Values = {"Default", "Ice", "Corrupted"},
        Multi = false,
        Default = 1,
    })

    FishingPools:SetValue("Default")

    FishingPools:OnChanged(function(Value)
        getgenv().FishingPool = Value
    end)

    local FishToggle = Tabs.Fishing:AddToggle("AutoFish", {
        Title = "Auto Fish",
        Default = false
    })

    local FishingPadPosition = {} 
    for _, FishingPad in ipairs(game:GetService("CollectionService"):GetTagged("FishingPad")) do
        FishingPadPosition[FishingPad.Name] = FishingPad.PadGlow.Position
    end

    FishToggle:OnChanged(function()
        local Player_upvr = require(game.ReplicatedStorage.Library.Player)
        repeat
            for _, FishingPad in ipairs(game:GetService("CollectionService"):GetTagged("FishingPad")) do
                if FishingPad.Name == getgenv().FishingPool then
                    FishingPad.PadGlow.Position = Player_upvr.Optional.Position()
                else
                    FishingPad.PadGlow.Position = FishingPadPosition[FishingPad.Name]
                end
            end
            task.wait(0.015)
        until not Options.AutoFish.Value

        if not Options.AutoFish.Value then
            for _, FishingPad in ipairs(game:GetService("CollectionService"):GetTagged("FishingPad")) do
                FishingPad.PadGlow.Position = FishingPadPosition[FishingPad.Name]
            end
        end
    end)
end