return function(Tabs, Options)
    local FishingPools = Tabs.Main:AddDropdown("FishingPools", {
        Title = "Fishing Pools",
        Values = {"Default", "Ice", "Corrupted"},
        Multi = false,
        Default = 1,
    })

    FishingPools:SetValue("Default")

    FishingPools:OnChanged(function(Value)
        getgenv().FishingPool = Value
    end)

    local FishToggle = Tabs.General:AddToggle("AutoFish", {
        Title = "Auto Fish",
        Default = false
    })


    local FishingPoolsVector = { Default = Vector3.new(-210.01353454589844, 2.5361175537109375, 217.13662719726562),
    Ice = Vector3.new(-287.4568786621094, -1.125335454940796, 215.4885711669922),
    Corrupted = Vector3.new(-285.1300964355469, -0.7568280696868896, 92.8943099975586) }

    FishToggle:OnChanged(function()
        local Player_upvr = require(game.ReplicatedStorage.Library.Player)
        if Options.AutoFish.Value then
            Player_upvr.Optional.Position = function(...)
                return FishingPoolsVector[getgenv().FishingPool]
            end
        else
            Player_upvr.Optional.Position = function(...)
                local any_Character_result1_2 = Player_upvr.Optional.Character(...)
                if not any_Character_result1_2 then
                    return nil
                end
                return any_Character_result1_2:GetPivot().Position
            end
        end
    end)
end