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

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")

RunService.RenderStepped:Connect(function()
    local closestEnemy, shortestDistance = nil, math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Team ~= lp.Team and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestEnemy = player
            end
        end
    end

    if closestEnemy then
        local char = lp.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.lookAt(char.HumanoidRootPart.Position, closestEnemy.Character.HumanoidRootPart.Position)
        end
    end
end) 

local lp = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Velocity.Magnitude > 5 then
                part.Velocity = part.Velocity * 3
            end
        end
    end
end)
