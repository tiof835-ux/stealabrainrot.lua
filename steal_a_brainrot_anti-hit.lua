local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Anti-hit script for Delta in Steal a Brainrot
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local enemyHRP = player.Character.HumanoidRootPart
            local distance = (HumanoidRootPart.Position - enemyHRP.Position).Magnitude
            if distance < 10 then -- Adjust range as needed
                -- Move away quickly to avoid hits
                local direction = (HumanoidRootPart.Position - enemyHRP.Position).Unit
                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + direction * 5
            end
        end
    end
end)
