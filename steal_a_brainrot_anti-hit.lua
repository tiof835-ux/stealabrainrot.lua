local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

-- Create loading screen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 50)
textLabel.Position = UDim2.new(0, 0, 0.5, -25)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextScaled = true
textLabel.Font = Enum.Font.GothamBold
textLabel.Text = "Created by thc"
textLabel.Parent = frame

-- Show loading screen for 3 seconds
wait(3)
screenGui:Destroy()

-- Anti-hit and no damage script
-- This will disable any damage to the player and prevent hits

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Prevent health from decreasing
humanoid.HealthChanged:Connect(function(health)
    if health < humanoid.MaxHealth then
        humanoid.Health = humanoid.MaxHealth
    end
end)

-- Prevent knockback or hit effects by setting platform stand and anchoring parts
local function antiHit()
    if character and character.Parent then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                part.Anchored = false
                part.CanCollide = true
            end
        end
        humanoid.PlatformStand = false
    end
end

antiHit()

-- Continuously enforce anti-hit
RunService.Heartbeat:Connect(function()
    if character and character.Parent then
        antiHit()
        if humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end
end)

-- Optional: Prevent ragdoll or knockback by setting Humanoid state
humanoid.StateChanged:Connect(function(oldState, newState)
    if newState == Enum.HumanoidStateType.FallingDown or newState == Enum.HumanoidStateType.Ragdoll then
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end)
