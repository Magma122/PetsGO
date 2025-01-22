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
            for _, orb in pairs(Orbs:GetChildren()) do
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Orbs: Collect"):FireServer(orb)
                print(orb)
            end
                            
            wait(0.01)
        end
    end)

    Options.AutoRoll:SetValue(false)    
    Options.OrbToggle:SetValue(false)    
end