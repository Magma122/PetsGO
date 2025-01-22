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
            for _, orb in pairs(Orbs:GetChildren()) do
                table.insert(AllOrbs, orb)
                local player = game.Players.LocalPlayer

                while true do
                    local playerPosition = player.Character.HumanoidRootPart.Position
                    local objectPosition = orb.Position

                    local direction = (playerPosition - objectPosition).unit
                    orb.Position = objectPosition + direction * 5 * wait()

                    wait(0.1) -- Настройте время ожидания для более плавного движения
                end

            end
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Orbs: Collect"):FireServer(AllOrbs)
                
            wait(0.01)
        end
    end)

    Options.AutoRoll:SetValue(false)    
    Options.OrbToggle:SetValue(false)    
end