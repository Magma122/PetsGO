return function(Tabs, Options)
    local RollToggle = Tabs.General:AddToggle("AutoRoll", {
        Title = "Mining Merchant Buy ALL", 
        Description = "You can choose the ore to mine.",
        Default = false
    })

    RollToggle:OnChanged(function()
        while Options.AutoRoll.Value do
            for i = 1, 8 do
                local args = {
                    [1] = "MiningMerchant",
                    [2] = i
                }
                
                pcall(game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CustomMerchants_Purchase"):InvokeServer(unpack(args)))
            end
        end
    end)

    Options.AutoRoll:SetValue(false)    
end