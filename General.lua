return function(Tabs, Options)
    local RollToggle = Tabs.General:AddToggle("AutoRoll", {
        Title = "Auto Roll Dice", 
        Default = false
    })

    RollToggle:OnChanged(function()
        while Options.AutoRoll.Value do
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Eggs_Roll"):InvokeServer()
            -- Add potion
        end
    end)

    Options.AutoRoll:SetValue(false)    
end