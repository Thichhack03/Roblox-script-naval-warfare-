local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

-- GOD MODE: Hồi máu mỗi 0.2s
spawn(function()
    while true do
        local char = lp.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Health = char.Humanoid.MaxHealth
        end
        wait(0.2)
    end
end)

-- ESP cho địch (đỏ) và đồng minh (xanh)
function createESP(model, color)
    if not model:FindFirstChild("Highlight") then
        local hl = Instance.new("Highlight")
        hl.FillColor = color
        hl.FillTransparency = 0
        hl.OutlineTransparency = 1
        hl.Parent = model
    end
end

RunService.RenderStepped:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            local color = (plr.Team == lp.Team) and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(255, 0, 0)
            createESP(plr.Character, color)
        end
    end
end)

local autoAim = false
local btn = Instance.new("TextButton")
btn.Text = "Auto Aim: OFF"
btn.Size = UDim2.new(0, 140, 0, 40)
btn.Position = UDim2.new(0.01, 0, 0.1, 0)
btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Parent = game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")

btn.MouseButton1Click:Connect(function()
    autoAim = not autoAim
    btn.Text = "Auto Aim: " .. (autoAim and "ON" or "OFF")
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if not autoAim then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Team ~= lp.Team and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = CFrame.lookAt(lp.Character.HumanoidRootPart.Position, plr.Character.HumanoidRootPart.Position)
            break
        end
    end
end)

spawn(function()
    while true do
        local char = lp.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("VehicleSeat") or part:IsA("BasePart") then
                    if part:FindFirstChild("MaxSpeed") then
                        part.MaxSpeed = part.MaxSpeed * 3
                    end
                    if part:FindFirstChild("Throttle") then
                        part.Throttle = part.Throttle * 3
                    end
                end
            end
        end
        wait(1)
    end
end)
