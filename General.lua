return function(Tabs, Options)
    local RollToggle = Tabs.General:AddToggle("AutoRoll", {
        Title = "Auto Roll Dice", 
        Default = false
    })

    RollToggle:OnChanged(function()
        while Options.AutoRoll.Value do
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Eggs_Roll"):InvokeServer()
            wait(0.01)
            -- Add potion
        end
    end)

    local OrbToggle = Tabs.General:AddToggle("CollectOrbs", {
        Title = "Collect Orbs", 
        Default = false
    })

    OrbToggle:OnChanged(function()
        while Options.CollectOrbs.Value do
            local Orbs = game:GetService("Workspace"):WaitForChild("__THINGS"):WaitForChild("Orbs")
            local AllOrbs = {}
            for index, orb in pairs(Orbs:GetChildren()) do
                AllOrbs[index] = orb
            end
            print(unpack(AllOrbs))
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Orbs: Collect"):FireServer(AllOrbs)
                
            wait(0.01)
        end
    end)    
end